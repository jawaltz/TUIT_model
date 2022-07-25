
 function [mySE] = TC_minSE(Params, sess_trn); 
 
global TrlType_Colmn Resp_Colmn FeedBck_Colmn Blk_Colmn;   
global Vstart   
global sess_trn1
global Go NoGo misc; 
global FitTrls;
    
mySE=0;
 
% trn_CEV = sess_trn(find(sess_trn(:,TrlType_Colmn) == 12), :);
% % pick out the CD trials
% trn_CEVR = sess_trn(find(sess_trn(:,TrlType_Colmn) == 34), :);
% % pick out the EF trials
% trn_DEV = sess_trn(find(sess_trn(:,TrlType_Colmn) == 56), :);
% trn_IEV = sess_trn(find(sess_trn(:,TrlType_Colmn) == 78), :);

 

Subj_Sess = unique(sess_trn(:,1:2), 'rows'); % number of subject sessions in input vector (this is just 1 if fitting each subject individually)

for subsessnum = 1:size(Subj_Sess,1)   % for fitting across group of subs, loop through each one, resetting V, Go/NoGo etc.

    Vstart=0;
    Go = zeros(1, 1);
    NoGo = zeros(1,1);
    misc =ones(1,1);


    %identify the subject and session (for group fits)
    this_subj = Subj_Sess(subsessnum, 1);
    s = Subj_Sess(subsessnum, 2); 
    subj_trn = sess_trn(find(sess_trn(:,1) == this_subj), :);
    % pick out the trials corresponding to this session 
    sess_trn1 = subj_trn(find(subj_trn(:,2) == s), :);
 
   
    trn_blk1 = sess_trn1(find(sess_trn1(:,Blk_Colmn) == 1), :); % first block
    trn_blk2 = sess_trn1(find(sess_trn1(:,Blk_Colmn) == 2), :);
    trn_blk3 = sess_trn1(find(sess_trn1(:,Blk_Colmn) == 3), :);
    trn_blk4 = sess_trn1(find(sess_trn1(:,Blk_Colmn) == 4), :);
    trn_blk5 = sess_trn1(find(sess_trn1(:,Blk_Colmn) == 5), :);
    trn_blk6 = sess_trn1(find(sess_trn1(:,Blk_Colmn) == 6), :);
 
    FitTrls= max(40, size(trn_blk1,1)); % by default fit all trials
    
    % FitTrls=80; % just fit first 80 trials
    
    % construct reward and rt vectors
    RT_1 = trn_blk1(1:min(FitTrls,length(trn_blk1)), Resp_Colmn);
   % RTl_1 = log(trn_blk1(1:min(FitTrls,length(trn_blk1)), Resp_Colmn)); % in case want to use log rt's
    Reward_1= trn_blk1(1:min(FitTrls,length(trn_blk1)),FeedBck_Colmn);

    RT_2 = trn_blk2(1:min(FitTrls,length(trn_blk2)), Resp_Colmn);
   % RTl_2 = log(trn_blk2(1:min(FitTrls,length(trn_blk2)), Resp_Colmn));
    Reward_2= trn_blk2(1:min(FitTrls,length(trn_blk2)),FeedBck_Colmn);

    RT_3 = trn_blk3(1:min(FitTrls,length(trn_blk3)), Resp_Colmn);
   % RTl_3 = log(trn_blk3(1:min(FitTrls,length(trn_blk3)), Resp_Colmn));
    Reward_3= trn_blk3(1:min(FitTrls,length(trn_blk3)),FeedBck_Colmn);

    RT_4 = trn_blk4(1:min(FitTrls,length(trn_blk4)), Resp_Colmn);
   % RTl_4 = log(trn_blk4(1:min(FitTrls,length(trn_blk4)), Resp_Colmn));
    Reward_4= trn_blk4(1:min(FitTrls,length(trn_blk4)),FeedBck_Colmn);
    
    RT_5 = trn_blk5(1:min(FitTrls,length(trn_blk5)), Resp_Colmn);
   % RTl_5 = log(trn_blk3(1:min(FitTrls,length(trn_blk5)), Resp_Colmn));
    Reward_5= trn_blk5(1:min(FitTrls,length(trn_blk5)),FeedBck_Colmn);

    RT_6 = trn_blk6(1:min(FitTrls,length(trn_blk6)), Resp_Colmn);
   % RTl_6 = log(trn_blk6(1:min(FitTrls,length(trn_blk6)), Resp_Colmn));
    Reward_6= trn_blk6(1:min(FitTrls,length(trn_blk6)),FeedBck_Colmn);


    avgRT = mean(sess_trn1(1:min(FitTrls,length(trn_blk1)),Resp_Colmn));
    

    fit_smooth =1; % fit smoothed data
    window=5;
    mean_dev =0;


    if(mean_dev==1) RT_1 = RT_1 - avgRT;
        RT_2 = RT_2 - avgRT;
        RT_3 = RT_3 - avgRT;
        RT_4 = RT_4 - avgRT;
        RT_5 = RT_5 - avgRT;
        RT_6 = RT_6 - avgRT;
    end;

    if mean_dev==1 avgRT =0; % if mean deviating then average should now be 0.
    end

     if(fit_smooth==1) fitRT1 = smooth(RT_1,window);
         fitRT2 = smooth(RT_2,window);
         fitRT3 = smooth(RT_3,window);
         fitRT4 = smooth(RT_4,window);
         fitRT5 = smooth(RT_5,window);
         fitRT6 = smooth(RT_6,window);

