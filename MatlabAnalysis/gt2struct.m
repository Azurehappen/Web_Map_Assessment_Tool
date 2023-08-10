function dataStruct = gt2struct(xlsxFile)
    % Read the Excel file
    dataTable = readtable(xlsxFile);
    
    % Convert the table to a cell array
    dataArray = table2cell(dataTable);
    
    % Initialize an empty struct
    dataStruct = struct();
    N = 1;
    
    % Loop over all rows in the cell array
    for i = 1:size(dataArray, 1)
        % Get the group name, point name, and coordinates
        groupName = dataArray{i, 1};
        pointName = dataArray{i, 2};
        coordinates = [dataArray{i, 3}, dataArray{i, 4}, dataArray{i, 5}];
        
        % If the group doesn't exist in the struct, add it
        if ~isfield(dataStruct, groupName)
            dataStruct.(groupName) = dictionary;
        end
        
        % Add the point name and coordinates to the group
        dataStruct.(groupName)(pointName) = struct();
        dataStruct.(groupName)(pointName).pos = {coordinates};
        dataStruct.(groupName)(pointName).x = N;
        N = N+1;
    end
end
