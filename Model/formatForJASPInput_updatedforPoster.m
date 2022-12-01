function forJASP = formatForJASPInput_updatedforPoster(IDX)

% Subtraction variables
count_U = 0;
count_M = 0;
count_L = 0;
for unitOfInterest = 1:length(IDX.allV1) 
    if strcmp(IDX.allV1(unitOfInterest).monkey,'J') ||...
            strcmp(IDX.allV1(unitOfInterest).depthLabel,'O')
        continue
    end
    % win_ms [50,100;150,300;150,800;-50,0]
    % IDX.allV1(i).conSelect_zsRESP{condition} is in (win_ms x trial)
    avgForUnit_condA        = nanmean(IDX.allV1(unitOfInterest).condSelect_zsRESP{1}(2,:),2);
    avgForUnit_condD        = nanmean(IDX.allV1(unitOfInterest).condSelect_zsRESP{4}(2,:),2);
    if strcmp(IDX.allV1(unitOfInterest).depthLabel,'U')
        count_U = count_U+1;
        delta_U(count_U,1)       = avgForUnit_condD - avgForUnit_condA;
    elseif strcmp(IDX.allV1(unitOfInterest).depthLabel,'M')
        count_M = count_M+1;
        delta_M(count_M,1)      = avgForUnit_condD - avgForUnit_condA;
    elseif strcmp(IDX.allV1(unitOfInterest).depthLabel,'L')
        count_L = count_L+1;
        delta_L(count_L,1)      = avgForUnit_condD - avgForUnit_condA;
    end
end

% the highest N is in the lower layers. at 77 MUA in the L layers
clear forJASP
IOT_upperLayers = nan(77,1);
IOT_upperLayers(1:length(delta_U),1) = delta_U;
IOT_middleLayers = nan(77,1);
IOT_middleLayers(1:length(delta_M),1) = delta_M;
IOT_deepLayers = nan(77,1);
IOT_deepLayers(1:length(delta_L),1) = delta_L;

forJASP = table(IOT_upperLayers,IOT_middleLayers,IOT_deepLayers);



global OUTDIR_FD
cd(OUTDIR_FD)
writetable(forJASP,'posterData.txt')

end