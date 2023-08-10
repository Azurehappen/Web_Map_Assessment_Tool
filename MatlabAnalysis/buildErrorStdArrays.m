function [north_std, east_std, horAbs_std] = buildErrorStdArrays(numbers, gt_struct, wh_struct, jf_struct, kh_struct)

north_errors = cell(1, length(numbers));
east_errors = cell(1, length(numbers));
horAbs_errors = cell(1, length(numbers));

groupNames = fieldnames(wh_struct);
for i = 1:length(groupNames)
    groupName = groupNames{i};
    pointsDict = gt_struct.(groupName);
    points = keys(pointsDict);
    for j = 1:length(points)
        pointName = points{j};
        num = gt_struct.(groupName)(pointName).x;
        ind = find(numbers == num);
        if isfield(wh_struct, groupName) && isKey(wh_struct.(groupName), pointName)
            north_errors{ind} = [north_errors{ind}, ...
                wh_struct.(groupName)(pointName).nedToGt{1}(1), ...
                jf_struct.(groupName)(pointName).nedToGt{1}(1), ...
                kh_struct.(groupName)(pointName).nedToGt{1}(1)];
            east_errors{ind} = [east_errors{ind}, ...
                wh_struct.(groupName)(pointName).nedToGt{1}(2), ...
                jf_struct.(groupName)(pointName).nedToGt{1}(2), ...
                kh_struct.(groupName)(pointName).nedToGt{1}(2)];
            horAbs_errors{ind} = [horAbs_errors{ind}, ...
                wh_struct.(groupName)(pointName).horAbs, ...
                jf_struct.(groupName)(pointName).horAbs, ...
                kh_struct.(groupName)(pointName).horAbs];
        end
    end
end

north_std = NaN(1, length(numbers));
east_std = NaN(1, length(numbers));
horAbs_std = NaN(1, length(numbers));

for i = 1:length(numbers)
    if isempty(north_errors{i})
        continue;
    end
    north_std(i) = std(north_errors{i}, 1);
    east_std(i) = std(east_errors{i}, 1);
    horAbs_std(i) = std(horAbs_errors{i}, 1);
end

end