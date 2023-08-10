% Google Earth Files
kml_wh = '../Feature Information/KML_files/Corrected_GE_WH.kml';
kml_jaf = '../Feature Information/KML_files/Corrected_GE_JAF.kml';
kml_kh = '../Feature Information/KML_files/Corrected_GE_KH.kml';

% MapBox points data sheet
mapbox_path = '../Feature Information/leidos_feature_points_MapBox.xlsx';

% Microsoft points data sheet
azure_path = '../Feature Information/leidos_feature_points_microsoft.xlsx';

% Ground truth points data sheet
gt_path = '../Feature Information/leidos_feature_points_Survey_2023_01_01.xlsx';

% Read feature point position
kml_wh_struct = kml2struct(kml_wh);
kml_jf_struct = kml2struct(kml_jaf);
kml_kh_struct = kml2struct(kml_kh);

[mapbox_jf_struct, mapbox_kh_struct, mapbox_wh_struct] = xlsx2structs(mapbox_path);

[azure_jf_struct, azure_kh_struct, azure_wh_struct] = xlsx2structs(azure_path);

gt_struct = gt2struct(gt_path);


%% Compute absolute accuracy
% Compute position errors
% The compute structure is:
% struct->field(group name)->dict(point name)->point_struct
% point_struct has fields:
%   pos: Lat, Lng, Ele position vector
%   nedToGt: NED coordinates corresponding to its GT
%   horAbs: Horizontal position error
kml_wh_struct = computeAbsPosErr(kml_wh_struct, gt_struct);
kml_jf_struct = computeAbsPosErr(kml_jf_struct, gt_struct);
kml_kh_struct = computeAbsPosErr(kml_kh_struct, gt_struct);

mapbox_wh_struct = computeAbsPosErr(mapbox_wh_struct, gt_struct);
mapbox_jf_struct = computeAbsPosErr(mapbox_jf_struct, gt_struct);
mapbox_kh_struct = computeAbsPosErr(mapbox_kh_struct, gt_struct);

azure_wh_struct = computeAbsPosErr(azure_wh_struct, gt_struct);
azure_jf_struct = computeAbsPosErr(azure_jf_struct, gt_struct);
azure_kh_struct = computeAbsPosErr(azure_kh_struct, gt_struct);

%% Compute relative accuracy
groupToRefer = dictionary;
groupToRefer('Group_1') = 'cecert_40';
groupToRefer('Group_2') = 'Z17065';
groupToRefer('Group_3') = 'Z15220';
groupToRefer('Group_4') = 'Z16671';
groupToRefer('Group_5') = 'Z13133';
groupToRefer('Group_6') = 'Z17697';

% point_struct has additional fields:
%   nedToRefer: NED coordinates corresponding to its reference point
%   horRel: Horizontal position error

kml_wh_struct = computeRelativePosErr(kml_wh_struct, gt_struct, groupToRefer);
kml_jf_struct = computeRelativePosErr(kml_jf_struct, gt_struct, groupToRefer);
kml_kh_struct = computeRelativePosErr(kml_kh_struct, gt_struct, groupToRefer);

mapbox_wh_struct = computeRelativePosErr(mapbox_wh_struct, gt_struct, groupToRefer);
mapbox_jf_struct = computeRelativePosErr(mapbox_jf_struct, gt_struct, groupToRefer);
mapbox_kh_struct = computeRelativePosErr(mapbox_kh_struct, gt_struct, groupToRefer);

azure_wh_struct = computeRelativePosErr(azure_wh_struct, gt_struct, groupToRefer);
azure_jf_struct = computeRelativePosErr(azure_jf_struct, gt_struct, groupToRefer);
azure_kh_struct = computeRelativePosErr(azure_kh_struct, gt_struct, groupToRefer);

%% Plots for absolute accuracy
isAbsErr = true;
% Plot horizontal errors
% define the group name to color hashmap
groupToColorDict = dictionary;
groupToColorDict('Group_1') = 'r';
groupToColorDict('Group_2') = 'g';
groupToColorDict('Group_3') = 'b';
groupToColorDict('Group_4') = 'c';
groupToColorDict('Group_5') = 'm';
groupToColorDict('Group_6') = 'k';

figure(1);clf;
set(gcf,'color','white')
subplot(321)
disp('Summary for Google Earth clicked by Wang');
plotHorErrors(kml_wh_struct, groupToColorDict, isAbsErr, gt_struct);
title('Google Earth points clicked by Wang', 'FontSize', 16)
subplot(323)
disp('Summary for Google Earth clicked by Jay');
plotHorErrors(kml_jf_struct, groupToColorDict, isAbsErr, gt_struct);
title('Google Earth points clicked by Jay', 'FontSize', 16)
subplot(325)
disp('Summary for Google Earth clicked by Kathryn');
plotHorErrors(kml_kh_struct, groupToColorDict, isAbsErr, gt_struct);
xlabel('Point Number');
title('Google Earth points clicked by Kathryn', 'FontSize', 16)


figure(2);clf;
set(gcf,'color','white')
subplot(321)
disp('Summary for MapBox clicked by Wang');
plotHorErrors(mapbox_wh_struct, groupToColorDict, isAbsErr, gt_struct);
title('MapBox points clicked by Wang', 'FontSize', 16)
subplot(323)
disp('Summary for MapBox clicked by Jay');
plotHorErrors(mapbox_jf_struct, groupToColorDict, isAbsErr, gt_struct);
title('MapBox points clicked by Jay', 'FontSize', 16)
subplot(325)
disp('Summary for MapBox clicked by Kathryn');
plotHorErrors(mapbox_kh_struct, groupToColorDict, isAbsErr, gt_struct);
xlabel('Point Number');
title('MapBox points clicked by Kathryn', 'FontSize', 16)


