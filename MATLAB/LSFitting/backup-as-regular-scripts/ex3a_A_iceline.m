%% Example A from Lecture L3a:  what's happening to the Arctic sea ice?
% Let's load some data first: 

clear all; close all; clc
Tin = readtable("2021-02-07--AnnualSeptNorthernSeaIceExtent.txt","ReadVariableNames",true);
% data from https://www.ncdc.noaa.gov/snow-and-ice/extent/sea-ice/N/9 
Year = Tin.Year; 
SExt = Tin.Mkm2; 
yb = [min(Year) max(Year)] % write out for which years we've read data 
eb = [min(SExt) max(SExt)] % min.- and max.-data
fa = [1975 2025 0 10]; % axis-bounds for the figures
%% 
% Next, let's have a look at it:

figure; 
plot (Year, SExt, 'k:', 'LineWidth', 2), hold on, grid on, 
plot (Year, SExt, 'ko', 'MarkerFaceColor', 'k', "MarkerSize", 5); axis(fa)
%% 
% What do you see?  Any trend?  Any thoughts about what to expect in the next 
% years?
%% 
% In order to do a simple, i.e., linear trend analysis, we fit an according 
% model:

n = length(SExt) % number of data lines
%
B = [sum(power(Year,2)), sum(Year); ...
     sum(Year),          n        ] % matrix for linear regression
%
z = [sum(SExt.*Year); ...
     sum(SExt)]       % right side z for linear regression
%
cLin = B \ z % solving for the coefficients of the best-fit line
%% 
% Now let's see this trend line in comparison with the data:

yLin = cLin(1)*Year + cLin(2); % evaluate the line for all years
%
figure
p1 = plot (Year, SExt, 'k:', "LineWidth", 1.5); hold on, grid on, 
p2 = plot (Year, SExt, 'ko', "MarkerFaceColor", "k", "MarkerSize", 4); 
p3 = plot (Year, yLin, "Color", [0.78125,0.40234,0.34375], "LineWidth", 2);  axis(fa); 
legend([p1 p3], {'data', 'linear model'}, "Location", "southwest")
%% 
% Does the linear trend line reflect the nature of the data?  Is this (linear) 
% model good to summarize the situation?  What may be issues?  
%% 
% Let's also calculate some errors:

dLin = yLin - SExt;  % dLin hosts all differences between the model and the data
dLinAbs = abs(dLin); % dLinAbs: absolute errors
dLin2 = dLin.*dLin;  % dLin2: squared errors
[max(dLinAbs) mean(dLinAbs) sqrt(mean(dLin2))] % maximum absolute error, average absolut error, RMS error 
%% 
% Let's look at these errors:

figure;
p0 = plot([1975 2025], [0 0], 'k', 'LineWidth', 2); hold on, grid on
p1 = plot(Year, dLin,    '+', "Color", [0.78125,0.40234,0.34375], "LineWidth", 2);
p2 = plot(Year, dLinAbs, 'x', "Color", [0.57813,0.47266,0.65234], "LineWidth", 2);
p3 = plot(Year, dLin2,   '*', "Color", [0.050781,0.57031,0.55469], "LineWidth", 2);
legend([p1, p2, p3],{'lin.-model - data','| lin.-model - data |','( lin.-model - data )^2'},"Location","southeast")
axis([1975 2025 -2 2])
%% 
% And also sorted:

figure;
p0 = plot([1 n], [0 0], 'k', 'LineWidth', 2); hold on, grid on
p1 = plot(1:n, sort(dLinAbs, 'descend'), '+', "Color", [0.78125,0.40234,0.34375], "LineWidth", 2);
legend([p1],{'lin.-model - data'},"Location","northeast")
axis([1 n 0 2])
%% 
% Let's see, what MatLab gives us (in comparison): 

cIntLin = polyfit(Year, SExt, 1)  % get the coefficients for a linear model
yIntLin = polyval(cIntLin, Year); % evaluate the model for comparison
%
norm(yLin-yIntLin) % if both models agree, this difference should be neglegible 
%% 
% We can also check this with visualization: 

figure;
p1 = plot (Year, SExt, 'k:', "LineWidth", 1.5); hold on, grid on, 
p2 = plot (Year, SExt, 'ko', "MarkerFaceColor", "k", "MarkerSize", 4); 
p3 = plot (Year, yLin, 'b', "LineWidth", 3); 
p4 = plot (Year, yIntLin, 'r', "LineWidth", 1.5); axis(fa); 
legend([p1 p3 p4], {'data', 'our own linear model', "MatLab's linear model"}, "Location", "southwest")
%% 
% Both linear models agree (good to see, of course).
%% 
% EOF.