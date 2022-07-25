 
%% Plot single subject model and data
 
global FitTrls

set(figure(1), 'color', 'white'); 
hold off

plot(1:FitTrls,smooth(rtCEVpred_met(17,:),1),'--',1:FitTrls,smooth(rtcev_met(17,:),1),'-','LineWidth',2);
axis([0 FitTrls 0 5000]);
title('Single Subject CEV','FontSize', 32)
legend('Model','Data')
ylabel('RT (ms)',  'FontSize', 24)
xlabel('Trial', 'FontSize', 24) 
set(gca, 'Box', 'off' ); 
saveas(gcf, 'S2_CEV.epsc')

plot(1:FitTrls,smooth(rtCEVRpred_met(17,:),1),'--',1:FitTrls,smooth(rtcevr_met(17,:),1),'-','LineWidth',2)
axis([0 FitTrls 0 5000])
title('Single Subject CEVR','FontSize', 32)
legend('Model','Data')
ylabel('RT (ms)',  'FontSize', 24)
xlabel('Trial', 'FontSize', 24)
set(gca, 'Box', 'off' ); 
saveas(gcf, 'S2_CEVR.epsc')

plot(1:FitTrls,smooth(rtIEVpred_met(17,:),1),'--',1:FitTrls,smooth(rtiev_met(17,:),1),'-','LineWidth',2)
axis([0 FitTrls 0 5000])
title('Single Subject IEV','FontSize', 32)
legend('Model','Data')
ylabel('RT (ms)',  'FontSize', 24)
xlabel('Trial', 'FontSize', 24)
set(gca, 'Box', 'off' ); 
saveas(gcf, 'S2_IEV.epsc')

plot(1:FitTrls,smooth(rtDEVpred_met(17,:),1),'--',1:FitTrls,smooth(rtdev_met(17,:),1),'-','LineWidth',2)
axis([0 FitTrls 0 5000])
title('Single Subject DEV','FontSize', 32)
legend('Model','Data')
ylabel('RT (ms)',  'FontSize', 24)
xlabel('Trial', 'FontSize', 24)
set(gca, 'Box', 'off' ); 
saveas(gcf, 'S2_DEV.epsc')
  
%% Plot CEV, DEV, IEV model & data on one graph for each Dx group
% met = SZs; val = NCs


cev_Pred = [rtCEVpred_met; rtCEVpred_val];
cev_RT = [rtcev_met; rtcev_val];

iev_Pred = [rtIEVpred_met; rtIEVpred_val];
iev_RT = [rtiev_met; rtiev_val];

cevr_Pred = [rtCEVRpred_met; rtCEVRpred_val];
cevr_RT = [rtcevr_met; rtcevr_val];

dev_Pred = [rtDEVpred_met; rtDEVpred_val];
dev_RT = [rtdev_met; rtdev_val];
 
for (i=1:size(cev_RT,1))
for (j=1:size(cev_RT,2))
if (cev_RT(i,j) == 0) cev_RT(i,j)= nan; % temporarily set zeros to nan
cev_RT(i,j)=nan;
end
end
end
notNaN = ~isnan(cev_RT); % get indices of non nan values
howmany = sum(notNaN); % count them
cev_RT(~notNaN) =0; % set nans back to zeros
 
columnTot  = sum(cev_RT); % sum columns 
cev_mn = columnTot ./ howmany; % calc mean per column
 

for (i=1:size(dev_RT,1))
for (j=1:size(dev_RT,2))
if (dev_RT(i,j) == 0) dev_RT(i,j)= nan; % temporarily set zeros to nan
dev_RT(i,j)=nan;
end
end
end
notNaN = ~isnan(dev_RT); % get indices of non nan values
howmany = sum(notNaN); % count them
dev_RT(~notNaN) =0; % set nans back to zeros
 
columnTot  = sum(dev_RT); % sum columns 
dev_mn = columnTot ./ howmany; % calc mean per column


for (i=1:size(iev_RT,1))
for (j=1:size(iev_RT,2))
if (iev_RT(i,j) == 0) iev_RT(i,j)= nan; % temporarily set zeros to nan
iev_RT(i,j)=nan;
end
end
end
notNaN = ~isnan(iev_RT); % get indices of non nan values
howmany = sum(notNaN); % count them
iev_RT(~notNaN) =0; % set nans back to zeros
 
