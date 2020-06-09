function [fFactor, cvValue] = fanoFactor(meanValue, stdValue)
% Calculate Fano Factor and Coefficient of Variance (CV) from a given mean
% and standard deviation
%
% Input:
%   meanValue: Mean of two numbers
%   stdValue : Standard Deviation of two numbers
%
% Output:
%   fFactor  : Calculated Fano Factor
%   cvValue  : Calculated Coefficient of Variance
%
% Equation: Fano Factor is the standard deviation over the square of the mean
%   fFactor = stdValue / (meanValue ^2)

cvValue = stdValue / meanValue;
fFactor = stdValue / meanValue^2;