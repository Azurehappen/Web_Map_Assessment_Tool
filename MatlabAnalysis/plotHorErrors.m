function plotHorErrors(dataStruct, groupToColorDict, isAbsErr, gtStruct)
    % Get the list of group names
    groupNames = fieldnames(dataStruct);
    hold on;
    totalHorErr = [];
    if isAbsErr
        postfix = 'Abs';
        yLabel = 'Horizontal Absolute Error';
    else
        postfix = 'Rel';
        yLabel = 'Horizontal Relative Error';
    end
    horField = ['hor' postfix];

     % Loop over all groups
    for i = 1:length(groupNames)
        groupName = groupNames{i};
        
        % Get the dictionary of points for this group
        pointsMap = dataStruct.(groupName);
        
        % Get the list of point names
        pointNames = keys(pointsMap);
        
        % Get the horizontal errors for all points
        %horizontalErrors = cellfun(@(pn) pointsMap(pn).hor, pointNames);

        % Initialize a cell array to hold the horizontal errors
        horizontalErrors = [];
        %validPointNames = {};
        validPointNo = [];

        % Loop over all points
        for j = 1:length(pointNames)
            pointName = pointNames{j};

            % If the 'hor' field exists, save the horizontal error and the point name
            if isfield(pointsMap(pointName), horField)
                err = pointsMap(pointName).(horField);
                horizontalErrors = [horizontalErrors, err];
                % Skip the reference point in relative positions.
                if isAbsErr || err ~= 0
                    totalHorErr = [totalHorErr, err];
                end
                %validPointNames = [validPointNames, strrep(pointName, '_', '\_')];
                validPointNo = [validPointNo, gtStruct.(groupName)(pointName).x];
            end
        end
        
        % Plot the horizontal errors for this group
        %scatter(categorical(validPointNames), horizontalErrors, 'filled',...
        %    'MarkerFaceColor', groupToColorDict(groupName),...
        %    'DisplayName', strrep(groupName, '_', '\_'));
        scatter(validPointNo, horizontalErrors, 'filled',...
            'MarkerFaceColor', groupToColorDict(groupName),...
            'DisplayName', strrep(groupName, '_', '\_'));
    end
    
    hold off;
    ax = gca;
    ax.FontSize = 16;
    ylim([0, 2.5]);
    %xtickangle(45); % Set the angle of x-axis labels to 45 degrees
    xlim([0,82]);
    ylabel(yLabel);
    legend('Location', 'best');
    grid on;

    disp(['The ' yLabel ' mean is: ' num2str(mean(totalHorErr))]);
    disp(['The ' yLabel ' RMS is: ' num2str(rms(totalHorErr))]);
end
