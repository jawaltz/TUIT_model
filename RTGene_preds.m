
global RTpredCEV RTpredCEVR RTpredDEV RTpredIEV;
global CEV_misc1 CEVR_misc1 DEV_misc1 IEV_misc1;
global CEV_misc2 CEVR_misc2 DEV_misc2 IEV_misc2;
global rtcev_met rtcevr_met rtdev_met rtiev_met
global rtCEVpred_met rtCEVRpred_met rtDEVpred_met rtIEVpred_met
global cev_misc1_met cevr_misc1_met dev_misc1_met iev_misc1_met
global cev_misc2_met cevr_misc2_met dev_misc2_met iev_misc2_met
global rtcev_val rtcevr_val rtdev_val rtiev_val
global rtCEVpred_val rtCEVRpred_val rtDEVpred_val rtIEVpred_val
global cev_misc1_val cevr_misc1_val dev_misc1_val iev_misc1_val
global cev_misc2_val cevr_misc2_val dev_misc2_val iev_misc2_val
global sess_trn1
global FitTrls
sess_trn1

if(sess_trn1(1,Gp_Colmn)==3|sess_trn1(1,Gp_Colmn)==0) % SZ
    j=j+1;
 
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 1)),FitTrls))
        rtcev_met(j,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 1,1),Resp_Colmn)
        rtCEVpred_met(j,i) = RTpredCEV(i)
        cev_misc1_met(j,i) = CEV_misc1(i);
        cev_misc2_met(j,i) = CEV_misc2(i);

    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 4)),FitTrls))

        rtcevr_met(j,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 4,1),Resp_Colmn);
        rtCEVRpred_met(j,i) = RTpredCEVR(i);
        cevr_misc1_met(j,i) = CEVR_misc1(i);
        cevr_misc2_met(j,i) = CEVR_misc2(i);

    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 3)),FitTrls))

        rtdev_met(j,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 3,1),Resp_Colmn);
        rtDEVpred_met(j,i) = RTpredDEV(i);
        dev_misc1_met(j,i) = DEV_misc1(i);
        dev_misc2_met(j,i) = DEV_misc2(i);

    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 2)),FitTrls))
        rtiev_met(j,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 2,1),Resp_Colmn);
        rtIEVpred_met(j,i) = RTpredIEV(i);
        iev_misc1_met(j,i) = IEV_misc1(i);
        iev_misc2_met(j,i) = IEV_misc2(i);
    end
    
elseif(sess_trn1(1,Gp_Colmn)==2|sess_trn1(1,Gp_Colmn)==1) % NC
    k=k+1;

    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 1)),FitTrls))
        rtcev_val(k,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 1,1),Resp_Colmn);
        rtCEVpred_val(k,i) = RTpredCEV(i);

        cev_misc1_val(k,i) = CEV_misc1(i);
        cev_misc2_val(k,i) = CEV_misc2(i);
    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 4)),FitTrls))

        rtcevr_val(k,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 4,1),Resp_Colmn);
        rtCEVRpred_val(k,i) = RTpredCEVR(i);

        cevr_misc1_val(k,i) = CEVR_misc1(i);
        cevr_misc2_val(k,i) = CEVR_misc2(i);

    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 3)),FitTrls))

        rtdev_val(k,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 3,1),Resp_Colmn);
        rtDEVpred_val(k,i) = RTpredDEV(i);

        dev_misc1_val(k,i) = DEV_misc1(i);
        dev_misc2_val(k,i) = DEV_misc2(i);

    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 2)),FitTrls))
        rtiev_val(k,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 2,1),Resp_Colmn);
        rtIEVpred_val(k,i) = RTpredIEV(i);

        iev_misc1_val(k,i) = IEV_misc1(i);
        iev_misc2_val(k,i) = IEV_misc2(i);

    end

end


