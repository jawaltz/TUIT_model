%tdef defines the column structure for the trial data used during fitting
global tdef;
global trialsPerBlock;
global trialLength;
global rewFuncNames;
global sess_trn1;
global FitTrls;
global Gp_Colmn
global TrlType_Colmn
global Resp_Colmn
global Blk_Colmn
global FeedBck_Colmn
global avg_RT
global cond
global j
global k

j=0;
k=0;
% global emoNames;

tdef.subj = 1;     %subject id
tdef.group = 2;     %session number
Gp_Colmn = tdef.group;
tdef.rewFunc = 3;  %contingency (CEV, CEVR, IEV, DEV)
TrlType_Colmn = tdef.rewFunc;
tdef.rt = 4;       %reaction time
Resp_Colmn = tdef.rt;
tdef.block = 5;    %block number
Blk_Colmn = tdef.block;
tdef.score = 6;    %points obtained
FeedBck_Colmn = tdef.score;
tdef.trial = 7;    %trial number
% tdef.emo = 9;      %emotion of face
% tdef.comt = 10;    %comt genotype (not used)
% tdef.d2 = 11;      %drd2 genotype (not used)
% tdef.d32 = 12;     %darpp32 genotype (not used)

FitTrls = 40;
trialsPerBlock = 40;
trialLength = 5000;

rewFuncNames = { 'IEV1' 'DEV1' 'CEVR' 'CEV' 'IEV2' 'DEV2'};
% emoNames = { 'happy' 'fear' 'scram' };