columnTot  = sum(iev_RT); % sum columns 
iev_mn = columnTot ./ howmany; % calc mean per column


for (i=1:size(cevr_RT,1))
for (j=1:size(cevr_RT,2))
if (cevr_RT(i,j) == 0) cevr_RT(i,j)= nan; % temporarily set zeros to nan
cevr_RT(i,j)=nan;
end
end
end
notNaN = ~isnan(cevr_RT); % get indices of non nan values
howmany = sum(notNaN); % count them
cevr_RT(~notNaN) =0; % set nans back to zeros
 
columnTot  = sum(cevr_RT); % sum columns 
cevr_mn = columnTot ./ howmany; % calc mean per column

hold off;
plot( 1:FitTrls,smooth(iev_mn(1:FitTrls),10,'lowess'),'r-'  ,1:FitTrls,smooth(cevr_mn(1:FitTrls),10,'lowess'),'m-', 1:FitTrls,smooth(cev_mn(1:FitTrls),10,'lowess'),'k-',1:FitTrls,smooth(dev_mn(1:FitTrls),10,'lowess'),'LineWidth',2) 
axis([0 FitTrls 1000 3000])
title('All Subjects: Data','FontSize', 32 )
legend('IEV','CEVR','CEV','DEV'); legend BOXOFF
legend BOXOFF
%legend('Location','SouthWest')
ylabel('RT (ms)',  'FontSize', 24)
xlabel('Trial', 'FontSize', 24)
set(gca, 'Box', 'off' ); 
saveas(gcf, 'AllConds_Data.epsc')
saveas(gcf, 'AllConds_Data.jpg')
saveas(gcf, 'AllConds_Data.fig')


cev_Pred = [rtCEVpred_met]; %met is SZ here and val is NC..
cev_RT = [rtcev_met];

iev_Pred = [rtIEVpred_met];
iev_RT = [rtiev_met];

cevr_Pred = [rtCEVRpred_met];
cevr_RT = [rtcevr_met];

dev_Pred = [rtDEVpred_met];
dev_RT = [rtdev_met];
 
for (i=1:size(cev_RT,1))
for (j=1:size(cev_RT,2))
if (cev_RT(i,j) == 0) cev_RT(i,j)= nan; % temporarily set zeros to nan
cev_RT(i,j)=nan;
end
end
end
notNaN = ~isnan(cev_RT); % get indices of non nan values
howmany = sum(notNaN); % count them
cev_RT(~notNaN) =0; % set nans back to zeros
 
columnTot  = sum(cev_RT); % sum columns 
cev_mn = columnTot ./ howmany; % calc mean per column
 

for (i=1:size(dev_RT,1))
for (j=1:size(dev_RT,2))
if (dev_RT(i,j) == 0) dev_RT(i,j)= nan; % temporarily set zeros to nan
dev_RT(i,j)=nan;
end
end
end
notNaN = ~isnan(dev_RT); % get indices of non nan values
howmany = sum(notNaN); % count them
dev_RT(~notNaN) =0; % set nans back to zeros
 
columnTot  = sum(dev_RT); % sum columns 
dev_mn = columnTot ./ howmany; % calc mean per column


for (i=1:size(iev_RT,1))
for (j=1:size(iev_RT,2))
if (iev_RT(i,j) == 0) iev_RT(i,j)= nan; % temporarily set zeros to nan
iev_RT(i,j)=nan;
end
end
end
notNaN = ~isnan(iev_RT); % get indices of non nan values
howmany = sum(notNaN); % count them
iev_RT(~notNaN) =0; % set nans back to zeros
 
columnTot  = sum(iev_RT); % sum columns 
iev_mn = columnTot ./ howmany; % calc mean per column


for (i=1:size(cevr_RT,1))
for (j=1:size(cevr_RT,2))
if (cevr_RT(i,j) == 0) cevr_RT(i,j)= nan; % temporarily set zeros to nan
cevr_RT(i,j)=nan;
end
end
end
notNaN = ~isnan(cevr_RT); % get indices of non nan values
howmany = sum(notNaN); % count them
cevr_RT(~notNaN) =0; % set nans back to zeros
 
