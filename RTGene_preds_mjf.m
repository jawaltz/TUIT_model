
global RTpredCEV RTpredCEVR RTpredDEV RTpredIEV;
global CEV_misc1 CEVR_misc1 DEV_misc1 IEV_misc1;
global CEV_misc2 CEVR_misc2 DEV_misc2 IEV_misc2;
global rtcev_met rtcevr_met rtdev_met rtiev_met
global rtCEVpred_met rtCEVRpred_met rtDEVpred_met rtIEVpred_met
global cev_misc1_met cevr_misc1_met dev_misc1_met iev_misc1_met
global cev_misc2_met cevr_misc2_met dev_misc2_met iev_misc2_met
global sess_trn1
global FitTrls

if(sess_trn1(1,Gp_Colmn)>=1) % SZ
    j=j+1;
 
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 12)),FitTrls))
        rtcev_met(j,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 12,1),Resp_Colmn);
        rtCEVpred_met(j,i) = RTpredCEV(i);
        cev_misc1_met(j,i) = CEV_misc1(i);
        cev_misc2_met(j,i) = CEV_misc2(i);

    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 34)),FitTrls))

        rtcevr_met(j,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 34,1),Resp_Colmn);
        rtCEVRpred_met(j,i) = RTpredCEVR(i);
        cevr_misc1_met(j,i) = CEVR_misc1(i);
        cevr_misc2_met(j,i) = CEVR_misc2(i);

    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 56)),FitTrls))

        rtdev_met(j,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 56,1),Resp_Colmn);
        rtDEVpred_met(j,i) = RTpredDEV(i);
        dev_misc1_met(j,i) = DEV_misc1(i);
        dev_misc2_met(j,i) = DEV_misc2(i);

    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 78)),FitTrls))
        rtiev_met(j,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 78,1),Resp_Colmn);
        rtIEVpred_met(j,i) = RTpredIEV(i);
        iev_misc1_met(j,i) = IEV_misc1(i);
        iev_misc2_met(j,i) = IEV_misc2(i);
    end

elseif(sess_trn1(1,Gp_Colmn)==0) % NC
    k=k+1;

    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 12)),FitTrls))
        rtcev_val(k,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 12,1),Resp_Colmn);
        rtCEVpred_val(k,i) = RTpredCEV(i);

        cev_misc1_val(k,i) = CEV_misc1(i);
        cev_misc2_val(k,i) = CEV_misc2(i);
    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 34)),FitTrls))

        rtcevr_val(k,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 34,1),Resp_Colmn);
        rtCEVRpred_val(k,i) = RTpredCEVR(i);

        cevr_misc1_val(k,i) = CEVR_misc1(i);
        cevr_misc2_val(k,i) = CEVR_misc2(i);

    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 56)),FitTrls))

        rtdev_val(k,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 56,1),Resp_Colmn);
        rtDEVpred_val(k,i) = RTpredDEV(i);

        dev_misc1_val(k,i) = DEV_misc1(i);
        dev_misc2_val(k,i) = DEV_misc2(i);

    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 78)),FitTrls))
        rtiev_val(k,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 78,1),Resp_Colmn);
        rtIEVpred_val(k,i) = RTpredIEV(i);

        iev_misc1_val(k,i) = IEV_misc1(i);
        iev_misc2_val(k,i) = IEV_misc2(i);

    end

end

if(sess_trn1(1,Drug_Colmn)==1)  % Mixed
    r=r+1;
 
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 12)),FitTrls))
        rtcev_M(r,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 12,1),Resp_Colmn);
        rtCEVpred_M(r,i) = RTpredCEV(i);
        cev_misc1_M(r,i) = CEV_misc1(i);
        cev_misc2_M(r,i) = CEV_misc2(i);

    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 34)),FitTrls))

        rtcevr_M(r,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 34,1),Resp_Colmn);
        rtCEVRpred_M(r,i) = RTpredCEVR(i);
        cevr_misc1_M(r,i) = CEVR_misc1(i);
        cevr_misc2_M(r,i) = CEVR_misc2(i);

    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 56)),FitTrls))

        rtdev_M(r,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 56,1),Resp_Colmn);
        rtDEVpred_M(r,i) = RTpredDEV(i);
        dev_misc1_M(r,i) = DEV_misc1(i);
        dev_misc2_M(r,i) = DEV_misc2(i);

    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 78)),FitTrls))
        rtiev_M(r,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 78,1),Resp_Colmn);
        rtIEVpred_M(r,i) = RTpredIEV(i);
        iev_misc1_M(r,i) = IEV_misc1(i);
        iev_misc2_M(r,i) = IEV_misc2(i);
    end
