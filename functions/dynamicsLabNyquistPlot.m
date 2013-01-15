forces = [];
accelerations = [];
t = 0:0.001:0.999;
goodNames = [];

d = '/Users/wangsiqi1992/Documents/MATLAB/Dynamics Lab/data/fine measurment';
list = dir(d);

for i = 1:length(list)
    fName = list(i).name;
    idx = max(strfind(fName,'.'));

    extension = fName(idx+1:end);
    
    if issame('mat',extension)
        
        freq = fName(1:idx-1);

        msbIDX = strfind(freq,'-');
        msb = freq(1:msbIDX-1);
        lsb = freq(msbIDX+1:end);
        lsbNum = str2num(lsb)/10^length(lsb);
        f = str2num(msb)+lsbNum;
        
        g.name = fName;
        g.freq = f;
        
        
        goodNames = [goodNames,g];
    end
end

    
f = [];
phaseDiffS = [];
for i = 1:size(goodNames,2)

    cd(d);
    fName = goodNames(i).name;
    load(fName);
    force = msrc1.Data(:,1);
    acceleration = msrc1.Data(:,2);
    accelerations = [accelerations,dynamicLabAverageAmp(acceleration)];
    forces = [forces,dynamicLabAverageAmp(force)];
    
    f = [f,goodNames(i).freq];
    phaseD = dynamicsLabFinePhaseDiffOf(acceleration,force,goodNames(i).freq);
    phaseDiffS = [phaseDiffS,phaseD];
end

frf = accelerations./forces;
real = frf.*cos(deg2rad(-phaseDiffS));
img = frf.*sin(deg2rad(-phaseDiffS));


[x,y,R] = circfit(real,img);




angle = 0:0.001:2*pi;
xc = R*cos(angle)+x;
yc = R*sin(angle)+y;

str = sprintf('center (%0.5g , %0.5g );  R=%0.5g',x,y,R);


plot(real,img,'r+',xc,yc,'b'),
title(['Nyquist Plot for fine sweep, ',str])
      legend('measured','fitted')
     xlabel x, ylabel y 
     axis equal

