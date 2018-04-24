function F_tail=return_tail_forces(time, xmin, xmax, k)

c= log(k);
dx=0.01;

force=[0;0];
moment=[0;0;0];

for x=xmin:dx:xmax
    [y_pos,u_y,m,t]=return_r_u_t(x,time);
    u=[0;u_y];
    [r_x,Rot_x]=return_orientation(time, x, y_pos);
    force=force+inv(Rot_x)*((-c*u-log(2)*dot(u,t)*t-2*log(2)*u...
        -3*dot(u,t)*t-2*u)*dx/sqrt(1+m^2));

    integrand=(-c*u-log(2)*dot(u,t)*t-2*log(2)*u-3*dot(u,t)*t-2*u)...
        *dx/sqrt(1+m^2);
    moment=moment+cross([r_x;0],[integrand;0])*dx;
end

F_tail=[-force;-moment(3)];