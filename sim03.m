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
SE2_profile=[0;0;0];
min_force=999999;
max_force=-999999;
min_moment=999999;
max_moment=-999999;
flag=0;
for time=0:dt:Tmax
    count2=1;
    force=[0;0];
    moment=[0;0;0];
    r_head=[0.1;0;0];
    F_tail=return_tail_forces(time, delta, xmax, k);
    A=return_connection(time, delta, k);
    xi=inv(A)*F_tail;
    for x=xmin:dx:xmax
        % Position, velocity tangent vector computation
        data(count2,1)=x;
        [r,u,m,t]=return_r_u_t(x,time);
        data(count2,2)=r;
        data(count2,3)=u;
        data(count2,4)=data(count2,1)+t(1);
        data(count2,5)=data(count2,2)+t(2);
        count2=count2+1;
    end
    time_profile(:,count1)=time;
    force_profile(:,count1)=F_tail(1:2);
    moment_profile(:,count1)=F_tail(3);
    xi_profile(:,count1)=xi;
    SE2_profile(:,count1+1)=return_next_pos(SE2_profile(:,count1),xi,dt);
    %% Plot the swimmer position and velocities
    index=30;
    subplot('position',[0.05 0.15 0.25 0.8])
    plot(data(:,1),data(:,2),'-ob');
    hold on;
    plot(data(:,1),data(:,3),'-r');
    for i=1:8:length(data)
        x=[data(i,1);  data(i,4)];
        y=[data(i,2);  data(i,5)];
        plot(x,y,'-Og');
    end
    axis([-0.5 1.9 -1.2 1.2]);
    title('Swimmer motion')
    grid on;
    hold off;

    subplot('position',[0.45 0.6 0.2 0.33]);
    plot(time_profile(:),force_profile(1,:),time_profile(:),force_profile(2,:));
%     axis([0 Tmax min_force max_force]);
    hold on;
    xlabel('Time (Sec)');
    ylabel('Force (N)');
    grid on;
    subplot('position',[0.45 0.1 0.2 0.33]);
    plot(time_profile(:),moment_profile(1,:));
%     axis([0 Tmax min_moment max_moment]);
    xlabel('Time (Sec)');
    ylabel('Moment (Nm)');
    hold on;
    grid on;
    
    subplot('position',[0.75 0.6 0.2 0.33]);
    plot(time_profile(:),xi_profile(1,:),time_profile(:),xi_profile(2,:));
%     axis([0 Tmax min_force max_force]);
    hold on;
    xlabel('Time (Sec)');
    ylabel('Translational velocities (dimless)');
    grid on;
    subplot('position',[0.75 0.1 0.2 0.33]);
    plot(time_profile(:),xi_profile(3,:));
%     axis([0 Tmax min_moment max_moment]);
    xlabel('Time (Sec)');
    ylabel('Angular speed (dimless)');
    hold on;
    grid on;

    count1=count1+1;
    pause(0.001);
end
