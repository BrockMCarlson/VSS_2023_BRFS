%% visWithGramm_IOT

clear
close all
global RIGDIR CODEDIR OUTDIR_FD OUTDIR_PLOT
setup_IOT('BrockWork');
cd(OUTDIR_FD)

%% Load in Data
if ~exist('IDX_SfN_Dataset.mat')
    % Set up master table
    fileList = dir('*FD.mat');
    name = {fileList.name}.';
    idx_bmcBRFSfiles = ~contains(name,'211217_B');
    numberOfFiles = sum(idx_bmcBRFSfiles);
    fileNameList = name(idx_bmcBRFSfiles);
    folder = {fileList.folder}.';
    folderNameList = folder(idx_bmcBRFSfiles);

    % Load in Data
    clear allData
    for rn = 1:length(fileNameList)
        allData{rn,1} = fileNameList{rn};
        clear trialAlignedMUAPacket
        load(fileNameList{rn});
        allData{rn,2} = trialAlignedMUAPacket;
        clear trialAlignedMUAPacket
    end

    % obtainConditionsOfInterest()
    % The goal of this file is to generate an IDX output
    IDX = obtainConditionsOfInterest(allData);
    clear allData
    cd(OUTDIR_FD)
    save('IDX_SfN_Dataset.mat','IDX')
else
    load('IDX_SfN_Dataset.mat')
end


%% formatData for toolboxes
forGramm= formatForGrammInput(IDX);
number_MUAfromB = size(forGramm.subtract,1);
number_upperLayers  = sum(strcmp(forGramm.subtract.depthLabel_3,'U'));
number_middleLayers = sum(strcmp(forGramm.subtract.depthLabel_3,'M'));
number_deepLayers   = sum(strcmp(forGramm.subtract.depthLabel_3,'L'));

forJASP = formatForJASPInput_updatedforPoster_repeatedMeasures_noDelta(IDX); %the response values need to be pre-split according to the levles you want to look across



%% plotStdIOTwithGramm

plotStdIOTwithGramm(forGramm,IDX)
plotLaminarSubtraction(forGramm,IDX)
%  plotStdIOTwithGramm_LE(forGramm)




%% Condition codes:
% 1     'Simult. Dioptic. PO',...
% 2     'Simult. Dioptic. NPO',...
% 3     'Simult. Dichoptic. PO LeftEye - NPO RightEye',...
% 4     'Simult. Dichoptic. NPO LeftEye - PO RightEye',...
% 5     'BRFS-like Congruent Adapted Flash. C PO RightEye adapting - PO LeftEye flashed',... 
% 6     'BRFS-like Congruent Adapted Flash. C NPO LeftEye adapting - NPO RightEye flashed',... 
% 7     'BRFS-like Congruent Adapted Flash. C NPO RightEye  adapting - NPO LeftEye flashed',... 
% 8     'BRFS-like Congruent Adapted Flash. C PO LeftEye adapting - PO RightEye flashed',... 
% 9     'BRFS IC Adapted Flash. NPO RightEye adapting - PO LeftEye flashed',... 
% 10    'BRFS IC Adapted Flash. PO LeftEye adapting - NPO RightEye flashed',... 
% 11    'BRFS IC Adapted Flash. PO RightEye adapting - NPO LeftEye flashed',... 
% 12    'BRFS IC Adapted Flash. NPO LeftEye adapting - PO RightEye flashed',... 

% 13    'Monoc Alt Congruent Adapted. C PO RightEye adapting - PO LeftEye alternat monoc presentation',... 
% 14    'Monoc Alt Congruent Adapted. C NPO LeftEye adapting - NPO RightEye alternat monoc presentation',... 
% 15    'Monoc Alt Congruent Adapted. C NPO RightEye  adapting - NPO LeftEye alternat monoc presentation',... 
% 16    'Monoc Alt Congruent Adapted. C PO LeftEye adapting - PO RightEye alternat monoc presentation',... 

% 17    'Monoc Alt IC Adapted. NPO RightEye adapting - PO LeftEye alternat monoc presentation',... 
% 18    'Monoc Alt IC Adapted. PO LeftEye adapting - NPO RightEye alternat monoc presentation',... 
% 19    'Monoc Alt IC Adapted. PO RightEye adapting - NPO LeftEye alternat monoc presentation',... 
% 20    'Monoc Alt IC Adapted. NPO LeftEye adapting - PO RightEye alternat monoc presentation',... 



