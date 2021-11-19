% 08/23/2021
% Athul P. Girija
% This script performs a 1-D sweep on a single variable in a script file.

clc
clear all;

inputFile = 'inputFile - gamma - baseline - report.txt'; % input file to use
param_ID = 26; % line nuber of the parameter being swept in the input data file.

param_low   = 700;  % parameter low value 
param_high  = 1300; % parameter high value
param_num   = 10; % number of points in 1-D sweep

output_file = 'output-1D-sweep-gamma-baseline-report-x11';

param_arr   = linspace(param_low, param_high, param_num);

powero_arr = zeros(1, param_num);
heatin_arr = zeros(1, param_num);
effact_arr = zeros(1, param_num);


for i = 1:param_num
    makeFile1D(inputFile, param_ID, param_arr(i));
    define(inputFile);
    [var,dvar, actWpower,actQhpower,acteff] = simple;
    
    powero_arr(i) = actWpower;
    heatin_arr(i) = actQhpower;
    effact_arr(i) = acteff;
end

param_arr  = round(param_arr, 8);
powero_arr = round(powero_arr, 4, 'significant');
heatin_arr = round(heatin_arr, 4, 'significant');
effact_arr = round(effact_arr, 4, 'significant');

T = table([param_arr', powero_arr', heatin_arr', effact_arr']);

writetable(T,output_file , 'Delimiter','\t')
   
dlmwrite(strcat('data/', output_file,'-param.dat'),param_arr','delimiter','\t');
dlmwrite(strcat('data/', output_file,'-pow.dat'),powero_arr','delimiter','\t');
dlmwrite(strcat('data/', output_file,'-qin.dat'),heatin_arr','delimiter','\t');
dlmwrite(strcat('data/', output_file,'-eff.dat'),effact_arr','delimiter','\t');

