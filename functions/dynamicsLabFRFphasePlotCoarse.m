

phaseD = [];
t = 0:0.001:0.999;
f = [];


for i = 10:1:20
    name = sprintf('data/%u.mat',i);
    load(name);
    force = msrc1.Data(:,1);
    acceleration = msrc1.Data(:,2);
    phaseD = [phaseD,dynamicsLabPhaseDiffOf(force,acceleration)];
    f = [f,i];
end
plot(f,phaseD);
