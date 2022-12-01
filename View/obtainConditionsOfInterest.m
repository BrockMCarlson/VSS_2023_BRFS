%% obtainConditionsOfInterest
%The goal of this function is to create a standard IDX output
% We also blaverage at this step (probably not the best place to do that)

%%
function IDX = obtainConditionsOfInterest(allData)


global OUTDIR_FD
cd(OUTDIR_FD)
workbookFile = strcat(OUTDIR_FD,'laminarBoundaryCalculations.xlsx');
laminarBoundaryCalculations = importDepths(workbookFile);



SDF_avg     = cell(4,8);
RESP_avg    = cell(4,8);
count_IDX = 0;
SupraCount =  0;  
GranularCount = 0;
InfraCount = 0;


for i = 1:size(allData,1) % load in data for one session
    trialAlignedMUAPacket = allData{i,2};
        RESP    = trialAlignedMUAPacket.RESP;
        win_ms  = trialAlignedMUAPacket.win_ms;
        SDF     = trialAlignedMUAPacket.SDF;
        sdftm   = trialAlignedMUAPacket.sdftm;
        STIM    = trialAlignedMUAPacket.STIM;
        clear trialAlignedMUAPacket 

        
        depths.upperBin{i,1} =  laminarBoundaryCalculations.UpperTop(i):1:laminarBoundaryCalculations.UpperBtm(i);
        depths.middleBin{i,1}  =  laminarBoundaryCalculations.MiddleTop(i):1:laminarBoundaryCalculations.MiddleBtm(i);
        depths.lowerBin{i,1}  = laminarBoundaryCalculations.LowerTop(i):1:laminarBoundaryCalculations.LowerBtm(i);

    %% Smooth Data
    SDFsmooth = smoothdata(SDF,2,'sgolay',50);
        
    %% Crop SDF to .8 sec
        tpFor800 = find(sdftm == .8);
        SDFcrop = SDFsmooth(:,1:tpFor800,:);
%         SDFcrop = SDF(:,1:tpFor800,:);
        sdftmCrop = sdftm(1:tpFor800);
        
    %% baseline correct values
    onsetTrls = STIM.first800; 
    blAvg = nanmean(RESP(:,4,onsetTrls),3); %the mean bl firing rate for each contact
    blStd = nanstd(RESP(:,4,onsetTrls),1,3); %the stdev of the bl firing rate for each contact
    blSubSDF = SDFcrop - blAvg;
    blSubRESP = RESP(:,:,:) - blAvg;

    % Z-scored change from baseline
    zsSDF = (SDFcrop - blAvg) ./ (blStd);
    zsRESP = (RESP - blAvg) ./ (blStd);

    % %-change from baseline
    pcSDF = ((SDFcrop - blAvg)./ blAvg )*100;
    pcRESP = ((RESP - blAvg)./ blAvg )*100;

    %% assess preference tuning
    % We are looking for the max of the mean response during the sustained
    % period.
    
