subj=[12677;12733;12770;12425;12834;12864;12900];
data=[];
for i = 1:length(subj)
    load(strcat('../outputs/parameter_mat/modelVars_',num2str(subj(i)),'orig.mat'));
    sub_ID = subj(i)*ones(size(rtobs));
    %data = [data;sub_ID PE rel_explore'];
    data = [data;sub_ID rtobs rtpred exp];
end
xlswrite('TC_RTForGoodSub',data);