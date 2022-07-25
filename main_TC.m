%clear all

%modified by jw to add intercept model 191023

%initialize global definitions
globdefs

generative = 0; % generative model that makes its own choices and gets reward rather than fitting subject data.
multstart = 1; % use multiple starting points for gradient descent.

%initialize optimizer settings
options = optimset(@fmincon);
%options = optimset(options, 'LargeScale', 'off');

%subject directory is relative to this fit_behavior directory.
subjdir='../DataForModeling/TUIT-EEG_DataForModeling/';
%subjdir='../DataForModeling/TUIT-MRI_DataForModeling/';
%subjfiles='TC-MRI_ForModeling_171229_HV.txt';
%subjfiles='TC-MRI_ForModeling_171229_SZ.txt';
grname='_EEG_200310R3';
%grname='_MRI_200302';
%subjfiles='TC-MRI_ForModeling_171229_FDR.txt';
%subjfiles='TC-MRI_ForModeling_All_200302.txt';
%subjfiles='TC-MRI_ForModeling_171229_MDD.txt';
%subjfiles='TC-MRI_ForModeling_171229_Fixed.txt';
%subjfiles='TC-MRI_ForModeling_171229_N13695.txt';
%subjfiles='TC-MRI_ForModeling_171229_N12733.txt';
%subjfiles='TUIT_EEG_161021_ForModeling.txt';
%subjfiles='TUIT_EEG_191113_ForModeling.txt';
subjfiles='TUIT_REEG3_SZs_190122_ForModeling.txt';

[subjdata, subjids] = loadTCRun(subjfiles);

refit=0; %whether to refit a subject who has already been run.

%loop over and fit all models
%models = { 'orig' }; 
%models = { 'origsticky' }; 
%models = { 'origstickyNew' }; 
models = { 'intercept' }; 

for m = 1:length(models)
    model = models{m};
    bestFit_all = [];
    
    %for now, just fit per subject
    for f = 1:length(subjids)
        
%         if (exist(strcat('../outputs/parameter_mat/modelVars_', num2str(subjids(f)), model, '.mat'), 'file') > 0 && ~refit)
%             fprintf('Skipping: modelVars_%d%s.mat\n', subjids(f), model);
%             load(strcat('../outputs/parameter_mat/modelVars_', num2str(subjids(f)), model));
%             bestFit_all(f, :) = bestFit;
%             SEmin(f) = bestSE;
%             continue
%         end
        sess_trn1 = subjdata{f}
        tot_trials = int32(length(subjdata{f}))
        comp_runs = idivide(tot_trials, 40, 'floor')
        rem_trials = rem(tot_trials, 40);
        fprintf('Fitting: %d %s\n', subjids(f), model);
        fprintf('Fitting: %d %d\n', tot_trials, comp_runs);
        
        %get the parameter initial values and limits based on the model to be fit.
        [init_params, lower_limits, upper_limits] = getParamInitialization(model);
        
