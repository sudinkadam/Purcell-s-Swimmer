function [global_x,global_r,global_u,global_t]=return_transformed_r_u_t(x,r,u,m,t,head_g)

base_g=[1,  0,  x;
        0,  1,  r;
        0,  0,  1];
global_r=head_g*base_g;

base_u=[1,  0,  x;
        0,  1,  u;
        0,  0,  1];
macro_u=head_g*base_u;

head_orientation=atan2(head_g(2,1),head_g(1,1));
global_x=global_r(1,3);
global_r=global_r(2,3);
global_u=[macro_u(1,3); macro_u(2,3)];
global_t=[cos(atan(m)+head_orientation);sin(atan(m)+head_orientation)];

% r=x/2*sin(x*10+time);
% u=x/2*cos(x*10+time);
% m=1/2*sin(x*10+time)+5*x*cos(10*x+time);
% t=[cos(atan(m));sin(atan(m))];