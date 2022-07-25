function [] = ConvertRTs(trnblk, pred, misc1, misc2); 
global TrlType_Colmn
  global RTpredCEV RTpredCEVR RTpredDEV RTpredIEV
  global CEV_misc1 CEVR_misc1 DEV_misc1 IEV_misc1
  global CEV_misc2 CEVR_misc2 DEV_misc2 IEV_misc2

if(trnblk(1,TrlType_Colmn)==1)
        RTpredCEV = pred;
CEV_misc1 = misc1;
CEV_misc2 = misc2;

    elseif(trnblk(1,TrlType_Colmn)==4)
        RTpredCEVR = pred;
CEVR_misc1 = misc1;
CEVR_misc2 = misc2;
   
 elseif(trnblk(1,TrlType_Colmn)==3)
        RTpredDEV = pred;
DEV_misc1 = misc1;
DEV_misc2 = misc2;

    elseif(trnblk(1,TrlType_Colmn)==2)
        RTpredIEV = pred;
IEV_misc1 = misc1;
IEV_misc2 = misc2;

end 