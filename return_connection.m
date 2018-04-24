function A=return_connection(time, delta, k)

[r,u,m,t]=return_r_u_t(0,time);
c= log(k);
tx=t(1);
ty=t(2);

a11=-c*delta-delta*log(2)*tx*tx-delta*log(2);
a12=-delta*log(2)*ty+2*delta*log(2);
a13=-delta^2/2*ty-log(2)*delta^2/2*ty*tx*tx-log(2)*delta^2/2+...
    3*delta^2/2*ty*tx*tx-delta^2*ty;
a21=delta*log(2)*tx*ty;
a22=-c*delta-delta*log(2)*ty*ty-2*delta*log(2);
a23=c*delta^2/2-(2*log(2)-2)*delta^2/2*ty;

a31=c*delta^2/2-(2*log(2)-2)*delta^2/2*ty;
a32=-delta^2/2*c*tx+(2*log(2)-2)*delta^2/2*tx;
a33=-delta^3/3*tx^2-2/3*delta^3*ty^2-(2*log(2)-2)*delta^2/2*tx;

A=[a11,     a12,       a13;
   a21,     a22,       a23;
   a31,     a32,       a33];