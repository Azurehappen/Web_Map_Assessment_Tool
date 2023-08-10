function [jfStruct, khStruct, whStruct] = xlsx2structs(xlsxFile)
    % Read the Excel file
    dataTable = readtable(xlsxFile);
    
    % Convert the table to a cell array
    dataArray = table2cell(dataTable);
    
    % Initialize empty structs for each source
    jfStruct = struct();
    khStruct = struct();
    whStruct = struct();
    
    % Loop over all rows in the cell array
    for i = 1:size(dataArray, 1)
        % Get the group name and point name
        groupName = dataArray{i, 1};
        pointName = dataArray{i, 2};
        
        % Get the coordinates for each source
        jfCoordinates = [dataArray{i, 3}, dataArray{i, 4}, dataArray{i, 5}];
        khCoordinates = [dataArray{i, 6}, dataArray{i, 7}, dataArray{i, 8}];
        whCoordinates = [dataArray{i, 9}, dataArray{i, 10}, dataArray{i, 11}];
        
        % Add the data to the appropriate struct
        jfStruct = addDataToStruct(jfStruct, groupName, pointName, jfCoordinates);
        khStruct = addDataToStruct(khStruct, groupName, pointName, khCoordinates);
        whStruct = addDataToStruct(whStruct, groupName, pointName, whCoordinates);
    end
end

function dataStruct = addDataToStruct(dataStruct, groupName, pointName, coordinates)
    % If the group doesn't exist in the struct, add it
    if ~isfield(dataStruct, groupName)
        dataStruct.(groupName) = dictionary;
    end

    % Add the point name and coordinates to the group
    dataStruct.(groupName)(pointName) = struct();
    dataStruct.(groupName)(pointName).pos = {coordinates};
end
