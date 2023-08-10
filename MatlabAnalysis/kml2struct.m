function kmlStruct = kml2struct(kmlFile)
    % Parse KML file
    kmlNode = xmlread(kmlFile);

    % Find all Folder nodes in the KML
    folders = kmlNode.getElementsByTagName('Folder');

    kmlStruct = struct(); 

    % Loop over all folders
    for i = 0:folders.getLength-1
        folderNode = folders.item(i);
        
        % Get the name of the folder
        folderName = char(folderNode.getElementsByTagName('name').item(0).getFirstChild.getData);
        
        % Initialize an empty map
        pointDict = dictionary;
        
        % Find all Placemark nodes under the current Folder
        placemarks = folderNode.getElementsByTagName('Placemark');
        
        % Loop over all placemarks
        for j = 0:placemarks.getLength-1
            placemarkNode = placemarks.item(j);
            
            % Get the name of the placemark
            placemarkName = char(placemarkNode.getElementsByTagName('name').item(0).getFirstChild.getData);
            
            % Get the coordinates of the placemark
            coordStr = char(placemarkNode.getElementsByTagName('coordinates').item(0).getFirstChild.getData);
            coordinates = str2double(strsplit(coordStr, ','));
            coordinates = {[coordinates(2), coordinates(1), coordinates(3)]};
            
            % Add placemark and coordinates to the map
            % The coordinates are Lat, Lng, Ele
            pointDict(placemarkName) = struct();
            pointDict(placemarkName).pos = coordinates;
        end
        
        % Add folder and point map to the struct
        kmlStruct.(folderName) = pointDict;
    end
end