% %     % step 1 - do I have good MUA responses?
% %     holder = nanmean(blSubSDF,3);
% %     figure
% %     plot(sdftm,holder)

    % Condition codes: MaierLabML2_custom_code/summer2022timingFiles/6. t_bmcBRFS/genBmcBRFSParams.m
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

    % Now I need to obtain my 4 monocular condition variations
    % Note - I called the orientations "PO and NPO" at the time of
    % recording, but I want to be agnostic to this designation and let the
    % MUA tell me what its preference is. The brain from inside out!
    tiltA_RightEye_monocConditions_13  = [5 11 13 19];
    tiltA_LeftEye_monocConditions_16   = [8 10 16 18];
    tiltB_RightEye_monocConditions_15  = [7 9  15 17];
    tiltB_LeftEye_monocConditions_14   = [6 12 14 20];
    clear trls
    trls.monoc_tiltA_RE = ...
        (ismember(STIM.bmcBRFSparamNum,tiltA_RightEye_monocConditions_13) &...
        STIM.first800 == true);
    trlNum.monoc_tiltA_RE = sum(trls.monoc_tiltA_RE );

    trls.monoc_tiltA_LE = ...
        (ismember(STIM.bmcBRFSparamNum,tiltA_LeftEye_monocConditions_16) &...
        STIM.first800 == true);
    trlNum.monoc_tiltA_LE = sum(trls.monoc_tiltA_LE );

    trls.monoc_tiltB_RE = ...
        (ismember(STIM.bmcBRFSparamNum,tiltB_RightEye_monocConditions_15) &...
        STIM.first800 == true);
    trlNum.monoc_tiltB_RE = sum(trls.monoc_tiltB_RE );

    trls.monoc_tiltB_LE = ...
        (ismember(STIM.bmcBRFSparamNum,tiltB_LeftEye_monocConditions_14) &...
        STIM.first800 == true);
    trlNum.monoc_tiltB_LE = sum(trls.monoc_tiltB_LE );


    % Ok, we have the trials for all possible monocular presentations. Now
    % let's take the max from the average transient response
    clear visPref
    visPref.monoc_tiltA_RE =  squeeze(nanmean(blSubRESP(:,1,trls.monoc_tiltA_RE),3));  
    visPref.monoc_tiltA_LE =  squeeze(nanmean(blSubRESP(:,1,trls.monoc_tiltA_LE),3));  
    visPref.monoc_tiltB_RE =  squeeze(nanmean(blSubRESP(:,1,trls.monoc_tiltB_RE),3));  
    visPref.monoc_tiltB_LE =  squeeze(nanmean(blSubRESP(:,1,trls.monoc_tiltB_LE),3)); 
    for j = 1:size(visPref.monoc_tiltA_LE,1)
        channelResponse(1) =  visPref.monoc_tiltA_RE(j);
        channelResponse(2) =  visPref.monoc_tiltA_LE(j);
        channelResponse(3) =  visPref.monoc_tiltB_RE(j);
        channelResponse(4) =  visPref.monoc_tiltB_LE(j);

        [~,maxPos] = max(channelResponse);
        [~,minPos] = min(channelResponse);

        if maxPos == 1 || maxPos == 2
            prefOri_string{j,1} = 'keep ori preference assigned at time of recording';
            prefOri_needsChange(j,1) = false;
        else
            prefOri_string{j,1}= 'ALERT! Flip ori preference from assigned';
            prefOri_needsChange(j,1) = true;