columnTot  = sum(cevr_RT); % sum columns 
cevr_mn = columnTot ./ howmany; % calc mean per column

hold off;
plot( 1:FitTrls,smooth(iev_mn(1:FitTrls),10,'lowess'),'r-'  ,1:FitTrls,smooth(cevr_mn(1:FitTrls),10,'lowess'),'m-', 1:FitTrls,smooth(cev_mn(1:FitTrls),10,'lowess'),'k-',1:FitTrls,smooth(dev_mn(1:FitTrls),10,'lowess'),'LineWidth',2) 
axis([0 FitTrls 1000 3000])
title('SZ Subjects: Data','FontSize', 32 )
legend('IEV','CEVR','CEV','DEV'); legend BOXOFF
legend BOXOFF
%legend('Location','SouthWest')
ylabel('RT (ms)',  'FontSize', 24)
xlabel('Trial', 'FontSize', 24)
set(gca, 'Box', 'off' ); 
saveas(gcf, 'AllConds_SZ.epsc')
saveas(gcf, 'AllConds_SZ.jpg')
saveas(gcf, 'AllConds_SZ.fig')

for (i=1:size(cev_Pred,1))
for (j=1:size(cev_Pred,2))
if (cev_Pred(i,j) == 0) cev_Pred(i,j)= nan; % temporarily set zeros to nan
cev_Pred(i,j)=nan;
end
end
end
notNaN = ~isnan(cev_Pred); % get indices of non nan values
howmany = sum(notNaN); % count them
cev_Pred(~notNaN) =0; % set nans back to zeros
 
columnTot  = sum(cev_Pred); % sum columns 
cevPred_mn = columnTot ./ howmany; % calc mean per column
 

for (i=1:size(dev_Pred,1))
for (j=1:size(dev_Pred,2))
if (dev_Pred(i,j) == 0) dev_Pred(i,j)= nan; % temporarily set zeros to nan
dev_Pred(i,j)=nan;
end
end
end
notNaN = ~isnan(dev_Pred); % get indices of non nan values
howmany = sum(notNaN); % count them
dev_Pred(~notNaN) =0; % set nans back to zeros
 
columnTot  = sum(dev_Pred); % sum columns 
devPred_mn = columnTot ./ howmany; % calc mean per column


for (i=1:size(iev_Pred,1))
for (j=1:size(iev_Pred,2))
if (iev_Pred(i,j) == 0) iev_Pred(i,j)= nan; % temporarily set zeros to nan
iev_Pred(i,j)=nan;
end
end
end
notNaN = ~isnan(iev_Pred); % get indices of non nan values
howmany = sum(notNaN); % count them
iev_Pred(~notNaN) =0; % set nans back to zeros
 
columnTot  = sum(iev_Pred); % sum columns 
ievPred_mn = columnTot ./ howmany; % calc mean per column


for (i=1:size(cevr_Pred,1))
for (j=1:size(cevr_Pred,2))
if (cevr_Pred(i,j) == 0) cevr_Pred(i,j)= nan; % temporarily set zeros to nan
cevr_Pred(i,j)=nan;
end
end
end
notNaN = ~isnan(cevr_Pred); % get indices of non nan values
howmany = sum(notNaN); % count them
cevr_Pred(~notNaN) =0; % set nans back to zeros
 
columnTot  = sum(cevr_Pred); % sum columns 
cevrPred_mn = columnTot ./ howmany; % calc mean per column

plot(1:FitTrls,smooth(ievPred_mn(1:FitTrls),10,'lowess'),'r--',  1:FitTrls,smooth(cevrPred_mn(1:FitTrls),10,'lowess'),'m--', 1:FitTrls,smooth(cevPred_mn(1:FitTrls),10,'lowess'),'k--',  1:FitTrls,smooth(devPred_mn(1:FitTrls),10,'lowess'),'b--','LineWidth',2) 
title('SZs: Model Fits','FontSize', 32)
axis([0 FitTrls 1000 3000]) 
legend('IEV','CEVR','CEV','DEV'); legend BOXOFF
legend BOXOFF
 
