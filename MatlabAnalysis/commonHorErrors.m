function commonHorErrors(gmapStruct, azStruct, mboxStruct, isAbsErr)
% Compute common points error for all map tools

% Get the list of group names
    gmapGroupNames = fieldnames(gmapStruct);
    azGroupNames = fieldnames(azStruct);
    mboxGroupNames = fieldnames(mboxStruct);

    gmapHorErr = [];
    azHorErr = [];
    mboxHorErr = [];
    if isAbsErr
        postfix = 'Abs';
        yLabel = 'Horizontal Absolute Error';
    else
        postfix = 'Rel';
        yLabel = 'Horizontal Relative Error';
    end
    horField = ['hor' postfix];

    % Loop over all Google map points groups
    for i = 1:length(gmapGroupNames)
        gmapGroupName = gmapGroupNames{i};

        if ~isfield(azStruct, gmapGroupName)...
                || ~isfield(mboxStruct, gmapGroupName)
            continue;
        end
        
        % Get the dictionary of points for this group
        gmapPointsMap = gmapStruct.(gmapGroupName);
        azPointsMap = azStruct.(gmapGroupName);
        mboxPointsMap = mboxStruct.(gmapGroupName);
        
        % Get the list of point names
        gmapPointNames = keys(gmapPointsMap);

        % Loop over all points
        for j = 1:length(gmapPointNames)
            gmapPointName = gmapPointNames{j};

            if ~isKey(azPointsMap, gmapPointName)...
                || ~isKey(mboxPointsMap, gmapPointName)...
                || ~isfield(gmapPointsMap(gmapPointName), horField)...
                || ~isfield(azPointsMap(gmapPointName), horField)...
                || ~isfield(mboxPointsMap(gmapPointName), horField)
                continue;
            end

            % If the 'hor' field exists, save the horizontal error and the point name
            gmapErr = gmapPointsMap(gmapPointName).(horField);
            azErr = azPointsMap(gmapPointName).(horField);
            mboxErr = mboxPointsMap(gmapPointName).(horField);
            % Skip the reference point in relative positions.
            if isAbsErr || gmapErr ~= 0
                gmapHorErr = [gmapHorErr, gmapErr];
                azHorErr = [azHorErr, azErr];
                mboxHorErr = [mboxHorErr, mboxErr];
            end
        end

    end
    disp(['Google Map common points ' yLabel ' mean is: ' num2str(mean(gmapHorErr))]);
    disp(['Google Map common points ' yLabel ' RMS is: ' num2str(rms(gmapHorErr))]);
    disp(['Azure Map common points ' yLabel ' mean is: ' num2str(mean(azHorErr))]);
    disp(['Azure Map common points ' yLabel ' RMS is: ' num2str(rms(azHorErr))]);
    disp(['MapBox Map common points ' yLabel ' mean is: ' num2str(mean(mboxHorErr))]);
    disp(['MapBox Map common points ' yLabel ' RMS is: ' num2str(rms(mboxHorErr))]);
end