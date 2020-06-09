myData = uigetfile();
myFB = cat(1, myData.FractionBound);

rawData = readtable(uigetfile({'*.xls', '*.xlsx'}));

inc = 8;
for i = 1:size(rawData(2))
    rawFB = rawData((i):(inc), :);
end
