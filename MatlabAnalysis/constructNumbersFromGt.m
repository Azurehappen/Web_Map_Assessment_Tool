function [numbers, groups] = constructNumbersFromGt(gt_struct)

numbers = [];
groups = {};
groupNames = fieldnames(gt_struct);
for i = 1:length(groupNames)
    groupName = groupNames{i};
    pointsDict = gt_struct.(groupName);
    points = keys(pointsDict);
    for j = 1:length(points)
        pointName = points{j};
        numbers = [numbers, gt_struct.(groupName)(pointName).x];
        groups{end+1} = groupName;
    end
end