ylabel('RT (ms)',  'FontSize', 24)
xlabel('Trial', 'FontSize', 24)
set(gca, 'Box', 'off' ); 
saveas(gcf, 'AllConds_model_SZ.epsc')
saveas(gcf, 'AllConds_model_SZ.jpg')
saveas(gcf, 'AllConds_model_SZ.fig')

for (i=1:size(cev_RT,1))
for (j=1:size(cev_RT,2))
if (cev_RT(i,j) == 0) cev_RT(i,j)= nan; % temporarily set zeros to nan
cev_RT(i,j)=nan;
end
end
end
notNaN = ~isnan(cev_RT); % get indices of non nan values
howmany = sum(notNaN); % count them
cev_RT(~notNaN) =0; % set nans back to zeros
 
columnTot  = sum(cev_RT); % sum columns 
cev_mn = columnTot ./ howmany; % calc mean per column
 

for (i=1:size(dev_RT,1))
for (j=1:size(dev_RT,2))
if (dev_RT(i,j) == 0) dev_RT(i,j)= nan; % temporarily set zeros to nan
dev_RT(i,j)=nan;
end
end
end
notNaN = ~isnan(dev_RT); % get indices of non nan values
howmany = sum(notNaN); % count them
dev_RT(~notNaN) =0; % set nans back to zeros
 
columnTot  = sum(dev_RT); % sum columns 
dev_mn = columnTot ./ howmany; % calc mean per column


for (i=1:size(iev_RT,1))
for (j=1:size(iev_RT,2))
if (iev_RT(i,j) == 0) iev_RT(i,j)= nan; % temporarily set zeros to nan
iev_RT(i,j)=nan;
end
end
end
notNaN = ~isnan(iev_RT); % get indices of non nan values
howmany = sum(notNaN); % count them
iev_RT(~notNaN) =0; % set nans back to zeros
 
columnTot  = sum(iev_RT); % sum columns 
iev_mn = columnTot ./ howmany; % calc mean per column


for (i=1:size(cevr_RT,1))
for (j=1:size(cevr_RT,2))
if (cevr_RT(i,j) == 0) cevr_RT(i,j)= nan; % temporarily set zeros to nan
cevr_RT(i,j)=nan;
end
end
end
notNaN = ~isnan(cevr_RT); % get indices of non nan values
howmany = sum(notNaN); % count them
cevr_RT(~notNaN) =0; % set nans back to zeros
 
columnTot  = sum(cevr_RT); % sum columns 
cevr_mn = columnTot ./ howmany; % calc mean per column

hold off;
plot( 1:FitTrls,smooth(iev_mn(1:FitTrls),10,'lowess'),'r-'  ,1:FitTrls,smooth(cevr_mn(1:FitTrls),10,'lowess'),'m-', 1:FitTrls,smooth(cev_mn(1:FitTrls),10,'lowess'),'k-',1:FitTrls,smooth(dev_mn(1:FitTrls),10,'lowess'),'LineWidth',2) 
axis([0 FitTrls 1000 3000])
title('Mixed Subjects: Data','FontSize', 32 )
legend('IEV','CEVR','CEV','DEV'); legend BOXOFF
legend BOXOFF
%legend('Location','SouthWest')
ylabel('RT (ms)',  'FontSize', 24)
xlabel('Trial', 'FontSize', 24)
set(gca, 'Box', 'off' ); 
saveas(gcf, 'AllConds_Mixed.epsc')
saveas(gcf, 'AllConds_Mixed.jpg')
saveas(gcf, 'AllConds_Mixed.fig')
 
for (i=1:size(cev_RT,1))
for (j=1:size(cev_RT,2))
if (cev_RT(i,j) == 0) cev_RT(i,j)= nan; % temporarily set zeros to nan
cev_RT(i,j)=nan;
end
end
end
notNaN = ~isnan(cev_RT); % get indices of non nan values
howmany = sum(notNaN); % count them
cev_RT(~notNaN) =0; % set nans back to zeros
 
columnTot  = sum(cev_RT); % sum columns 
cev_mn = columnTot ./ howmany; % calc mean per column
 

for (i=1:size(dev_RT,1))
for (j=1:size(dev_RT,2))
if (dev_RT(i,j) == 0) dev_RT(i,j)= nan; % temporarily set zeros to nan
dev_RT(i,j)=nan;
end
end
end
notNaN = ~isnan(dev_RT); % get indices of non nan values
howmany = sum(notNaN); % count them
dev_RT(~notNaN) =0; % set nans back to zeros
 
