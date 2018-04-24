clc;
clear;

xmax=1;
title('Flexible swimmer''s shape configuration and velocities');
for time=0:0.1:100
    theta_head=(45)*pi/180;
    head_g=[cos(theta_head), -sin(theta_head), -time*cos(theta_head)/50;
            sin(theta_head), cos(theta_head),  -time*sin(theta_head)/50;
            0,                              0,      1];
    count=1;
    for x=0:0.02:1
        [r,u,m,t]=return_r_u_t(x,time);
        [global_x,global_r,global_u,global_t]=return_transformed_r_u_t(x,r,u,m,t,head_g);
        data(count,1)=global_x;
        data(count,2)=global_r;
        data(count,3)=global_u(1);
        data(count,4)=global_u(2);
        data(count,5)=data(count,1)+global_t(1)*0.5;
        data(count,6)=data(count,2)+global_t(2)*0.5;
        count=count+1;
    end
    index=30;
    l=sqrt((data(index,4)-data(index,1))^2+(data(index,5)-data(index,2))^2)
    plot(data(:,1),data(:,2),'ob');
    hold on;
    plot(data(:,3),data(:,4),'-r');
    for i=1:8:length(data)
        x=[data(i,1);  data(i,5)];
        y=[data(i,2);  data(i,6)];
        plot(x,y,'-Og');
    end
    hold off;
    axis equal;
    axis([-2 2 -2 2])
    grid on;
    pause(0.04);
end