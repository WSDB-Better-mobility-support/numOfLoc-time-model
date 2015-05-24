close;
clear;
clc;
ftsz = 16;
%import the data
data =  importdata('data.txt');

% extract time and energy columns 
loc = data(:,5); %converting milseconds to seconds
time = data(:,2)/1000;

% remove outliers
outliers =  abs( median( loc ) - loc ) > 3 * std(loc) ;
loc(outliers, :) = [] ; 
time(outliers, :) = [] ; 


p = polyfit(loc,time,1)
a= p(1)
b=p(2)

% computing the mean square error to validate the results of regression 
simulated_energy=a*loc+b;
err=sqrt(mean((time-simulated_energy).^2))

% plot
%figure('Position',[440 378 560 620/3]);
plot(loc,time,'r*')
hold on;
plot(loc,simulated_energy,'Linewidth',2)
set(gca , 'FontSize', ftsz);
set(gca , 'xTick', 0:5:max(loc)+1);
set(gca , 'yTick', 0:3:max(time)+1);
xlabel('time (sec)');
ylabel('Energy (Joule)')