% %             warning('ori pref not as assigned for electrode #')
% %             disp(j)
        end
        if maxPos == 1 || maxPos == 3
            prefEye_string{j,1} = 'RE';
            prefEye_double(j,1) = 2; % 2 is for right eye
        else
            prefEye_string{j,1} = 'LE';
            prefEye_double(j,1) = 3; % 3 is for left eye
        end

        if maxPos == 1 
            codeForCondAB(j,1) = 13; 
        elseif maxPos == 2
            codeForCondAB(j,1) = 16; 
        elseif maxPos == 3
            codeForCondAB(j,1) = 15; 
        elseif maxPos == 4
            codeForCondAB(j,1) = 14;
        end
        if minPos == 1 
            codeForCondCD(j,1) = 13; 
        elseif minPos == 2
            codeForCondCD(j,1) = 16; 
        elseif minPos == 3
            codeForCondCD(j,1) = 15; 
        elseif minPos == 4
            codeForCondCD(j,1) = 14;
        end

    end
   

    % 13    'Monoc Alt Congruent Adapted. C PO RightEye adapting - PO LeftEye alternat monoc presentation',... 
    % 14    'Monoc Alt Congruent Adapted. C NPO LeftEye adapting - NPO RightEye alternat monoc presentation',... 
    % 15    'Monoc Alt Congruent Adapted. C NPO RightEye  adapting - NPO LeftEye alternat monoc presentation',... 
    % 16    'Monoc Alt Congruent Adapted. C PO LeftEye adapting - PO RightEye alternat monoc presentation',... 

    


    %% Condition selection. Needs a logical flip
    % In the past I did this with getCond and getConditionArray. I should
    % probably re-create this as it has constantly been a lifesaver.
    % I dont *need* to do this though as I only require a few conditions to
    % actually plot

    %ok. time to figure out what I want on my poster.
    % We are looking at 4 conditions. ALL are prefered ori:
    CondLabel{1} = 'A. Prefered eye monocular';
    CondLabel{2} = 'B. Null eye adapted';
    CondLabel{3} = 'C. Null eye monocular';
    CondLabel{4} = 'D. Prefered eye adapted';


    for k = 1:size(blSubSDF,1)
        clear trlsLogical
        trlsLogical(:,1) =... %A_prefEyeMonoc 
            STIM.bmcBRFSparamNum == codeForCondAB(j,1) &...
            STIM.first800 == true &...
            STIM.fullTrial == true;
        trlsLogical(:,2) =... %.B_nullEyeAdapt = ...
            STIM.bmcBRFSparamNum == codeForCondAB(j,1) &...
            STIM.first800 == false &...
            STIM.fullTrial == true;
        trlsLogical(:,3) =... %.C_nullEyeMonoc = ...
            STIM.bmcBRFSparamNum == codeForCondCD(j,1) &...
            STIM.first800 == true &...
            STIM.fullTrial == true;
        trlsLogical(:,4) =... %.D_prefEyeAdapt =...
            STIM.bmcBRFSparamNum == codeForCondCD(j,1) &...
            STIM.first800 == false &...
            STIM.fullTrial == true;

        for condLoop = 1:4
            clear trls
            trls = trlsLogical(:,condLoop);
            CondTrialNum(condLoop) = sum(trls);
            %SDF
                condSelect_rawSDF{condLoop}     = squeeze(SDFcrop(k,:,trls));
                condSelect_blSubSDF{condLoop}   = squeeze(blSubSDF(k,:,trls));
                condSelect_zsSDF{condLoop}      = squeeze(zsSDF(k,:,trls));
                condSelect_pcSDF{condLoop}      = squeeze(pcSDF(k,:,trls));
            % RESP
                condSelect_rawRESP{condLoop}     = squeeze(RESP(k,:,trls));
                condSelect_blSubRESP{condLoop}   = squeeze(blSubRESP(k,:,trls));
                condSelect_zsRESP{condLoop}      = squeeze(zsRESP(k,:,trls));
                condSelect_pcRESP{condLoop}      = squeeze(pcRESP(k,:,trls));
        end


    %% SAVE  IDX

    % SAVE UNIT INFO!
        clear holder

        holder.formattedDataLabel = allData(i,1);
        holder.fileName = STIM.localFileName;
        holder.monkey = STIM.localFileName(8);

        % Continuous data info
            holder.TM           = sdftmCrop;
            holder.condSelect_rawSDF    = condSelect_rawSDF ;
            holder.condSelect_blSubSDF  = condSelect_blSubSDF;
            holder.condSelect_zsSDF     =condSelect_zsSDF;
            holder.condSelect_pcSDF     = condSelect_pcSDF;
        % Time-win binned info;
            holder.win_ms           = win_ms;
            holder.condSelect_rawRESP   = condSelect_rawRESP;
            holder.condSelect_blSubRESP = condSelect_blSubRESP;
            holder.condSelect_zsRESP    = condSelect_zsRESP;
            holder.condSelect_pcRESP    = condSelect_pcRESP;

        % Condition info
        holder.CondTrialNum     = CondTrialNum;
        holder.CondLabel        = CondLabel;

        %Save the STIM - in case you ever need to troubleshoot what the
        %selections are for each trial. Access from CondTrials
        holder.STIM               = STIM;

  %Depth assignment
        if ismember(k,depths.upperBin{i,1})
            holder.depthLabel = 'U'; %U for upper
            SupraCount = SupraCount + 1;  
            IDX.Supra(SupraCount) = holder;
        elseif ismember(k,depths.middleBin{i,1})
            holder.depthLabel = 'M'; %M for middle
            GranularCount = GranularCount + 1;
            IDX.Granular(GranularCount) = holder;
        elseif ismember(k,depths.lowerBin{i,1})
            holder.depthLabel = 'L'; %L for Lower
            InfraCount = InfraCount + 1;
            IDX.Infra(InfraCount) = holder;
        else 
            holder.depthLabel = 'O'; % O for "out"
        end

        count_IDX = count_IDX + 1;
        IDX.allV1(count_IDX) = holder;


 end
     

end   
end