columnTot  = sum(dev_RT); % sum columns 
dev_mn = columnTot ./ howmany; % calc mean per column


for (i=1:size(iev_RT,1))
for (j=1:size(iev_RT,2))
if (iev_RT(i,j) == 0) iev_RT(i,j)= nan; % temporarily set zeros to nan
iev_RT(i,j)=nan;
end
end
end
notNaN = ~isnan(iev_RT); % get indices of non nan values
howmany = sum(notNaN); % count them
iev_RT(~notNaN) =0; % set nans back to zeros
 
columnTot  = sum(iev_RT); % sum columns 
iev_mn = columnTot ./ howmany; % calc mean per column


for (i=1:size(cevr_RT,1))
for (j=1:size(cevr_RT,2))
if (cevr_RT(i,j) == 0) cevr_RT(i,j)= nan; % temporarily set zeros to nan
cevr_RT(i,j)=nan;
end
end
end
notNaN = ~isnan(cevr_RT); % get indices of non nan values
howmany = sum(notNaN); % count them
cevr_RT(~notNaN) =0; % set nans back to zeros
 
columnTot  = sum(cevr_RT); % sum columns 
cevr_mn = columnTot ./ howmany; % calc mean per column

hold off;
plot( 1:FitTrls,smooth(iev_mn(1:FitTrls),10,'lowess'),'r-'  ,1:FitTrls,smooth(cevr_mn(1:FitTrls),10,'lowess'),'m-', 1:FitTrls,smooth(cev_mn(1:FitTrls),10,'lowess'),'k-',1:FitTrls,smooth(dev_mn(1:FitTrls),10,'lowess'),'LineWidth',2) 
axis([0 FitTrls 1000 3000])
title('Cloz Subjects: Data','FontSize', 32 )
legend('IEV','CEVR','CEV','DEV'); legend BOXOFF
legend BOXOFF
%legend('Location','SouthWest')
ylabel('RT (ms)',  'FontSize', 24)
xlabel('Trial', 'FontSize', 24)
set(gca, 'Box', 'off' ); 
saveas(gcf, 'AllConds_Cloz.epsc')
saveas(gcf, 'AllConds_Cloz.jpg')
saveas(gcf, 'AllConds_Cloz.fig')
 
for (i=1:size(cev_RT,1))
for (j=1:size(cev_RT,2))
if (cev_RT(i,j) == 0) cev_RT(i,j)= nan; % temporarily set zeros to nan
cev_RT(i,j)=nan;
end
end
end
notNaN = ~isnan(cev_RT); % get indices of non nan values
howmany = sum(notNaN); % count them
cev_RT(~notNaN) =0; % set nans back to zeros
 
columnTot  = sum(cev_RT); % sum columns 
cev_mn = columnTot ./ howmany; % calc mean per column
 

for (i=1:size(dev_RT,1))
for (j=1:size(dev_RT,2))
if (dev_RT(i,j) == 0) dev_RT(i,j)= nan; % temporarily set zeros to nan
dev_RT(i,j)=nan;
end
end
end
notNaN = ~isnan(dev_RT); % get indices of non nan values
howmany = sum(notNaN); % count them
dev_RT(~notNaN) =0; % set nans back to zeros
 
columnTot  = sum(dev_RT); % sum columns 
dev_mn = columnTot ./ howmany; % calc mean per column


for (i=1:size(iev_RT,1))
for (j=1:size(iev_RT,2))
if (iev_RT(i,j) == 0) iev_RT(i,j)= nan; % temporarily set zeros to nan
iev_RT(i,j)=nan;
end
end
end
notNaN = ~isnan(iev_RT); % get indices of non nan values
howmany = sum(notNaN); % count them
iev_RT(~notNaN) =0; % set nans back to zeros
 
columnTot  = sum(iev_RT); % sum columns 
iev_mn = columnTot ./ howmany; % calc mean per column


