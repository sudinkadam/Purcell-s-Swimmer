clc;
clear;
k=0.001;
c= log(k);
xmin=0;
xmax=1;
dx=0.04;
count1=1;
Tmax=10;
min_force=999999;
max_force=-999999;
min_moment=999999;
max_moment=-999999;
flag=0;
for time=0:0.1:Tmax
    count2=1;
    force=[0;0];
    moment=[0;0;0];
    r_head=[0.1;0;0];
    for x=xmin:dx:xmax
        % Position, velocity tangent vector computation
        data(count2,1)=x;
        [r,u,m,t]=return_r_u_t(x,time);
        data(count2,2)=r;
        data(count2,3)=u;
        data(count2,4)=data(count2,1)+t(1);
        data(count2,5)=data(count2,2)+t(2);
        
        % Fluid force, moment computation
        force=force-c*u-log(2)*dot([x;u],t)*t-2*log(2)*u;
        force=force-3*dot([x;u],t)*t-2*u;
        force=force*dx/sqrt(1+m^2);
        integrand=-c*u-log(2)*dot([x;u],t)*t-2*log(2)*u;
        integrand=integrand-3*dot([x;u],t)*t-2*u;
        moment=moment+cross(r_head,[integrand;0])*dx;
        count2=count2+1;
    end
    force=-force;
    moment=-moment;
    if min(moment)<min_moment
        min_moment=min(moment);
    end
    if min(force)<min_force
        min_force=min(force);
    end
    if max(moment)>max_moment
        max_moment=max(moment);
    end
    if max(force)>max_force
        max_force=max(force);
    end
    time_profile(:,count1)=time;
    force_profile(:,count1)=force;
    moment_profile(:,count1)=moment;
    %% Plot the swimmer position and velocities
    index=30;
    subplot('position',[0.05 0.15 0.4 0.8])
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

    subplot('position',[0.6 0.6 0.33 0.33]);
    plot(time_profile(:),force_profile(1,:),time_profile(:),force_profile(2,:));
    axis([0 Tmax min_force max_force]);
    hold on;
    xlabel('Time (Sec)');
    ylabel('Force (N)');
%     if flag==0
%         legend('X direction','Y direction')
%         xlabel('Time (Sec)');
%         ylabel('Force (N)');
%         title('Forces vs time')
%         grid on;
%     end
    grid on;
    subplot('position',[0.6 0.1 0.33 0.33]);
    plot(time_profile(:),moment_profile(3,:));
    axis([0 Tmax min_moment max_moment]);
%     if flag==0
%         xlabel('Time (Sec)');
%         ylabel('Moment (Nm)');
%         title('Moment vs time')
%         grid on;
%         flag=1;
%     end
    xlabel('Time (Sec)');
    ylabel('Moment (Nm)');
    hold on;
    grid on;
    count1=count1+1;
    pause(0.001);
end
