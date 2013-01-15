function [ f ] = dynamicsLabFrequencyOfData( data )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
t = 0:0.001:0.999;
rightI = 0;
insectionPoints = [];
for i = 1:1000
    if length(insectionPoints)>=3
        break;
    end
    if abs(data(i))<0.1 && i-rightI>20
            rightI = i;
            insectionPoints = [insectionPoints,i];

    end
    
end


f = 1/(0.001*(insectionPoints(3)-insectionPoints(1))/2);

