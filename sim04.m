clc;
clear;
k=0.001;            %Slenderness ration
c= log(k);
xmin=0;
delta=0.1;          %head length in percentage of the total swimmer length
xmax=1;
dx=0.04;            %For length wise discretization for integration
dt=0.1;             %For temporal discretization
count1=1;           %Counter for the time loop
Tmax=100;           %Max simulation time
% SE2_profile=[0;0;0];
head_g=eye(3);
count1=1;
%title('Flexible swimmer''s shape configuration and velocities');
for time=0:dt:15
    F_tail=return_tail_forces(time, delta, xmax, k);
    A=return_connection(time, delta, k);
    xi=inv(A)*F_tail;
    xi(3)=xi(3)/10;
    xi_inertial=[0,     -xi(3),     xi(1);
        xi(3),      0,     xi(2);
        0,      0,         0];
    % 	xi_inertial=xi_lie_alg*head_g*inv(xi_lie_alg);
    %     theta_head=(45)*pi/180;
    %     head_g=[cos(theta_head), -sin(theta_head), -time*cos(theta_head)/50;
    %             sin(theta_head), cos(theta_head),  -time*sin(theta_head)/50;
    %             0,                              0,      1];
    data(count1,1)=time;
    data(count1,2:4)=xi';
    data(count1,5)=head_g(1,3);
    data(count1,6)=head_g(2,3);
    data(count1,7)=atan2(head_g(2,1),head_g(1,1));
    count1=count1+1;
    count=1;
    for x=0:0.02:1
        [r,u,m,t]=return_r_u_t(x,time);
        [global_x,global_r,global_u,global_t]=return_transformed_r_u_t(x,r,u,m,t,head_g);
        shapedata(count,1)=global_x;
        shapedata(count,2)=global_r;
        shapedata(count,3)=global_u(1);
        shapedata(count,4)=global_u(2);
        shapedata(count,5)=shapedata(count,1)+global_t(1)*0.5;
        shapedata(count,6)=shapedata(count,2)+global_t(2)*0.5;
        count=count+1;
    end
    index=30;
    l=sqrt((shapedata(index,4)-shapedata(index,1))^2+(shapedata(index,5)-shapedata(index,2))^2);
   plot(shapedata(:,1),shapedata(:,2),'ob');
%     hold on;
   axis equal;
   limit=1.1;
   axis([-limit limit -limit limit])
   grid on;
   pause(0.04);
   if time==0 || time==1.5 || time==3 || time==4.5 || time==6 || time==7.5 ...
           || time==9 || time==10.5 || time==12 || time==13.5 || time==15
       t
   end
   head_g=expm(xi_inertial*dt)*head_g;
end

Init_Graphics_Style;
figure();
plot(data(:,1),data(:,2),data(:,1),data(:,3));
legend('x velocity', 'y velocity')
xlabel('Time (Sec)');
ylabel('Translational velocities');
axis([0 10 -0.015 0.005])
grid on;

figure();
% subplot(223);
plot(data(:,1),data(:,4)*180/pi);
xlabel('Time (Sec)');
ylabel('Angular velocity (deg/sec)');
grid on;

figure();
% subplot(222);
plot(data(:,1),data(:,5),data(:,1),data(:,6));
legend('x position', 'y position')
xlabel('Time (Sec)');
ylabel('Translational positions');
grid on;

figure();
% subplot(224);
plot(data(:,1),data(:,7)*180/pi);
xlabel('Time (Sec)');
ylabel('Angular position (degree)');
grid on;
