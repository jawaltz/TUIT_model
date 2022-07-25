        if rem_trials==0
            for block=1:(comp_runs)
                fprintf('Block: %d of %d\n', block, comp_runs);
                PE = vertcat(PE,[ret_all(block).rpe]);
                exp = vertcat(exp,[ret_all(block).explore]);
                std_f = vertcat(std_f,[ret_all(block).sdShort]);
                std_s = vertcat(std_s,[ret_all(block).sdLong]);
                mn_f = vertcat(mn_f,[ret_all(block).meanShort]);
                mn_s = vertcat(mn_s,[ret_all(block).meanLong]);
                Go = vertcat(Go,[ret_all(block).go]);
                NoGo = vertcat(NoGo,[ret_all(block).noGo]);
                rtobs = vertcat(rtobs,[ret_all(block).rtobs]);
                rtpred = vertcat(rtpred,[ret_all(block).rtpred]);
                fprintf('std_faster: %d; std_slower: %d\n', std_f, std_s);
            end
        end
        if rem_trials>0
            for block=1:(comp_runs+1)
                PE = vertcat(PE,[ret_all(block).rpe]);
                exp = vertcat(exp,[ret_all(block).explore]);
                std_f = vertcat(std_f,[ret_all(block).sdShort]);
                std_s = vertcat(std_s,[ret_all(block).sdLong]);
                mn_f = vertcat(mn_f,[ret_all(block).meanShort]);
                mn_s = vertcat(mn_s,[ret_all(block).meanLong]);
                Go = vertcat(Go,[ret_all(block).go]);
                NoGo = vertcat(NoGo,[ret_all(block).noGo]);
                rtobs = vertcat(rtobs,[ret_all(block).rtobs]);
                rtpred = vertcat(rtpred,[ret_all(block).rtpred]);
            end
        end
        
                for run=1:comp_runs
           dlmwrite(strcat('../outputs/regressor/',num2str(subject),'_exp_AM.txt'),exp(((run-1)*40+1):(run*40)),'-append','delimiter',' ','precision',5);
           dlmwrite(strcat('../outputs/regressor/',num2str(subject),'_explore_AM.txt'),rel_explore(((run-1)*40+1):(run*40)),'-append','delimiter',' ','precision',5);
           dlmwrite(strcat('../outputs/regressor/',num2str(subject),'_PE_AM.txt'),PE_store(((run-1)*40+1):(run*40)),'-append','delimiter',' ','precision',5);
           dlmwrite(strcat('../outputs/regressor/',num2str(subject),'_mean_unc_AM.txt'),mean_unc(((run-1)*40+1):(run*40)),'-append','delimiter',' ','precision',5);
        end
        if rem_trials>0
           dlmwrite(strcat('../outputs/regressor/',num2str(subject),'_exp_AM.txt'),exp(((comp_runs)*40+1):((comp_runs)*40+rem_trials)),'-append','delimiter',' ','precision',5);
           dlmwrite(strcat('../outputs/regressor/',num2str(subject),'_explore_AM.txt'),rel_explore(((comp_runs)*40+1):((comp_runs)*40+rem_trials)),'-append','delimiter',' ','precision',5);
           dlmwrite(strcat('../outputs/regressor/',num2str(subject),'_PE_AM.txt'),PE_store(((comp_runs)*40+1):((comp_runs)*40+rem_trials)),'-append','delimiter',' ','precision',5);
           dlmwrite(strcat('../outputs/regressor/',num2str(subject),'_mean_unc_AM.txt'),mean_unc(((comp_runs)*40+1):((comp_runs)*40+rem_trials)),'-append','delimiter',' ','precision',5);
        end
        plotSubjData(subjids(f), ret_all, model);