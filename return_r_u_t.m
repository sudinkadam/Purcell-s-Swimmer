function [r,u,m,t]=return_r_u_t(x,t)
%     r=-x/2*sin(x*10+t);                  %(10-x)*sin(x/10+t)
%     u=-x/2*cos(x*10+t);
%     m=-1/2*sin(x*10+t)-5*x*cos(10*x+t);
%     t=[cos(atan(m));sin(atan(m))];
x
t
d=15;
e=1000000;
delta=0;
T=15;
if x>delta+(-1+t/T) && x <delta+(1+t/T)
    r=e*exp(-d/(1-(x-t/T)^2));
    u=e*exp(-d/(1-(x-t/T)^2))*1/(1-(x-t/T)^2)^2*(2/T*(x-t/T));
    m=e*exp(-d/(1-(x-t/T)^2))*(d/(1-(x-t/T)^2)^2)*(-2*(x-t/T));
else
    r=0;
    u=0;
    m=0;
end
    t=[cos(atan(m));sin(atan(m))];