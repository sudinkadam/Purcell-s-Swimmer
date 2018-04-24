function [r,u,m,t]=return_r_u_t(x,t)
    r=x/2*sin(x*10+t);                  %(10-x)*sin(x/10+t)
    u=x/2*cos(x*10+t);
    m=1/2*sin(x*10+t)+5*x*cos(10*x+t);
    t=[cos(atan(m));sin(atan(m))];
