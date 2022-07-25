%tdef defines the column structure for the trial data used during fitting
global tdef;
global trialsPerBlock;
global trialLength;
global rewFuncNames;
% global emoNames;

tdef.subj = 1;     %subject id
% tdef.cb = 2;       %counterbalance order
tdef.group = 2;     %session number
tdef.block = 5;    %block number
%tdef.trial = 5;    %trial number
tdef.rt = 4;       %reaction time
tdef.rewFunc = 3;  %contingency (CEV, CEVR, IEV, DEV)
tdef.score = 6;    %points obtained
% tdef.emo = 9;      %emotion of face
% tdef.comt = 10;    %comt genotype (not used)
% tdef.d2 = 11;      %drd2 genotype (not used)
% tdef.d32 = 12;     %darpp32 genotype (not used)

trialsPerBlock = 40;
trialLength = 5000;

rewFuncNames = { 'DEV' 'IEV' 'CEV' 'CEVR' 'IEV2' 'DEV2'};
% emoNames = { 'happy' 'fear' 'scram' };