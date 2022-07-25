%Script to extract explore parameter from each subject's parameter file
listing=dir('C:\Profiles\zxu\My Documents\MATLAB\TUIT\outputs\parameter_mat\parameter*');
cd 'C:\Profiles\zxu\My Documents\MATLAB\TUIT\outputs\parameter_mat\'
explore=zeros(length(listing),2);
for i = 1:length(listing)
    
    explore(i,1) = str2num(getfield(listing,{i},'name',{12:16}));
    load(getfield(listing,{i},'name'));
    explore(i,2) = best_params(2);
end
col_header = {'Subject','Explore'};
output_matrix = [col_header; num2cell(explore)];
xlswrite('../TUIT_ExploreParameter',output_matrix);