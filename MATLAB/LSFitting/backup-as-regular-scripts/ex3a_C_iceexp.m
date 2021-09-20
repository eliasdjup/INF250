%% Example C from Lecture L3a:  or maybe exponential?
% Let's load the data again: 

clear all; close all; clc
Tin = readtable("2021-02-07--AnnualSeptNorthernSeaIceExtent.txt","ReadVariableNames",true);
% data from https://www.ncdc.noaa.gov/snow-and-ice/extent/sea-ice/N/9 
Year = Tin.Year; 
SExt = Tin.Mkm2; 
yb = [min(Year) max(Year)] % write out for which years we've read data 
eb = [min(SExt) max(SExt)]
fa = [1975 2025 0 10]; 
%% 
% And we look at it, again:

figure; 
plot (Year, SExt, 'k:', 'LineWidth', 2), hold on, grid on, 
plot (Year, SExt, 'ko', 'MarkerFaceColor', 'k', "MarkerSize", 5); axis(fa)
%% 
% This time, we fit an exponential model -- you know how?

n = length(SExt) % number of data lines
%
LnExt = log(SExt); % "trick": transform the data to its logarithm, first! 
%
cLinLn = polyfit(Year, LnExt, 1) % this time, we go for MatLab's solution immediately
yLinLn = polyval(cLinLn, Year);  % and evaluate for comparison purposes 
%
yExLinLn = exp(yLinLn); % undoing our "trick"
%% 
% Now we're ready to visualize: 

figure
p1 = plot (Year, SExt, 'k:', "LineWidth", 1.5); hold on, grid on, 
p2 = plot (Year, SExt, 'ko', "MarkerFaceColor", "k", "MarkerSize", 4); 
p3 = plot (Year, yExLinLn, "Color", [0.050781,0.57031,0.55469], "LineWidth", 2);  axis(fa); 
legend([p1 p3], {'data', 'exponential model'}, "Location", "southwest")
%% 
% Yet another picture, yet another chance for an interpretation.  What kind 
% of prediction could b done based on this model?
%% 
% To compare these models, let's recompute them: 

cLin = polyfit(Year, SExt, 1) % coefficients of the linear fit
yLin = polyval(cLin, Year);   % and evaluating it, also
%
cQuad = polyfit(Year, SExt, 2) % coefficients of the quadratic fit
yQuad = polyval(cQuad, Year);  % and it's evaluation
%% 
% Let's visualize them altogether:

figure
p1 = plot (Year, SExt, 'k:', "LineWidth", 1.5); hold on, grid on, 
p2 = plot (Year, SExt, 'ko', "MarkerFaceColor", "k", "MarkerSize", 4); 
p3 = plot (Year, yLin, "Color", [0.78125,0.40234,0.34375], "LineWidth", 2); 
p4 = plot (Year, yQuad, "Color", [0.57813,0.47266,0.65234], "LineWidth", 2); 
p5 = plot (Year, yExLinLn, "Color", [0.050781,0.57031,0.55469], "LineWidth", 2); axis(fa); 
legend([p1 p3 p4 p5], {'data', 'linear model', 'quadratic model', 'exponential model'}, "Location", "southwest")
%% 
% What do these three models have in common?  In which way do they differ from 
% each other?
%% 
% Let's compute the errors, again:

dLin = yLin - SExt;  % dLin hosts all differences between the model and the data
dLinAbs = abs(dLin); % dLinAbs: absolute errors
dLin2 = dLin.*dLin;  % dLin2: squared errors
dQuad = yQuad - SExt;  % hosts all differences between the model and the data
dQuadAbs = abs(dQuad); % absolute errors
dQuad2 = dQuad.*dQuad; % squared errors
dExp = yExLinLn - SExt; % hosts all differences between the model and the data
dExpAbs = abs(dExp);    % absolute errors
dExp2 = dExp.*dExp;     % squared errors
[max(dLinAbs) mean(dLinAbs) sqrt(mean(dLin2)); ...
 max(dQuadAbs) mean(dQuadAbs) sqrt(mean(dQuad2)); ...
 max(dExpAbs) mean(dExpAbs) sqrt(mean(dExp2))] % maximum absolute error, average absolut error, RMS error 
%% 
% Which model fits best?  
%% 
% Let's look at the (sorted) errors:

figure;
p0 = plot([1 n], [0 0], 'k', 'LineWidth', 2); hold on, grid on
p3 = plot(1:n, sort(dExpAbs, 'descend'),  '*', "Color", [0.050781,0.57031,0.55469], "LineWidth", 2);
p1 = plot(1:n, sort(dLinAbs, 'descend'),  '+', "Color", [0.78125,0.40234,0.34375], "LineWidth", 2); 
p2 = plot(1:n, sort(dQuadAbs, 'descend'), 'x', "Color", [0.57813,0.47266,0.65234], "LineWidth", 2);
legend([p1, p2, p3],{'lin.-model - data','quad.-model - data','exp.-model - data'},"Location","northeast")
axis([1 n 0 2])
%% 
% EOF.