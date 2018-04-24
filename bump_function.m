clc;
clear;

a=-1;
b=1;
c=2;
d=10;
e=1000;
count=1;

for x=-5:0.01:5
    if x<b+c && x>a+c
        y=e*exp(-d/(1*(1-(x-c)^2)));
    else
        y=0;
    end
    data(count,1)=x;
    data(count,2)=y;
    count=count+1;
end

plot(data(:,1),data(:,2),'-ob');