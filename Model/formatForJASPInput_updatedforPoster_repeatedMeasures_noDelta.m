function forJASP = formatForJASPInput_updatedforPoster_repeatedMeasures_noDelta(IDX)

% Subtraction variables
count = 0;
for unitOfInterest = 1:length(IDX.allV1) 
    if strcmp(IDX.allV1(unitOfInterest).monkey,'J') ||...
            strcmp(IDX.allV1(unitOfInterest).depthLabel,'O')
        continue
    end
    % win_ms [50,100;150,300;150,800;-50,0]
    % IDX.allV1(i).conSelect_zsRESP{condition} is in (win_ms x trial)
    for i = 1:min(length(IDX.allV1(unitOfInterest).condSelect_zsRESP{1}(2,:)),...
            length(IDX.allV1(unitOfInterest).condSelect_zsRESP{4}(2,:)))
        count = count + 1;
        RESP_condA(count,1)   = IDX.allV1(unitOfInterest).condSelect_zsRESP{1}(2,i);
        RESP_condD(count,1)     = IDX.allV1(unitOfInterest).condSelect_zsRESP{4}(2,i);
        depthLabel(count,1) = IDX.allV1(unitOfInterest).depthLabel;
        unitNumber(count,1) = unitOfInterest;
    end
end

% the highest N is in the lower layers. at 77 MUA in the L layers
clear forJASP
forJASP = table(RESP_condA,RESP_condD,depthLabel,unitNumber);



global OUTDIR_FD
cd(OUTDIR_FD)
writetable(forJASP,'posterData_repeatedMeasures_noDelta.txt')

end