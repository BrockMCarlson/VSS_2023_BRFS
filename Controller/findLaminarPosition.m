%   findLaminarPosition.

clear
close all
global RIGDIR CODEDIR OUTDIR_FD OUTDIR_PLOT
setup_IOT('BrockHome');
cd(RIGDIR)

%% Set up master table
fileList = dir('**/*.ns6');
name = {fileList.name}.';
idx_bmcBRFSfiles = contains(name,'bmcBRFS');
numberOfFiles = sum(idx_bmcBRFSfiles);
fileNameList = name(idx_bmcBRFSfiles);
folder = {fileList.folder}.';
folderNameList = folder(idx_bmcBRFSfiles);

%% Run all laminar analysis on BRFS files
cd(OUTDIR_PLOT)
count = 0;
for i = 1:length(fileNameList)
    if i == 2 || i == 6 % get rid of brfs001 when brfs002 exists
        continue
    end
    count = count + 1;
    bmcBRFSfileLocation{count} = strcat(folderNameList{i},filesep,fileNameList{i});
    
    fileNameWithOutExtnesion =  bmcBRFSfileLocation{count}(1:end-4);
    plotCSDandPSDfromNEV(fileNameWithOutExtnesion,1:32,[]);
        FigName   = fileNameList{i}(1:end-4);
        savefig(gcf, strcat(OUTDIR_PLOT, FigName, '.fig'));
        saveas(gcf, strcat(OUTDIR_PLOT, FigName, '.svg'));
        saveas(gcf, strcat(OUTDIR_PLOT, FigName, '.png'));
        close all


end







