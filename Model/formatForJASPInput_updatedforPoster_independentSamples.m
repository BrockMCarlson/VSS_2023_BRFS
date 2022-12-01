function forJASP = formatForJASPInput_updatedforPoster_independentSamples(IDX)

% Subtraction variables
count = 0;
for unitOfInterest = 1:length(IDX.allV1) 
    if strcmp(IDX.allV1(unitOfInterest).monkey,'J') ||...
            strcmp(IDX.allV1(unitOfInterest).depthLabel,'O')
        continue
    end
    count = count + 1;
    % win_ms [50,100;150,300;150,800;-50,0]
    % IDX.allV1(i).conSelect_zsRESP{condition} is in (win_ms x trial)
    avgForUnit_condA        = nanmean(IDX.allV1(unitOfInterest).condSelect_zsRESP{1}(2,:),2);
    avgForUnit_condD        = nanmean(IDX.allV1(unitOfInterest).condSelect_zsRESP{4}(2,:),2);
    delta_IOT(count,1) = avgForUnit_condD - avgForUnit_condA;
    depthLabel(count,1) = IDX.allV1(unitOfInterest).depthLabel;
end

% the highest N is in the lower layers. at 77 MUA in the L layers
clear forJASP
forJASP = table(delta_IOT,depthLabel);



global OUTDIR_FD
cd(OUTDIR_FD)
writetable(forJASP,'posterData_independentSamples.txt')

end