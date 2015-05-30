clear;
close all;
clc;
%labels
%l = {1,2,4,8,16,64,128};
% l={1,3,5,7,9,11,13,15,17,19,21,23,25,61,27,29,31,33,35,37,39,41,43,45,47,49,50};
 l = {1,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75};
%%
%energy calculations
% 20 per location
m = load('data.txt');
e = m(:,4); % Extract only the energy column
t = m(:,2); % Extract only the time column
t = t/1000; % convert from milliseconds to seconds
% Each location was queried 20 times
col_len = input('Please enter the number of query per one experiment : ');
num_of_exper = length(e) / col_len;
e_data_vecs = reshape(e  , [col_len , num_of_exper]);
t_data_vecs = reshape(t  , [col_len , num_of_exper]);
e_max_data = max(e);
t_max_data = max(t);
% limit number of labels
l = l(1:num_of_exper);

%%
%plotting


figure('Position',[440 378 560 620/3]);
t_mean= mean( t_data_vecs );
xVal = cell2mat(l);
t_coefs = polyfit( xVal,t_mean , 1);
curve = polyval(t_coefs ,xVal);
t_p = plot(xVal , t_data_vecs , 'r.' , xVal , curve);
box on
xlabel('Number of queries per one request');
ylabel('Time (sec)');
set(gca , 'YTick' , [0:2: t_max_data]);

set(gca,'FontSize',16)
set(t_p,'LineWidth',3);