for (i=1:size(cevr_RT,1))
for (j=1:size(cevr_RT,2))
if (cevr_RT(i,j) == 0) cevr_RT(i,j)= nan; % temporarily set zeros to nan
cevr_RT(i,j)=nan;
end
end
end
notNaN = ~isnan(cevr_RT); % get indices of non nan values
howmany = sum(notNaN); % count them
cevr_RT(~notNaN) =0; % set nans back to zeros
 
columnTot  = sum(cevr_RT); % sum columns 
cevr_mn = columnTot ./ howmany; % calc mean per column

hold off;
plot( 1:FitTrls,smooth(iev_mn(1:FitTrls),10,'lowess'),'r-'  ,1:FitTrls,smooth(cevr_mn(1:FitTrls),10,'lowess'),'m-', 1:FitTrls,smooth(cev_mn(1:FitTrls),10,'lowess'),'k-',1:FitTrls,smooth(dev_mn(1:FitTrls),10,'lowess'),'LineWidth',2) 
axis([0 FitTrls 1000 3000])
title('Other 2nd Gen Subs: Data','FontSize', 32 )
legend('IEV','CEVR','CEV','DEV'); legend BOXOFF
legend BOXOFF
%legend('Location','SouthWest')
ylabel('RT (ms)',  'FontSize', 24)
xlabel('Trial', 'FontSize', 24)
set(gca, 'Box', 'off' ); 
saveas(gcf, 'AllConds_Other.epsc')
saveas(gcf, 'AllConds_Other.jpg')
saveas(gcf, 'AllConds_Other.fig')

cev_PE =[cev_misc1_met; cev_misc1_val];
cevr_PE =[cevr_misc1_met; cevr_misc1_val];
dev_PE =[dev_misc1_met; dev_misc1_val];
iev_PE =[iev_misc1_met; iev_misc1_val];

rtdev = [rtdev_met; rtdev_val];
rtcev = [rtcev_met; rtcev_val];
rtiev = [rtiev_met; rtiev_val];
rtcevr = [rtcevr_met; rtcevr_val];

n_PEtrls = 15; % only look at first n trials when EV's aren't quite learned
 % (otherwise PE's end up getting smaller in place where rt's converge..)
rtdev1 = nonzeros(rtdev(:,1:n_PEtrls)); % filter out non-RTs
rtcev1 = nonzeros(rtcev(:,1:n_PEtrls)); 
rtiev1 = nonzeros(rtiev(:,1:n_PEtrls));  
rtcevr1 = nonzeros(rtcevr(:,1:n_PEtrls));

dev_PE1 = dev_PE(find(nonzeros(rtdev(:,1:n_PEtrls)))); % get corresponding PE's
cev_PE1 = cev_PE(find(nonzeros(rtcev(:,1:n_PEtrls))));
iev_PE1 = iev_PE(find(nonzeros(rtiev(:,1:n_PEtrls))));
cevr_PE1 = cevr_PE(find(nonzeros(rtcevr(:,1:n_PEtrls))));

y_dev = [rtdev1 dev_PE1];
y_dev=sortrows(y_dev,1); % sort by increasing rt's

y_cev = [rtcev1 cev_PE1];
y_cev=sortrows(y_cev,1); % sort by increasing rt's

y_iev = [rtiev1 iev_PE1];
y_iev=sortrows(y_iev,1); % sort by increasing rt's

y_cevr = [rtcevr1 cevr_PE1];
y_cevr=sortrows(y_cevr,1); % sort by increasing rt's

figure(1)
plot(y_dev(:,1),smooth(y_dev(:,2),500,'lowess'),'g','Linewidth',2);
axis([500 4000 -15 25])
title('DEV Prediction Errors','FontSize', 32);
xlabel('RT (ms)',  'FontSize', 24)
ylabel('Reward Prediction Error', 'FontSize', 24)
set(gca, 'Box', 'off' );
saveas(gcf, 'DEV_PE_15trl.epsc')

figure(2)
set(figure(2), 'color', 'white');
hold off
plot(y_cev(:,1),smooth(y_cev(:,2),500,'lowess'),'k','Linewidth',2);
axis([500 4000 -15 25])
title('CEV Prediction Errors','FontSize', 32);
xlabel('RT (ms)',  'FontSize', 24)
ylabel('Reward Prediction Error', 'FontSize', 24)
set(gca, 'Box', 'off' );
saveas(gcf, 'CEV_PE_15trl.epsc')

