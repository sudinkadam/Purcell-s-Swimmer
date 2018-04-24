clc;
clear;
k=0.001;        %Slenderness ratio
lambda=1;       %Uniform cross sectional radius

lnk=log2(k);
lnLambda=log2(lambda);
count=1;
t=[1;0;0];
Init_Graphics_Style;

%% VAriation against the body velocity
for u=0:0.0001:0.01
    % Assuming all the velocity components to be u
    % Assuming the fluid velocity to be 0
    U=[u;u;u];
    term1=2*pi*dot((-U/lnk-U/lnk^2),t)*t;
    term2=2*pi*(-2*(-U/lnk-U/lnk^2));
    term3=-dot(U/lnk^2,3*t)*t;
    term4=-2*U/lnk^2;
    
    F=term1+term2+term3+term4;
    Fx=F(1);
    Fy=F(2);
    data(1:3,count)=u;
    data(4:6,count)=F;
    count=count+1;
end
% subplot(211)
plot(data(1,:),data(4,:),'.',data(1,:),data(5,:),'.');
xlabel('Swimmer velocity (m/s)');
ylabel('Force density (N)');
legend('X direction', 'Y direction');
% title('Variation in force density against the local body velocity');
grid on;

%% Variation against the slenderness ratio
u=0.001;
for k=0.0001:0.0001:0.01
    % Assuming all the velocity components to be u
    % Assuming the fluid velocity to be 0
    lnk=log2(k);
    U=[u;u;u];
    term1=2*pi*dot((-U/lnk-U/lnk^2),t)*t;
    term2=2*pi*(-2*(-U/lnk-U/lnk^2));
    term3=-dot(U/lnk^2,3*t)*t;
    term4=-2*U/lnk^2;
    
    F=term1+term2+term3+term4;
    Fx=F(1);
    Fy=F(2);
    data1(1,count)=k;
    data1(2:4,count)=F;
    count=count+1;
end
figure();
plot(data1(1,:),data1(2,:),'.',data1(1,:),data1(3,:),'.');
xlabel('Local slenderness ratio');
ylabel('Force density (N)');
legend('X direction', 'Y direction');
% title('Variation in force density against the local slenderness ratio');
grid on;