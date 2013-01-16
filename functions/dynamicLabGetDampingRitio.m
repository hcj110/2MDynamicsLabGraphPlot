a = msrc1.Data(:,1);
b = msrc1.Data(:,2);
c = dynamicsLabFinePhaseDiffOf(a,b,r)
d = r/10.9
tan(c)*(1-d)^2/(2*d)