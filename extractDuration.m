subjdir='../';
subjfiles=dir('../TC-MRI_wBlock.txt');

[subjdata, subjids] = loadTCRun(strcat(subjdir,subjfiles.name));
for f = 1:size(subjdata,1)
    RT=subjdata{f}(:,4)/1000;
    RT=RT';
    for run=1:6
           dlmwrite(strcat('../outputs/regressor/',num2str(subjids(f)),'_TMs.txt'),RT(((run-1)*40+1):(run*40)),'-append','delimiter',' ','precision',5);
    end
end