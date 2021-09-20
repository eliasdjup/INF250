%% Example D from Lecture L3a:  higher-order fit?
% Let's load some data first: 

clear all; close all; clc
Tin = readtable("2021-02-07--AnnualSeptNorthernSeaIceExtent.txt","ReadVariableNames",true);
% data from https://www.ncdc.noaa.gov/snow-and-ice/extent/sea-ice/N/9 
Year = Tin.Year; 
SExt = Tin.Mkm2; 
yb = [min(Year) max(Year)] % write out for which years we've read data 
eb = [min(SExt) max(SExt)]
fa = [1975 2025 0 10]; 
%% 
% Use our own function lsfit (see there for details) to get the coefficients 
% of a linear fit: 

cLin = lsfit(Year, SExt, 1) % get the coefficients of a linear fit
%
yLin = peval(cLin, Year); % check the linear fit on all years
%
figure; 
p1 = plot (Year, SExt, 'k:', "LineWidth", 1.5); hold on, grid on, 
p2 = plot (Year, SExt, 'ko', "MarkerFaceColor", "k", "MarkerSize", 4); 
p3 = plot (Year, yLin, "Color", [0.78125,0.40234,0.34375], "LineWidth", 2);  axis(fa); 
legend([p1 p3], {'data', 'linear model'}, "Location", "southwest")
%% 
% Now let's look at some higher-order models: 

c1st = lsfit(Year, SExt, 1) % coeffs. of a linear model
c2nd = lsfit(Year, SExt, 2) % coeffs. of a quadratic model
c3rd = lsfit(Year, SExt, 3) % coeffs. of a cubic model 
%
y1st = peval(c1st, Year); % evaluate the linear model on all years
y2nd = peval(c2nd, Year); % evaluate the quadratic model on all years
y3rd = peval(c3rd, Year); % evaluate the cubic model on all years
%% 
% Let's look at these models:  

figure
p1 = plot (Year, SExt, 'k:', "LineWidth", 1.5); hold on, grid on, 
p2 = plot (Year, SExt, 'ko', "MarkerFaceColor", "k", "MarkerSize", 4); 
p3 = plot (Year, y1st, "Color", [0.78125,0.40234,0.34375], "LineWidth", 2); 
p4 = plot (Year, y2nd, "Color", [0.57813,0.47266,0.65234], "LineWidth", 2); 
p5 = plot (Year, y3rd, "Color", [0.050781,0.57031,0.55469], "LineWidth", 2); axis(fa); 
legend([p1 p3 p4 p5], {'data', 'linear model', 'quadratic model', 'cubic model'}, "Location", "southwest")
%% 
% Checking MatLab's cubic fit: 

cIntCub = polyfit(Year, SExt, 3)  % MatLab's coeffs. of a cubic fit
yIntCub = polyval(cIntCub, Year); % and the according evaluation 
%% 
% Let's compare them visually: 

figure; 
p1 = plot (Year, SExt, 'k:', "LineWidth", 1.5); hold on, grid on, 
p2 = plot (Year, SExt, 'ko', "MarkerFaceColor", "k", "MarkerSize", 4); 
p3 = plot (Year, y3rd, 'b', "LineWidth", 3); 
p4 = plot (Year, yIntCub, 'r', "LineWidth", 1.5); axis(fa); 
legend([p1 p3 p4], {'data', 'our own cubic model', "MatLab's cubic model"}, "Location", "southwest")
%% 
% Looking into numeric differences: 

norm(y3rd-yIntCub)
%% 
% Note that we start to see some (numeric) problems with this approach -- what 
% to do?
%% 
% To show the problem that we're facing, we make an attempt at an even higher-order 
% model: 

c5 = lsfit(Year, SExt, 5) % coeffa. of fifth-order model
y5 = peval(c5, Year);     % and the according evaluation 
%
cInt5 = polyfit(Year, SExt, 5) % the same with MatLab
yInt5 = polyval(cInt5, Year);  % also evaluating...
%% 
% Visualizing, again: 

