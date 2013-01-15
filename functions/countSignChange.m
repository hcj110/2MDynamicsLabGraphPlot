function [ n ] = countSignChange( data )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here

theSign = 1;
numberOfchange = 0;
for i = 1:size(data,2)
    if sign(data(i)) && sign(data(i)) ~= theSign
        theSign = sign(data(i));
        numberOfchange = numberOfchange +1;
    end


end
n  = numberOfchange;
dampedFreq = size(data,2)/(n/2);

