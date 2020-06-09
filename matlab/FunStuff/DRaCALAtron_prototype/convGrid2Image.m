synthImage_col = zeros(round(sqrt(gridFull(end).Spot)));
synthImage_row = zeros(round(sqrt(gridFull(end).Spot)));
% synthImage_col = false(); % Faster and more memory efficient to construct zero array
j=1;
ptime = 0.01;

for i = 1:size(synthImage_col, 1)
synthImage_col(:,i) = gridInts(j : ((j - 1) + size(synthImage_col, 1)));
synthImage_row(i,:) = gridInts(j : ((j - 1) + size(synthImage_row, 1)));

subplot(121);
imagesc(synthImage_col), axis image, axis off;

subplot(122);
imagesc(synthImage_row), axis image, axis off;

j = (i * size(synthImage_row, 1)) + 1;
pause(ptime);
end



% Convert 1D array to 2D array representing 96-well plate
%{ 
% Load .xlsx file with 8x12 grid of ImQuant FB data
brentArray = table2array(importExcelData);

im_ori = imread('ExpoFull_bottomRight_6.tif');
im_adj = imadjust(medfilt2(im_ori));

[mySpots, myProps] = spotAnalyzer(im_adj, im_ori, radIn, radOut, spotType);
% Note that I switched original and adjusted images! 
myFB = cat(1,mySpots.FractionBound);
myArray = zeros(8,12);

j = 1;
for i = 1:size(myArray, 2)
myArray(:,i) = myFB(j:(j-1)+size(myArray,1));
j = (i * size(myArray, 1)) + 1;
end
%}