function dataStruct = computeRelativePosErr(dataStruct, gtStruct, groupToRefer)
    groupNames = fieldnames(dataStruct);

    for i = 1:length(groupNames)
        groupName = groupNames{i};

        % check if the reference point exists in the group
        if ~isfield(gtStruct, groupName) ...
            || ~isKey(dataStruct.(groupName), groupToRefer(groupName))...
            || ~isKey(gtStruct.(groupName), groupToRefer(groupName))
            continue;
        end
        
        % get all points from the dict of this group
        pointsDict = dataStruct.(groupName);
        points = keys(pointsDict);
        referPointName = groupToRefer(groupName);
        refPos = dataStruct.(groupName)(referPointName).pos{1};
        refGtPos = gtStruct.(groupName)(referPointName).pos{1};
        for j = 1:length(points)
            pointName = points{j};

            % check if gt exist
            if ~isKey(gtStruct.(groupName), pointName)
                continue;
            end

            % get the estimated position for this point
            estimatedPos = pointsDict(pointName).pos{1};

            % get the ground truth position for this point
            gtPos = gtStruct.(groupName)(pointName).pos{1};

            % find NED position difference of estimatedPos relative to
            % reference point. 
            estimatedNed = lla2ned(estimatedPos,refPos,'ellipsoid');
            gtNed = lla2ned(gtPos,refGtPos,'ellipsoid');
            
            % relative NED positon with respect to reference point
            dataStruct.(groupName)(pointName).nedToRefer = {estimatedNed};
            gtStruct.(groupName)(pointName).nedToRefer = {gtNed};
            % relative horizontal errors
            dataStruct.(groupName)(pointName).horRel = norm([estimatedNed(1) - gtNed(1), estimatedNed(2) - gtNed(2)]);
            % relative vertical errors
            dataStruct.(groupName)(pointName).vertRel = abs(estimatedNed(3) - gtNed(3));
        end
    end
end
