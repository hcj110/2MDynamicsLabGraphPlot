t = 0:0.001:0.999;

for i = 10:1:20
    name = sprintf('/Users/wangsiqi1992/Documents/MATLAB/Dynamics Lab/data/%u.mat',i);
    load(name);
    force = msrc1.Data(:,1);
    acceleration = msrc1.Data(:,2);
    
    plot(t,force,'r',t,acceleration,'b');
    gName = sprintf('/Users/wangsiqi1992/Documents/MATLAB/Dynamics Lab/simplePlot/%u.jpg',i);
    saveas(gcf,gName);
end