figure(3)
set(figure(3), 'color', 'white');
hold off
plot(y_iev(:,1),smooth(y_iev(:,2),500,'lowess'),'r','Linewidth',2);
axis([500 4000 -15 25])
title('IEV Prediction Errors','FontSize', 32);
xlabel('RT (ms)',  'FontSize', 24)
ylabel('Reward Prediction Error', 'FontSize', 24)
set(gca, 'Box', 'off' );
saveas(gcf, 'IEV_PE_15trl.epsc')

figure(4)
set(figure(4), 'color', 'white');
hold off
plot(y_cevr(:,1),smooth(y_cevr(:,2),500,'lowess'),'c','Linewidth',2);
axis([500 4000 -15 25])
title('CEVR Prediction Errors','FontSize', 32);
xlabel('RT (ms)',  'FontSize', 24)
ylabel('Reward Prediction Error', 'FontSize', 24)
set(gca, 'Box', 'off' );
saveas(gcf, 'CEVR_PE_15trl.epsc')  
 
%plot(1:FitTrls,10*smooth(cev_misc2_met(25,2:49),1),1:FitTrls,smooth(rtcev_met(25,2:49)-rtcev_met(25,1:FitTrls),1),'LineWidth',2)
%% above plots rt change from one trial to next instead of raw rt -- this
%% is better to go along with exp, which is in addition to effects of
%% rt_last etc and cumulative go/nogo...

%% this caclulates correlation between exploration prediction and change in
%% rt's in cev
%corr2(cev_misc2_met(:,2:50),rtcev_met(:,2:50)-rtcev_met(:,1:49))
%corr2(cev_misc2_val(:,2:50),rtcev_val(:,2:50)-rtcev_val(:,1:49))
 
% 
% for i=1:size(cev_misc2_val,1) corr_exp_val(i) = corr2(cev_misc2_val(i,2:50),rtcev_val(i,2:50)-rtcev_val(i,1:49));
% if isnan(corr_exp_val(i)) corr_exp_val(i)=0;
% end
% end
% for i=1:size(cev_misc2_met,1) corr_exp_met(i) = corr2(cev_misc2_met(i,2:50),rtcev_met(i,2:50)-rtcev_met(i,1:49));
% if isnan(corr_exp_met(i)) corr_exp_met(i)=0;
% end
% end
% for i=1:size(cev_misc2_mm,1) corr_exp_mm(i) = corr2(cev_misc2_mm(i,2:50),rtcev_mm(i,2:50)-rtcev_mm(i,1:49));
% if isnan(corr_exp_mm(i)) corr_exp_mm(i)=0;
% end
% end
% mean(nonzeros(corr_exp_mm))
% mean(nonzeros(corr_exp_met))
% mean(nonzeros(corr_exp_val))

%% plot scatter between predicted and actual explores for mets with nonzero
% explore param

 rtcev_met_diff(:,2:FitTrls)=rtcev_met(:,2:FitTrls)-rtcev_met(:,1:FitTrls-1);
 rtcevr_met_diff(:,2:FitTrls)=rtcevr_met(:,2:FitTrls)-rtcevr_met(:,1:FitTrls-1);
 rtdev_met_diff(:,2:FitTrls)=rtdev_met(:,2:FitTrls)-rtdev_met(:,1:FitTrls-1); 
 rtiev_met_diff(:,2:FitTrls)=rtiev_met(:,2:FitTrls)-rtiev_met(:,1:FitTrls-1); 
  
 misc_met = [cev_misc2_met(:,2:FitTrls) cevr_misc2_met(:,2:FitTrls) dev_misc2_met(:,2:FitTrls) iev_misc2_met(:,2:FitTrls)];
 rt_met_diff = [rtcev_met_diff(:,2:FitTrls) rtcevr_met_diff(:,2:FitTrls) rtdev_met_diff(:,2:FitTrls) rtiev_met_diff(:,2:FitTrls)];

for i=1:size(cev_misc2_met,1) corr_exp_met(i) = corr2(misc_met(i,2:FitTrls),rt_met_diff(i,2:FitTrls));
if isnan(corr_exp_met(i)) corr_exp_met(i)=0;
end
end 

