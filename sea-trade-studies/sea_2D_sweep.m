% 08/23/2021
% Athul P. Girija
% This script performs a 2-D sweep on a two variables in an input file file.

clc
clear all;

inputFile = 'inputFile - gamma - baseline - report.txt'; % input file to use
 % input file to use

param1_ID = 3; % line nuber of the first parameter being swept.
param2_ID = 5;% line number of the second file being swept.

param1_low   = 50e-6;  % parameter1 low value 
param1_high  = 300e-6; % parameter1 high value
param1_num   = 7;    % parameter1 number of points to sweep

param2_low   = 50e-6;  % parameter2 low value 
param2_high  = 300e-6;  % parameter2 high value
param2_num   = 7;     % parameter2 number of points to sweep

outputFile = 'output-2D-sweep-gamma-baseline-report-x20';

param1_arr   = linspace(param1_low, param1_high, param1_num);
param2_arr   = linspace(param2_low, param2_high, param2_num);

powero_arr = zeros(param1_num, param2_num);
heatin_arr = zeros(param1_num, param2_num);
effact_arr = zeros(param1_num, param2_num);

for i = 1:param1_num
    for j = 1:param2_num
        makeFile2D(inputFile, param1_ID, param2_ID, param1_arr(i), param2_arr(j));
        define(inputFile);
        [var,dvar, actWpower,actQhpower,acteff] = simple;
        
        powero_arr(i,j) = actWpower;
        heatin_arr(i,j) = actQhpower;
        effact_arr(i,j) = acteff;
    end
end

param1_arr  = round(param1_arr, 8);
param2_arr  = round(param2_arr, 8);
powero_arr = round(powero_arr, 4, 'significant');
heatin_arr = round(heatin_arr, 4, 'significant');
effact_arr = round(effact_arr, 4, 'significant');


dlmwrite(strcat('data/',outputFile,'-param1.dat'),param1_arr','delimiter','\t');
dlmwrite(strcat('data/',outputFile,'-param2.dat'),param2_arr','delimiter','\t');

dlmwrite(strcat('data/',outputFile,'-pow.dat'),powero_arr,'delimiter','\t');
dlmwrite(strcat('data/',outputFile,'-qin.dat'),heatin_arr,'delimiter','\t');
dlmwrite(strcat('data/',outputFile,'-eff.dat'),effact_arr,'delimiter','\t');
        


