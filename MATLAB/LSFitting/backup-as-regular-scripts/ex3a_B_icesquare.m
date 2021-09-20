%% Example B from Lecture L3a:  should we go quadratic?
% Let's load the data first: 

clear all; close all; clc
Tin = readtable("2021-02-07--AnnualSeptNorthernSeaIceExtent.txt","ReadVariableNames",true);
% data from https://www.ncdc.noaa.gov/snow-and-ice/extent/sea-ice/N/9 
Year = Tin.Year; 
SExt = Tin.Mkm2; 
yb = [min(Year) max(Year)] % write out for which years we've read data 
eb = [min(SExt) max(SExt)]
fa = [1975 2025 0 10]; 
%% 
% Sure enough, we'd like to look at the data -- it's always good to visualize! 
% :-)

figure; 
plot (Year, SExt, 'k:', 'LineWidth', 2), hold on, grid on, 
plot (Year, SExt, 'ko', 'MarkerFaceColor', 'k', "MarkerSize", 5); axis(fa)
%% 
% Looks familiar (after example A), of course...  
%% 
% But now we fit a quadratic model:

n = length(SExt) % number of data lines 
%
B = [sum(power(Year,4)), sum(power(Year,3)), sum(power(Year,2)); ...
     sum(power(Year,3)), sum(power(Year,2)), sum(Year); ...
     sum(power(Year,2)), sum(Year),          n        ] % matrix for quadratic regression
%
z = [sum(SExt.*power(Year,2)); ...
     sum(SExt.*Year); ...
     sum(SExt)]       % right side z for quadratic regression: 
%
% Solve for the coefficients of the quadratic fit: 
% (notice the warning!)
%
cQuad = B \ z 
%% 
% To visualize, we evaluate the quadratic model:

% Evaluate the quadratic fit for all years: 
yQuad = cQuad(1)*power(Year,2) + cQuad(2)*Year + cQuad(3);
%% 
% Now let's look at it:

figure
p1 = plot (Year, SExt, 'k:', "LineWidth", 1.5); hold on, grid on, 
p2 = plot (Year, SExt, 'ko', "MarkerFaceColor", "k", "MarkerSize", 4); 
p3 = plot (Year, yQuad, "Color", [0.57813,0.47266,0.65234], "LineWidth", 2);  axis(fa); 
legend([p1 p3], {'data', 'quadratic model'}, "Location", "southwest")
%% 
% What does this (possibly) tell us?  Should we be worried, maybe?  
%% 
% Let's compute some errors, again:

dQuad = yQuad - SExt;  % hosts all differences between the model and the data
dQuadAbs = abs(dQuad); % absolute errors
dQuad2 = dQuad.*dQuad; % squared errors
[max(dQuadAbs) mean(dQuadAbs) sqrt(mean(dQuad2))] % maximum absolute error, average absolut error, RMS error 
%% 
% Let's also look at these errors:

figure;
p0 = plot([1975 2025], [0 0], 'k', 'LineWidth', 2); hold on, grid on
p1 = plot(Year, dQuad,    '+', "Color", [0.78125,0.40234,0.34375], "LineWidth", 2);
p2 = plot(Year, dQuadAbs, 'x', "Color", [0.57813,0.47266,0.65234], "LineWidth", 2);
p3 = plot(Year, dQuad2,   '*', "Color", [0.050781,0.57031,0.55469], "LineWidth", 2);
legend([p1, p2, p3],{'quad.-model - data','| quad.-model - data |','( quad.-model - data )^2'},"Location","southeast")
axis([1975 2025 -2 2])
%% 
% Also sorted:

figure;
p0 = plot([1 n], [0 0], 'k', 'LineWidth', 2); hold on, grid on
% p1 = plot(1:n, sort(dLinAbs, 'descend'),  '+', "Color", [0.78125,0.40234,0.34375], "LineWidth", 2); 
p2 = plot(1:n, sort(dQuadAbs, 'descend'), 'x', "Color", [0.57813,0.47266,0.65234], "LineWidth", 2);
% legend([p1, p2],{'lin.-model - data','quad.-model - data'},"Location","northeast")
legend([p2],{'quad.-model - data'},"Location","northeast")
axis([1 n 0 2])
%% 
% Let's see, again, what MatLab gives us:

cIntQuad = polyfit(Year, SExt, 2)   % get the coefficients of a quadratic fit
% read the warning that comes along with polyfit -- we'll deal with it soon
yIntQuad = polyval(cIntQuad, Year); % evaulate this model for comparison
%
norm(yIntQuad-yQuad)
%% 
% Last, but not least, we visualize:

figure; 
p1 = plot (Year, SExt, 'k:', "LineWidth", 1.5); hold on, grid on, 
p2 = plot (Year, SExt, 'ko', "MarkerFaceColor", "k", "MarkerSize", 4); 
p3 = plot (Year, yQuad, 'b', "LineWidth", 3); 
p4 = plot (Year, yIntQuad, 'r', "LineWidth", 1.5); axis(fa); 
legend([p1 p3 p4], {'data', 'our own quadratic model', "MatLab's quadratic model"}, "Location", "southwest")
%% 
% Both models (our own, constructed "manually", and the one from polyfit) agree 
% well, as it seems.
%% 
% EOF.