figure; 
p1 = plot (Year, SExt, 'k:', "LineWidth", 1.5); hold on, grid on, 
p2 = plot (Year, SExt, 'ko', "MarkerFaceColor", "k", "MarkerSize", 4); 
p3 = plot (Year, y5, 'b', "LineWidth", 3); 
p4 = plot (Year, yInt5, 'r', "LineWidth", 1.5); axis(fa); 
legend([p1 p3 p4], {'data', 'our own quintic model', "MatLab's quintic model"}, "Location", "southwest")
%% 
% Now it's fully obvious that we have run into a numerical problem!  
%% 
% The numeric difference should be high, now, as well: 

norm(y5-yInt5)
%% 
% When working with higher-order models (you can very well ask: is this a good 
% idea anyway?), it's important to rescale the domain -- with all these powers 
% of "x" on the left-hand side of the normal equations, you better bound these 
% _x_-values!

yMin = min(Year); 
yShift = Year - yMin; % shifted domain (to start at 0)
yShMax = max(yShift); 
yScaled = yShift ./ yShMax; % (shifted and) scaled domain (for span [0,1])
%
xScFine = (0:1/((max(Year)-min(Year))*12):1).'; % once-per month grating of the normalized domain
%
cScInt5 = polyfit(yScaled, SExt, 5) % get the coefficients
yScInt5 = polyval(cScInt5, xScFine); % and evaluate 
%% 
% Try also our own lsfit -- do we still get this warning?

cSc5 = lsfit(yScaled, SExt, 5) 
ySc5 = peval(cSc5, xScFine); % let's also evaluate
%% 
% So let's visualize, again: 

%
xScFineBack = xScFine .* yShMax + yMin; % let's undo the normalization for the visualization 
%
figure
p1 = plot (Year, SExt, 'k:', "LineWidth", 1.5); hold on, grid on, 
p2 = plot (Year, SExt, 'ko', "MarkerFaceColor", "k", "MarkerSize", 4); 
p3 = plot (Year, y5, "Color", [0.78125,0.40234,0.34375], "LineWidth", 3); 
p4 = plot (xScFineBack, yScInt5, "Color", [0.57813,0.47266,0.65234], "LineWidth", 3); 
p5 = plot (xScFineBack, ySc5, "--", "Color", "k", "LineWidth", 1.5); axis(fa); 
legend([p1 p3 p4 p5], {'data', 'model wo/normalization', "MatLab's model w/normalization", "our model w/normalization"}, "Location", "southwest")
%% 
% So after normalizing the domain, we're as good as MatLab! :-) 
%% 
% What about even higher orders?

cScInt8 = polyfit(yScaled, SExt, 8)  % an attempt at an eight-order model!
yScInt8 = polyval(cScInt8, xScFine); % with evaluation 
%
cInt8 = lsfit(Year, SExt, 8) % model fitting on the original domain!
yInt8 = peval(cInt8, Year); 
%
cSc8 = lsfit(yScaled, SExt, 8) % our own model fitting (on the normalized domain)
ySc8 = peval(cSc8, xScFine); 
%% 
% Let's visualize this: 

figure
p1 = plot (Year, SExt, 'k:', "LineWidth", 1.5); hold on, grid on, 
p2 = plot (Year, SExt, 'ko', "MarkerFaceColor", "k", "MarkerSize", 4); 
p3 = plot (Year, yInt8, "Color", [0.78125,0.40234,0.34375], "LineWidth", 3); 
p4 = plot (xScFineBack, yScInt8, "Color", [0.57813,0.47266,0.65234], "LineWidth", 3); 
p5 = plot (xScFineBack, ySc8, "--", "Color", "k", "LineWidth", 1.5); axis(fa); 
legend([p1 p3 p4 p5], {'data', 'model wo/normalization', "model w/normalization", "our model w/normalization"}, "Location", "southwest") 
%% 
% EOF.