%    
%  for(i=1:size(cev_misc2_met,1))
% for(j=1:FitTrls)
% if cev_misc2_met(i,j)==0 cev_misc2_met1(i,j)= 0;
% else cev_misc2_met1(i,j)= cev_misc2_met(i,j); 
% end
% if dev_misc2_met(i,j)==0 dev_misc2_met1(i,j)=  0; % convert 0's to large # and don't plot
% else dev_misc2_met1(i,j)= dev_misc2_met(i,j);
% end
% if iev_misc2_met(i,j)==0 iev_misc2_met1(i,j)=  0; % convert 0's to large # and don't plot
% else iev_misc2_met1(i,j)= iev_misc2_met(i,j);
% end
% if cevr_misc2_met(i,j)==0 cevr_misc2_met1(i,j)= 0;
% else cevr_misc2_met1(i,j)= cevr_misc2_met(i,j);
% end
% end
%  end
%  
%  
%  
% 
%  for(i=1:size(cev_misc2_val,1))
% for(j=1:FitTrls)
% if cev_misc2_val(i,j)==0 cev_misc2_val1(i,j)= 0;
% else cev_misc2_val1(i,j)= cev_misc2_val(i,j); 
% end
% if dev_misc2_val(i,j)==0 dev_misc2_val1(i,j)=  0; % convert 0's to large # and don't plot
% else dev_misc2_val1(i,j)= dev_misc2_val(i,j);
% end
% if iev_misc2_val(i,j)==0 iev_misc2_val1(i,j)=  0; % convert 0's to large # and don't plot
% else iev_misc2_val1(i,j)= iev_misc2_val(i,j);
% end
% if cevr_misc2_val(i,j)==0 cevr_misc2_val1(i,j)= 0;
% else cevr_misc2_val1(i,j)= cevr_misc2_val(i,j);
% end
% end
% end
 
if generative ==0

 set(figure(5), 'color', 'white'); 
clf;
 figure(5)
hold off

exp_trls=1:FitTrls; % number of trials at beginning of each block to plot exploration 
 
for(i=1:size(cev_misc2_met,1)) 
if(sum(cev_misc2_met(i,:))~=0)
scatter(cev_misc2_met(i,exp_trls),rtcev_met_diff(i,exp_trls),'k')
end
hold on
if(sum(cevr_misc2_met(i,:))~=0)
scatter(cevr_misc2_met(i,exp_trls),rtcevr_met_diff(i,exp_trls),'k')
end
if(sum(dev_misc2_met(i,:))~=0)
scatter(dev_misc2_met(i,exp_trls),rtdev_met_diff(i,exp_trls),'k')
end
if(sum(iev_misc2_met(i,:))~=0)
scatter(iev_misc2_met(i,exp_trls),rtiev_met_diff(i,exp_trls),'k')
end
end
  
title('Exploration, All Subs','FontSize', 32)
 xlabel('Model Explore (ms)',  'FontSize', 24)
 ylabel('RT Diff (ms)', 'FontSize', 24)
 set(gca, 'Box', 'off' ); 
 axis([-800 900 -3500 3500])
 saveas(gcf, 'Explore_scatter.epsc')
 saveas(gcf, 'Explore_scatter.jpg')
 saveas(gcf, 'Explore_scatter.fig')
  

exp_trls=1:FitTrls; % number of trials at beginning of each block to plot exploration 

%  for(i=1:size(cev_misc2_M,1)) 
% if(sum(cev_misc2_M(i,:))~=0)
% scatter(cev_misc2_M(i,exp_trls),rtcev_M_diff(i,exp_trls),'m')
% end
% hold on
% if(sum(cevr_misc2_M(i,:))~=0)
% scatter(cevr_misc2_M(i,exp_trls),rtcevr_M_diff(i,exp_trls),'m')
% end
% if(sum(dev_misc2_M(i,:))~=0)
% scatter(dev_misc2_M(i,exp_trls),rtdev_M_diff(i,exp_trls),'m')
% end
% if(sum(iev_misc2_M(i,:))~=0)
% scatter(iev_misc2_M(i,exp_trls),rtiev_M_diff(i,exp_trls),'m')
% end
%  end
%  

end
 

