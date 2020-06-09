% Convert 1D array to 2D array representing 96-well plate

% Load file with grid of ImQuant FB data
impData = readtable(uigetfile({'*.txt','*.xls','*.xlsx'}));

% Convert from table to structure or array (depending on initial format)
if istable(impData) == 1
    brentArray = table2struct(impData); % Table with fields
elseif iscell(impData) == 1
    tempTable = cell2table(impData); % Convert cell array to table, then to struct
    brentArray = table2struct(impData);
else
    rawTable = struct(impData); % Something else???
    rawCell2Table = cell2table(rawTable.data); % Field data stored in .data as cell array
    rawVariables = rawCell2Table.Variables; % I don't even know what I'm doing anymore
    rawStruct = cell2struct(rawVariables, 'Fields');
end

% Load corresponding image
% im_ori = imread('ExpoFull_bottomRight_6.tif');
im_ori = imread(uigetfile({'*.tif', '*.tiff', '*.gel'}));
im_adj = imadjust(medfilt2(im_ori));

% Convert circle area to radii sizes
inArea = input('Enter Inner Circle Area (pixels) used for Image Quant'); % User enters inner radius Area (px^2) used for ImQuant 
outArea = input('Enter Outer Circle Area (pixels) used for Image Quant'); % User enters outer radius Area (px^2) used for ImQuant
spotType = 'InitialAnalysis';
radIn = sqrt(inArea / pi);
radOut = sqrt(outArea / pi);

% Run image through spotAnalyer function (pre-determine sizes of radii) 
[mySpots, myProps] = spotAnalyzer(im_adj, im_ori, radIn, radOut, spotType);
% Note that I switched original and adjusted images! 

myFB = cat(1,mySpots.FractionBound);
myArray = zeros(8,12);

j = 1;
for i = 1:size(myArray, 2)
myArray(:,i) = myFB(j:(j-1)+size(myArray,1));
j = (i * size(myArray, 1)) + 1;
end


