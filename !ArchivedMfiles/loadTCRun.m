function [subjdata, subjID]=loadTCRun(fname)
%function to load all subjects behavior data from clock task.
%
%input:
%   fname:  the filename of the .txt file containing all subject data
%
%output:
%   subj:   a cell containing relevant behavioral data to be fit

% global tdef;

if (exist(fname, 'file') > 0)
    allData = load(fname);
%     if ~exist('order','var'); error(strcat('Unable to load order structure from file: ', fname)); end
% else
%     error(strcat('File does not exist: ', fname));
end

subjID  = unique(allData(:,1)); 
subjNum = length(unique(allData(:,1))); % get the total number of subjects
subjdata = cell(subjNum,1); % 

%The merged subject .txt files contain the following elements:
%
% ntrials x 6 
%   ,1:  subject id
%   ,2:  group id                 #not used, 1 = FDR, 2 = NC, 3 = SZ
%   ,3:  reward function (1 2 3 4) #1 = CEV; 2 = DEV1; 3 = IEV1; 4 = CEVReverse     
%   ,4:  Score                    # points earned 
%   ,5:  block number (1:6)  
%   ,6:  RT (ms)
%   ,7:  Trials 

for i=1:subjNum
    subjdata{i} = allData(allData(:,1) ==  subjID(i),:);
end

end