% if(fit_smooth==1) fitRT1 = ksr(1:size(RT_1,1),RT_1);
%     fitRT2 = ksr(1:FitTrls,RT_2);
%     fitRT3 = ksr(1:FitTrls,RT_3);
%     fitRT4 = ksr(1:FitTrls,RT_4); 

    else fitRT1 =RT_1;
        fitRT2 =RT_2;
        fitRT3 =RT_3;
        fitRT4 =RT_4;
        fitRT5 =RT_5;
        fitRT6 =RT_6;
    end;

    global RTpred;
    RTpred=[];
    global RTpredCEV RTpredCEVR RTpredDEV RTpredIEV;

    global CEV_misc CEVR_misc DEV_misc IEV_misc;

    RTpredCEV=[]; RTpredCEVR= []; RTpredDEV= []; RTpredIEV=[];
    CEV_misc=[]; CEVR_misc= []; DEV_misc= []; IEV_misc=[];

    if ~(isempty(trn_blk1))

        cond= trn_blk1(1,TrlType_Colmn);
        [RTpred_1  misc_1a misc_1b] = TC_Alg(RT_1, Reward_1, Params, avgRT, cond);
      RTdiffs1 = (fitRT1 - RTpred_1).^2;
 
        mySE = mySE + sum(RTdiffs1);
        RTpred =[RTpred; RTpred_1];
        ConvertRTs(trn_blk1, RTpred_1, misc_1a, misc_1b);
    end

    if ~(isempty(trn_blk2))
        
     cond= trn_blk2(1,TrlType_Colmn);
        [RTpred_2  misc_2a misc_2b] = TC_Alg(RT_2, Reward_2, Params, avgRT, cond);

         RTdiffs2 = (fitRT2 - RTpred_2).^2;
 
        mySE = mySE + sum(RTdiffs2);
        RTpred =[RTpred; RTpred_2];
        ConvertRTs(trn_blk2, RTpred_2, misc_2a, misc_2b);
    end

    if ~(isempty(trn_blk3))

     cond= trn_blk3(1,TrlType_Colmn);
        [RTpred_3 misc_3a misc_3b] = TC_Alg(RT_3, Reward_3, Params, avgRT, cond);

         RTdiffs3 = (fitRT3 - RTpred_3).^2;
 
        mySE = mySE + sum(RTdiffs3);
        RTpred =[RTpred; RTpred_3];

        ConvertRTs(trn_blk3, RTpred_3, misc_3a, misc_3b);
    end


    if ~(isempty(trn_blk4))

        cond= trn_blk4(1,TrlType_Colmn);
        [RTpred_4 misc_4a misc_4b] = TC_Alg(RT_4, Reward_4, Params, avgRT, cond);

        RTdiffs4 = (fitRT4 - RTpred_4).^2;
 
        mySE = mySE + sum(RTdiffs4);
        RTpred =[RTpred; RTpred_4];

        ConvertRTs(trn_blk4, RTpred_4, misc_4a, misc_4b);


    end

    if ~(isempty(trn_blk5))

        cond= trn_blk5(1,TrlType_Colmn);
        [RTpred_5 misc_5a misc_5b] = TC_Alg(RT_5, Reward_5, Params, avgRT, cond);

        RTdiffs5 = (fitRT5 - RTpred_5).^2;
 
        mySE = mySE + sum(RTdiffs5);
        RTpred =[RTpred; RTpred_5];

        ConvertRTs(trn_blk5, RTpred_5, misc_5a, misc_5b);


    end
    
    if ~(isempty(trn_blk6))

        cond= trn_blk6(1,TrlType_Colmn);
        [RTpred_6 misc_6a misc_6b] = TC_Alg(RT_6, Reward_6, Params, avgRT, cond);

        RTdiffs6 = (fitRT6 - RTpred_6).^2;
 
        mySE = mySE + sum(RTdiffs6);
        RTpred =[RTpred; RTpred_6];

        ConvertRTs(trn_blk6, RTpred_6, misc_6a, misc_6b);


    end
    
    if(length(sess_trn)>1000) RTGene_preds_Gp; end % only applies if doing group fits..
end

mySE = mySE;

