function [ average ] = dynamicLabAverageAmp( data )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

endValue = 0;
t = 0:0.001:0.999;
f = dynamicsLabFrequencyOfData(data);
intervalLength = round(1/f/0.001);
amps = [];
workingArray = [];

for i = 1:1000
    if i <= intervalLength + endValue
        workingArray = [workingArray,abs(data(i))];
        
    else
        endValue = i;
        theAmp = max(workingArray);
        amps = [amps,theAmp];
        
        workingArray = [];
    end
end

average = mean(amps);