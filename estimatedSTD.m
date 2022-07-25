data=xlsread('../TC-MRI_wBlock.xls');
%data(data(:,4)==0,:)=[];
subid=unique(data(:,1));
n=5; 
for i = 1:length(subid)
    subdata = data(data(:,1)==subid(i),:);
    unc(i,1) = subid(i);
    for k = 1:4
        RT = subdata(subdata(:,3)==k,4)/1000;
        RT_avg=arrayfun(@(j) mean(RT(j:j+n-1)),1:n:length(RT)-n+1)';
        unc(i,k+1) = std(RT_avg);
    end
        
end