function dataStruct = computeAbsPosErr(dataStruct, gtStruct)
    groupNames = fieldnames(dataStruct);

    for i = 1:length(groupNames)
        groupName = groupNames{i};

        if ~isfield(gtStruct, groupName)
            continue;
        end

        % get all points from the dict of this group
        pointsDict = dataStruct.(groupName);
        points = keys(pointsDict);
        for j = 1:length(points)
            pointName = points{j};

            % check if gt exist
            if ~isKey(gtStruct.(groupName), pointName)
                continue;
            end

            % get the estimated position for this point
            estimatedPos = pointsDict(pointName).pos{1};

            % Get the ground truth position for this point
            gtPos = gtStruct.(groupName)(pointName).pos{1};

            % Find NED position difference of estimatedPos relative to
            % gtPos. 
            xyzNED = lla2ned(estimatedPos,gtPos,'ellipsoid');
            
            % NED positon with respect to GT position
            dataStruct.(groupName)(pointName).nedToGt = {xyzNED};
            % abosolute horizontal errors
            dataStruct.(groupName)(pointName).horAbs = norm([xyzNED(1), xyzNED(2)]);
            % absolute vertical errors
            dataStruct.(groupName)(pointName).vertAbs = abs(xyzNED(3));
        end
    end
end
