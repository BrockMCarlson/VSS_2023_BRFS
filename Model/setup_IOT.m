function [RIGDIR, CODEDIR, OUTDIR_FD, OUTDIR_PLOT] = setup_IOT(user)
% RIGDIR        - where the base data is stored
% CODEDIR       - where your GitHub Repo is stored:
%                   this function also CDs into this directrory
% OUTDIR_FD     - FD = "Formatted Data"
%                   this is where your preProcessed / organized data goes
% OUTDIR_PLOT   - where your figures end up


global RIGDIR CODEDIR OUTDIR_FD OUTDIR_PLOT

    switch user
        case {'BrockWork'}
            RIGDIR      = 'D:\bmcBRFS datasets\';
            CODEDIR     = 'C:\Users\Brock\Documents\MATLAB\GitHub\VSS_2023_BRFS\';
            OUTDIR_FD   = 'D:\formattedDataOutpus\';
            OUTDIR_PLOT = 'D:\plotData\';

        case {'BrockHome'}
            RIGDIR      = 'S:\bmcBRFS dataset\';
            CODEDIR     = 'C:\Users\Brock Carlson\Documents\GitHub\SfN_2022_IOT\Controller\';
            OUTDIR_FD   = 'S:\formattedDataOutputs\';
            OUTDIR_PLOT = 'S:\plotData\';

    end
      
cd(CODEDIR)
end


% cd(RIGDIR)
% cd(CODEDIR)
% cd(OUTDIR_FD)
% cd(OUTDIR_PLOT)
