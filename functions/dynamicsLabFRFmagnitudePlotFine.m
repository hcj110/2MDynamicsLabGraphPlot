forces = [];
accelerations = [];
t = 0:0.001:0.999;
goodNames = [];

d = 'data/fine measurment/';
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
for i = 1:size(goodNames,2)
    fName = [d, goodNames(i).name];
    load(fName);
    force = msrc1.Data(:,1);
    acceleration = msrc1.Data(:,2);
    accelerations = [accelerations,dynamicLabAverageAmp(acceleration)];
    forces = [forces,dynamicLabAverageAmp(force)];
    
    f = [f,goodNames(i).freq];
end

frf = accelerations./forces;
plot(f,frf);
