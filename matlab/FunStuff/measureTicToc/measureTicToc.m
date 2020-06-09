function [ticTocData] = measureTicToc(pTime, numTests, replicates)
% measureTicToc: Function to measure clock lag due to background or other
% processes. Matlab's tic and toc functions track the elapsed time between
% processes by measuring the passage of internal clock time at execution.
% However, the true measure of time can be skewed by heavy background or
% foreground processes. This function utilizes Matlab's pause function to
% measure the amount of lag from the tic toc functions. 
%
% Usage:
% [ticTocData] = measureTicToc(pTime, numTests, replicates)
% 
% Input:
%   pTime      (f):  Time between tic-toc intervals in seconds. Smaller numbers (pTime < 1) are more prone to noise and are likely less accurate. 
%   numTests   (f):  Number of trials to measure pTime intervals. 
%   replicates (f):  Number of times to run test. 
%     
% Output:
%   expTime    (f[])  :  Expected time (s) for test. 
%   trueTime   (f[])  :  Actual time for test. 
%   diffTime   (f[])  :  Lag from expected time (difference of actual to expected).
%   avgTime    (f[])  :  Average time for each pTime interval. 
%   results    (str{}):  String containing results of each replicate. 

% Option to save ALL pTime points. This can use A LOT of data depending on parameters. 
ticTocData = struct('TestAvgs', struct('Header', [], 'Results', {1:length(replicates)}, 'ExpectedTime', [1:length(replicates)], 'TrueTime', [1:length(replicates)], 'TimeLag', [1:length(replicates)], 'MeanTime', [1:length(replicates)]), 'PointData', []);
ticTocData.TestAvgs.Header = sprintf('Test#\tExpectedTime\tRealTime\tTimeLag\tAvgPause');
ticTocData.TestAvgs.ExpectedTime = pTime * numTests;
ticTocData.PointData = struct('pTimes', [1:length(numTests)]);

figure(1);
subplot(221); 
title('All Point Data');
ylim([0 (10 * pTime)]);
hold off;

fprintf('Test#\tExpectedTime\tRealTime\tTimeLag\t\tAvgPause\n');

for i = 1:replicates
% Run Test
    fullTime = tic;
    for ii = 1:numTests                
        tickTime = tic;
        pause(pTime);
        ticTocData.PointData(i).pTimes(ii) = toc(tickTime);
    end
    
% Test Results    
    ticTocData.TestAvgs(i).TrueTime = toc(fullTime);
    ticTocData.TestAvgs(i).MeanTime = mean(ticTocData.PointData(i).pTimes(ii));
    ticTocData.TestAvgs(i).TimeLag = ticTocData.TestAvgs(i).TrueTime - ticTocData.TestAvgs(1).ExpectedTime;
    
    fprintf('\t%d\t\t%.04f\t\t%.04f\t\t%.04f\t\t%.04f\n', i, ticTocData.TestAvgs(1).ExpectedTime, ticTocData.TestAvgs(i).TrueTime, ticTocData.TestAvgs(i).TimeLag, ticTocData.TestAvgs(i).MeanTime);
    ticTocData.TestAvgs(i).Results = sprintf('%d\t%.04f\t%.04f\t%.04f\t%.04f', i, ticTocData.TestAvgs(1).ExpectedTime, ticTocData.TestAvgs(i).TrueTime, ticTocData.TestAvgs(i).TimeLag, ticTocData.TestAvgs(i).MeanTime);        
    
% Plot time of all pTime intervals
    hold on;    
    plot(ticTocData.PointData(i).pTimes, '.');
    
    
end

% Save Test Results in .mat file
save('measureTicToc_data', 'ticTocData');

% figure(2);
trueTime = cat(1, ticTocData.TestAvgs.TrueTime);
lagTime = cat(1, ticTocData.TestAvgs.TimeLag);
meanTime = cat(1, ticTocData.TestAvgs.MeanTime);

subplot(222);
plot(trueTime, 'bo');
refline([0 ticTocData.TestAvgs(1).ExpectedTime]);
title('Average Time per Test (s)');
% ylim([0 max(trueTime)]);

subplot(223);
plot(lagTime, 'ro');
refline([0 ticTocData.TestAvgs(1).ExpectedTime]);
title('Average Time Lag (s)');
% ylim([0 max(lagTime)]);

subplot(224);
plot(meanTime, 'go');
refline([0 pTime]);
title('Mean pTime Interval (s)');
% ylim([0 max(meanTime)]);

hold off;
