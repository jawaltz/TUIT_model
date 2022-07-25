%% This script will plot observed RT and predicted RT for each group and each condition with every 5 trials averaged
% to plot control group, please change subSZ after line 11 with subNC

subjdir='../';
subjfiles=dir('../TC-MRI_wBlock.txt');
n=5; % average evert 5 trials

[subjdata, subjids] = loadTCRun(strcat(subjdir,subjfiles.name));
subNC=[12352 12405 12541 12546 12568 12594 12669 12670 12671 12675 12677 ...
    12678 12684 12691 12693 12700 12706 12730 12733 12734 12735 12752 12758 12770 13018 13067 13095];

subSZ=[12380 12390 12425 12427 12463 12468 12505 12609 12614 12616 12645 ...
    12679 12787 12790 12833 12834 12863 12864 12874 12882 12900 12906 12953 12962 13063 13125];

% subjdata=subjdata(subjdata(:,1)==subNC,:);
% subjids=subNC;
RTobs = zeros(240,length(subSZ));
RTpred = zeros(240,length(subSZ));

for f = 1:length(subSZ)
    load(strcat('../outputs/parameter_mat/modelVars_',num2str(subSZ(f)),'orig.mat'));
    condition = subjdata{subjids==subSZ(f)}(:,3);
    RT_dum1 = [condition rtobs];
    [~, d2] = sort(RT_dum1(:,1));
    
    RTobs(:,f) = RT_dum1(d2,2);
    RT_dum2 = [condition rtpred];
    [~, d2] = sort(RT_dum2(:,1));
    RTpred(:,f) = RT_dum2(d2,2);
end
RTobs_sum = mean(RTobs,2);
RTpred_sum = mean(RTpred,2);

RTobs_DEV = (RTobs_sum(1:40) + RTobs_sum(41:80))/2; % two runs for DEV and take average of the two
RTobs_IEV = (RTobs_sum(81:120)+RTobs_sum(121:160))/2; % two runs for IEV and take average of the two

RTobs_CEV = RTobs_sum(161:200); RTobs_CEVr = RTobs_sum(201:240);
RTobs_DEVs=arrayfun(@(j) mean(RTobs_DEV(j:j+n-1)),1:n:length(RTobs_DEV)-n+1);
RTobs_IEVs=arrayfun(@(j) mean(RTobs_IEV(j:j+n-1)),1:n:length(RTobs_IEV)-n+1);
RTobs_CEVrs=arrayfun(@(j) mean(RTobs_CEVr(j:j+n-1)),1:n:length(RTobs_CEVr)-n+1);
RTobs_CEVs=arrayfun(@(j) mean(RTobs_CEV(j:j+n-1)),1:n:length(RTobs_CEV)-n+1);

RTpred_DEV = (RTpred_sum(1:40)+ RTpred_sum(41:80))/2;
RTpred_IEV = (RTpred_sum(81:120) + RTpred_sum(121:160))/2;

RTpred_CEV = RTpred_sum(161:200); RTpred_CEVr = RTpred_sum(201:240);
RTpred_DEVs=arrayfun(@(j) mean(RTpred_DEV(j:j+n-1)),1:n:length(RTpred_DEV)-n+1);
RTpred_IEVs=arrayfun(@(j) mean(RTpred_IEV(j:j+n-1)),1:n:length(RTpred_IEV)-n+1);
RTpred_CEVrs=arrayfun(@(j) mean(RTpred_CEVr(j:j+n-1)),1:n:length(RTpred_CEVr)-n+1);
RTpred_CEVs=arrayfun(@(j) mean(RTpred_CEV(j:j+n-1)),1:n:length(RTpred_CEV)-n+1);

plot(RTobs_IEVs,'r','LineWidth',2);hold on
plot(RTobs_DEVs,'b','LineWidth',2);plot(RTobs_CEVrs,'m','LineWidth',2);
plot(RTobs_CEVs,'k','LineWidth',2);
axis([1 8 1500 2800]);ylabel('RT (ms)',  'FontSize', 24);
legend({'IEV','DEV','CEVr','CEV'});
title('Observed RT for Patients', 'FontSize',30);

figure;
plot(RTpred_IEVs,'r','LineWidth',2);hold on
plot(RTpred_DEVs,'b','LineWidth',2);plot(RTpred_CEVrs,'m','LineWidth',2);
plot(RTpred_CEVs,'k','LineWidth',2);
axis([1 8 1500 2800]);ylabel('RT (ms)',  'FontSize', 24);
legend({'IEV','DEV','CEVr','CEV'});
title('Predicted RT for Patients', 'FontSize',30);