figure(3);clf;
set(gcf,'color','white')
subplot(321)
disp('Summary for Microsoft clicked by Wang');
plotHorErrors(azure_wh_struct, groupToColorDict, isAbsErr, gt_struct);
title('Microsoft Azure points clicked by Wang', 'FontSize', 16)
subplot(323)
disp('Summary for Microsoft clicked by Jay');
plotHorErrors(azure_jf_struct, groupToColorDict, isAbsErr, gt_struct);
title('Microsoft Azure points clicked by Jay', 'FontSize', 16)
subplot(325)
disp('Summary for Microsoft clicked by Kathryn');
plotHorErrors(azure_kh_struct, groupToColorDict, isAbsErr, gt_struct);
xlabel('Point Number');
title('Microsoft Azure points clicked by Kathryn', 'FontSize', 16)

%% Plots for relative accuracy
isAbsErr = false;
figure(1);
subplot(322)
disp('Summary for Google Earth clicked by Wang');
plotHorErrors(kml_wh_struct, groupToColorDict, isAbsErr, gt_struct);
title('Google Earth points clicked by Wang', 'FontSize', 16)
subplot(324)
disp('Summary for Google Earth clicked by Jay');
plotHorErrors(kml_jf_struct, groupToColorDict, isAbsErr, gt_struct);
title('Google Earth points clicked by Jay', 'FontSize', 16)
subplot(326)
disp('Summary for Google Earth clicked by Kathryn');
plotHorErrors(kml_kh_struct, groupToColorDict, isAbsErr, gt_struct);
xlabel('Point Number');
title('Google Earth points clicked by Kathryn', 'FontSize', 16)


figure(2);
subplot(322)
disp('Summary for MapBox clicked by Wang');
plotHorErrors(mapbox_wh_struct, groupToColorDict, isAbsErr, gt_struct);
title('MapBox points clicked by Wang', 'FontSize', 16)
subplot(324)
disp('Summary for MapBox clicked by Jay');
plotHorErrors(mapbox_jf_struct, groupToColorDict, isAbsErr, gt_struct);
title('MapBox points clicked by Jay', 'FontSize', 16)
subplot(326)
disp('Summary for MapBox clicked by Kathryn');
plotHorErrors(mapbox_kh_struct, groupToColorDict, isAbsErr, gt_struct);
xlabel('Point Number');
title('MapBox points clicked by Kathryn', 'FontSize', 16)


figure(3);
subplot(322)
disp('Summary for Microsoft clicked by Wang');
plotHorErrors(azure_wh_struct, groupToColorDict, isAbsErr, gt_struct);
title('Microsoft Azure points clicked by Wang', 'FontSize', 16)
subplot(324)
disp('Summary for Microsoft clicked by Jay');
plotHorErrors(azure_jf_struct, groupToColorDict, isAbsErr, gt_struct);
title('Microsoft Azure points clicked by Jay', 'FontSize', 16)
subplot(326)
disp('Summary for Microsoft clicked by Kathryn');
plotHorErrors(azure_kh_struct, groupToColorDict, isAbsErr, gt_struct);
xlabel('Point Number');
title('Microsoft Azure points clicked by Kathryn', 'FontSize', 16)

%% STD for human operation

% Collect all north and east abs error std.
[numbers, groups] = constructNumbersFromGt(gt_struct);
[kml_north_std, kml_east_std, kml_horAbs_std] = buildErrorStdArrays(...
    numbers, gt_struct, kml_wh_struct, kml_jf_struct, kml_kh_struct);
[mapbox_north_std, mapbox_east_std, mapbox_horAbs_std] = buildErrorStdArrays(...
    numbers, gt_struct, mapbox_wh_struct, mapbox_jf_struct, mapbox_kh_struct);
[azure_north_std, azure_east_std, azure_horAbs_std] = buildErrorStdArrays(...
    numbers, gt_struct, azure_wh_struct, azure_jf_struct, azure_kh_struct);

figure(4);clf;
set(gcf,'color','white')
subplot(311)
scatter(numbers, kml_north_std, 'filled')
hold on
scatter(numbers, kml_east_std, 'filled')
scatter(numbers, kml_horAbs_std, 'filled')
legend('North STD', 'East STD', 'Abs. hor. STD')
legend('Location', 'best');
grid on
ax = gca;
ax.FontSize = 16;
xlim([0, 82]);
ylim([0, 0.15]);
ylabel('Error STD, m')
title('Google Earth', 'FontSize', 16)
subplot(312)
scatter(numbers, mapbox_north_std, 'filled')
hold on
scatter(numbers, mapbox_east_std, 'filled')
scatter(numbers, mapbox_horAbs_std, 'filled')
legend('North STD', 'East STD', 'Abs. hor. STD')
legend('Location', 'best');
grid on
ax = gca;
ax.FontSize = 16;
xlim([0, 82]);
ylim([0, 0.15]);
ylabel('Error STD, m')
title('Mapbox', 'FontSize', 16)
subplot(313)
scatter(numbers, azure_north_std, 'filled')
hold on
scatter(numbers, azure_east_std, 'filled')
scatter(numbers, azure_horAbs_std, 'filled')
legend('North STD', 'East STD', 'Abs. hor. STD')
legend('Location', 'best');
grid on
ax = gca;
ax.FontSize = 16;
xlim([0, 82]);
ylim([0, 0.15]);
ylabel('Error STD, m')
xlabel('Point number');
title('Microsoft Azure', 'FontSize', 16)