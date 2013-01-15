function [ pdInDegree ] = dynamicsLabPhaseDiffOf( data1,data2 )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

t = 0:0.001:0.999;
rightI1 = 0;
rightI2 = 0;
insectionPoints1 = [];
insectionPoints2 = [];
f = dynamicsLabFrequencyOfData(data1);


amp1 = dynamicLabAverageAmp(data1);
amp2 = dynamicLabAverageAmp(data2);



for i = 1:1000
    if abs(data1(i))<amp1/5 && i-rightI1>20
            rightI1 = i;
            insectionPoints1 = [insectionPoints1,i];

    end
    
    if abs(data2(i))<amp2/5 && i-rightI2>20
            rightI2 = i;
            insectionPoints2 = [insectionPoints2,i];

    end
    
    
end


maxTs1 = [];
for i = 2:size(insectionPoints1,2)
    maxT = round((insectionPoints1(i)+insectionPoints1(i-1))/2);
    maxTs1 = [maxTs1,maxT];
end


maxTs2 = [];
for i = 2:size(insectionPoints2,2)
    maxT = round((insectionPoints2(i)+insectionPoints2(i-1))/2);
    maxTs2 = [maxTs2,maxT];
end


for i = 1:size(maxTs2,2)
    if maxTs2(i)-maxTs1(4)>=0
        phaseD = maxTs2(i)-maxTs1(4);
        break;
    end
end
pdInDegree = 360*phaseD*0.001/(1/f);
if pdInDegree<0.1 || pdInDegree>360
    pdInDegree = 360;
end

end