end


if(sess_trn1(1,Drug_Colmn)==2) % Other second gen
    o=o+1;
 
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 12)),FitTrls))
        rtcev_O(o,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 12,1),Resp_Colmn);
        rtCEVpred_O(o,i) = RTpredCEV(i);
        cev_misc1_O(o,i) = CEV_misc1(i);
        cev_misc2_O(o,i) = CEV_misc2(i);

        
    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 34)),FitTrls))

        rtcevr_O(o,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 34,1),Resp_Colmn);
        rtCEVRpred_O(o,i) = RTpredCEVR(i);
        cevr_misc1_O(o,i) = CEVR_misc1(i);
        cevr_misc2_O(o,i) = CEVR_misc2(i);

        
    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 56)),FitTrls))

        rtdev_O(o,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 56,1),Resp_Colmn);
        rtDEVpred_O(o,i) = RTpredDEV(i);
        dev_misc1_O(o,i) = DEV_misc1(i);
        dev_misc2_O(o,i) = DEV_misc2(i);

    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 78)),FitTrls))
        rtiev_O(o,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 78,1),Resp_Colmn);
        rtIEVpred_O(o,i) = RTpredIEV(i);
        iev_misc1_O(o,i) = IEV_misc1(i);
        iev_misc2_O(o,i) = IEV_misc2(i);

    end

elseif(sess_trn1(1,Drug_Colmn)==3)  % Cloz
    l=l+1;

    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 12)),FitTrls))
        rtcev_C(l,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 12,1),Resp_Colmn);
        rtCEVpred_C(l,i) = RTpredCEV(i);
        cev_misc1_C(l,i) = CEV_misc1(i);
        cev_misc2_C(l,i) = CEV_misc2(i);
    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 34)),FitTrls))

        rtcevr_C(l,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 34,1),Resp_Colmn);
        rtCEVRpred_C(l,i) = RTpredCEVR(i);
        cevr_misc1_C(l,i) = CEVR_misc1(i);
        cevr_misc2_C(l,i) = CEVR_misc2(i);
    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 56)),FitTrls))

        rtdev_C(l,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 56,1),Resp_Colmn);
        rtDEVpred_C(l,i) = RTpredDEV(i);
        dev_misc1_C(l,i) = DEV_misc1(i);
        dev_misc2_C(l,i) = DEV_misc2(i);
    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 78)),FitTrls))
        rtiev_C(l,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 78,1),Resp_Colmn);
        rtIEVpred_C(l,i) = RTpredIEV(i);
        iev_misc1_C(l,i) = IEV_misc1(i);
        iev_misc2_C(l,i) = IEV_misc2(i);

    end

end

if(sess_trn1(1,d32_colmn)==1)
    q=q+1;
 
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 12)),FitTrls))
        rtcev_A(q,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 12,1),Resp_Colmn);
        rtCEVpred_A(q,i) = RTpredCEV(i);
    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 34)),FitTrls))

        rtcevr_A(q,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 34,1),Resp_Colmn);
        rtCEVRpred_A(q,i) = RTpredCEVR(i);
    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 56)),FitTrls))

        rtdev_A(q,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 56,1),Resp_Colmn);
        rtDEVpred_A(q,i) = RTpredDEV(i);
    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 78)),FitTrls))
        rtiev_A(q,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 78,1),Resp_Colmn);
        rtIEVpred_A(q,i) = RTpredIEV(i);
    end

elseif(sess_trn1(1,d32_colmn)==0)
    z=z+1;

    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 12)),FitTrls))
        rtcev_G(z,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 12,1),Resp_Colmn);
        rtCEVpred_G(z,i) = RTpredCEV(i);
    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 34)),FitTrls))

        rtcevr_G(z,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 34,1),Resp_Colmn);
        rtCEVRpred_G(z,i) = RTpredCEVR(i);
    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 56)),FitTrls))

        rtdev_G(z,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 56,1),Resp_Colmn);
        rtDEVpred_G(z,i) = RTpredDEV(i);
    end
    for(i=1:min(length(find(sess_trn1(:,TrlType_Colmn) == 78)),FitTrls))
        rtiev_G(z,i) = sess_trn1(i-1 + find(sess_trn1(:,TrlType_Colmn) == 78,1),Resp_Colmn);
        rtIEVpred_G(z,i) = RTpredIEV(i);
    end

end


