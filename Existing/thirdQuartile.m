function [ thirdQuartile ] = thirdQuartile( values )
%THIRDQUARTILE Summary of this function goes here
%   Detailed explanation goes here
    m = median(values);
    nset = values(values > m);
    thirdQuartile = median(nset);
end