%         if strcmp(model, 'orig_scram') || strcmp(model, 'origsticky_scram')
%             emoSubset=find(strcmp(emoNames, 'scram'));
%         else
%             emoSubset=-1;
%         end
%         emoSubset=-1;
        
        if generative == 0
            
            %use multiple starting values?
            if multstart == 1
                num_start_pts = 5; % number of initial starting points
                DiffFmOptimal(f,:) = zeros(num_start_pts,1);
                
                opts = optimset('fmincon');
                opts.LargeScale = 'off';
                opts.Algorithm = 'active-set';
                opts.Display = 'none';
                
                %core fitting function -- returns results of length num_start_pts (5) above.
                %These contain fit estimates for each starting point.
                %Then identify the best-fitting output for use in analyses.
                [params, SE, exitflag, xstart] = rmsearch(@(params) TC_minSE(params, subjdata{f}), 'fmincon', init_params, ...
                    lower_limits, upper_limits, 'initialsample', num_start_pts, 'options', opts);
                
                SEmin(f)= min(SE);
                
                DiffFmOptimal(f,:) = SE - SEmin(f); % how different are the SSE values for each starting pt from optimal one
                
                %re-run TC_alg for all blocks with optimal parameters
                %[totalSqErr, ret_all] = TC_minSE(params(find(SE == min(SE), 1 ),:), subjdata{f});
                
                SavePredsFmBest(params(find(SE == min(SE), 1 ),:), subjdata{f}); % save predictions from best run of rmsearch
                
            else
                % use below line if just want to run one starting point (faster and
                % usually not far off from optimal.)
                [params, SE(f), exitflag] = fmincon(@(params) TC_minSE(params, subjdata{f}, model), init_params, [], [], [], [], lower_limits, upper_limits, [], options) ;
                [totalSqErr, ret_all] = TC_minSE(params(find(SE == min(SE), 1 ),:), subjdata{f}, model); %run once with best params... (can we get all this back from fmincon?)
                %SavePredsFmBest(params, subjdata{f});
                
                SEmin(f) = SE;
            end
            
            RTGene_preds;
            
        else % generative model, used for generating agent-based behavior
            
            SE = TC_minSE(init_params, subjdata{f}, model);
            %RTGene_preds;
            bestFit_all(f, :) = [this_subj s sqrt(SE)] % note these are sqrt of sum!
            
            SEmin(f) = SE;
        end
        
        if multstart==1
            %1 in this vector represents a dummy code for session (just have one session at the moment)
            bestFit_all(f, :) = [subjids(f) subjdata{f}(2,2) params(find(SE == min(SE), 1 ),:) sqrt(SEmin(f))]; % note errors are sqrt of sum!
        else
            bestFit_all(f, :) = [subjids(f) subjdata{f}(2,2) params' sqrt(SE(f))];
        end
        
        
        %for now, create vectors that correspond to what was present before (for checking against vetted code)
        subject = subjids(f);
        PE = [];
        exp = [];
        std_f = [];
        std_s = [];
        mn_f = [];
        mn_s = [];
        Go = [];
        NoGo = [];
        rtobs = [];
        rtpred = [];
        
bestFit = bestFit_all(f, :);
        bestSE = SEmin(f);
%       rel_explore = abs(std_f - std_s)';
        exp = exp';
        rel_explore = (std_f - std_s)';
        fprintf('rel_explore: %d\n', rel_explore);
        mean_unc = ((std_f + std_s)/2)';
        best_params = params((SE == min(SE)),:);
        
        %save(strcat('../outputs/parameter_mat/modelVars_', num2str(subjids(f)), model), 'subject',  'PE', 'exp', 'std_f', 'std_s', 'mn_f', 'mn_s', 'Go', 'NoGo', 'ret_all', 'bestFit', 'bestSE','rel_explore','mean_unc','rtobs','rtpred');
        %save(strcat('../outputs/parameter_mat/parameters_',num2str(subjids(f)), model), 'best_params');
        PE_store = PE';
        comp_runs

    end
    
    fname_bestFit=sprintf('SubjsSummary_%s%s.txt',model,grname);
    
    if strcmp(model, 'orig') || strcmp(model, 'orig_scram') || strcmp(model, 'intercept')
        hdr = {'Subject','Group','lambda','explore','alphaG','alphaN','K','nu','ignore','rho','SSE'};
    elseif strcmp(model, 'origsticky') || strcmp(model, 'origstickyNew')
        hdr = {'Subject','Group','lambda','explore','alphaG','alphaN','K','sticky_decay','ignore','rho','SSE'};
    elseif strcmp(model, 'emoexplore')
        hdr = {'Subject','Group','lambda','explore_scram', 'explore_fear', 'explore_happy', 'alphaG','alphaN','K','nu','ignore','rho','SSE'};
    elseif strcmp(model, 'emoexploresticky')
        hdr = {'Subject','Group','lambda','explore_scram', 'explore_fear', 'explore_happy', 'alphaG','alphaN','K','sticky_decay','ignore','rho','SSE'};
    elseif strcmp(model, 'emogonogo')
        hdr = {'Subject','Group','lambda','explore','alphaG_scram','alphaG_fear','alphaG_happy','alphaN_scram','alphaN_fear', 'alphaN_happy', 'K','nu','ignore','rho','SSE'};
    elseif strcmp(model, 'emogonogosticky')
        hdr = {'Subject','Group','lambda','explore','alphaG_scram','alphaG_fear','alphaG_happy','alphaN_scram','alphaN_fear', 'alphaN_happy', 'K','sticky_decay','ignore','rho','SSE'};
    elseif strcmp(model, 'emonogo')
        hdr = {'Subject','Group','lambda','explore','alphaG', 'alphaN_scram', 'alphaN_fear', 'alphaN_happy', 'K','nu','ignore','rho','SSE'};
    elseif strcmp(model, 'emonogosticky')
        hdr = {'Subject','Group','lambda','explore','alphaG', 'alphaN_scram', 'alphaN_fear', 'alphaN_happy', 'K','sticky_decay','ignore','rho','SSE'};
    end

    
    txt=sprintf('%s\t',hdr{:});
    txt(end)='';
    dlmwrite(fname_bestFit,txt,'');
    dlmwrite(fname_bestFit, bestFit_all,'-append','delimiter','\t','precision', '%6.5f');
    
    fname_trn = sprintf('GroupStats_%s%s.doc',model,grname);
    
    fid_Trn =fopen(fname_trn,'w');
    rSE_Trn_mean = mean(sqrt(SEmin));
    rSE_Trn_std = std(sqrt(SEmin));
    
    fprintf(fid_Trn,'%s \t', 'rSE_Trn_mean = ');
    fprintf(fid_Trn,'%f \n', rSE_Trn_mean);
    fprintf(fid_Trn,'%s \t', 'rSE_Trn_std = ');
    fprintf(fid_Trn,'%f \n', rSE_Trn_std);
    
    fclose(fid_Trn);
    
end

%MakeFigs
    
%clear
%matlabpool close