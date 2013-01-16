forces = [];
accelerations = [];
t = 0:0.001:0.999;

for i = 10:1:20
    name = sprintf('data/%u.mat',i);
    load(name);
    force = msrc1.Data(:,1);
    acceleration = msrc1.Data(:,2);
    accelerations = [accelerations,dynamicLabAverageAmp(acceleration)];
    forces = [forces,dynamicLabAverageAmp(force)];
end
f = 10:1:20;
plot(f,forces,'r',f,accelerations,'b');

