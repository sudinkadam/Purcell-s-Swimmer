function [r,Rx]=return_orientation(t, x, y_pos)

[y_pos,u,m,t]=return_r_u_t(x,t);

theta=atan(m);
Rx=[cos(theta),     sin(theta);
    -sin(theta),    cos(theta)];

r=[x;y_pos];