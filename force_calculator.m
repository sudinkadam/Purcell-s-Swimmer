function [force,moment]=force_calculator(u, t, xmin, xmax, k)

c= log(k);
dx=0.01;

force=[0;0];
moment=0;

for x=xmin:dx:xmax
    force+=-c*u(x)-log(2)*u(x).(t(x)*t(x))-2*log(2)*u(x);
    force+=-3*u(x).t(x)*t(x)-2*u(x)*;
    force=force*dx/sqrt(1+r'(x)^2);
    integrand=-c*u(x)-log(2)*u(x).[t(x)*t(x)-2*log(2)*u(x)
    integrand+=-3*u(x).t(x)*t(x)-2*u(x)
    moment+=cross(R(x),integrand);

force=-force;
    

