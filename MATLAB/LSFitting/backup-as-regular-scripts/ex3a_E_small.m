%% Example E from Lecture L3a:  subset-example
% Let's load the data first: 

clear all; close all; clc
Tin = readtable("2021-02-07--AnnualSeptNorthernSeaIceExtent.txt","ReadVariableNames",true);
% data from https://www.ncdc.noaa.gov/snow-and-ice/extent/sea-ice/N/9 
Year = Tin.Year(3:8); 
SExt = Tin.Mkm2(3:8); 
yb = [min(Year) max(Year)] % write out for which years we've read data 
eb = [min(SExt) max(SExt)]
%%
ab = [yb(1)-1 yb(2)+1 eb(1)-(eb(2)-eb(1))*0.5 eb(2)+(eb(2)-eb(1))*0.5]; 
%%
n = length(Year)
%
figure; 
plot (Year, SExt, 'k'), hold on, grid on, plot (Year, SExt, 'bo'); axis(ab)
%% 
% Naive approach to higher-order fitting:

c3 = polyfit(Year, SExt, 3)
c4 = polyfit(Year, SExt, 4) 
c5 = polyfit(Year, SExt, 5) 
%
YearFine = min(Year):0.1:max(Year); 
YearFine = YearFine(:); 
%
r3 = polyval(c3, YearFine);
r4 = polyval(c4, YearFine);
r5 = polyval(c5, YearFine);
%% 
% Let's look at this: 

figure
plot (Year, SExt, 'ko'), hold on, grid on, 
plot (YearFine, r3, "Color", [0.78125,0.40234,0.34375]), 
plot (YearFine, r4, "Color", [0.57813,0.47266,0.65234]), 
plot (YearFine, r5, "Color", [0.050781,0.57031,0.55469]), axis(ab);
legend({'data', 'cubic', 'quartic', 'qunitic'}, "Location", "bestoutside")
%% 
% With centering and scaling: 

YearSpread = max(Year) - min(Year); 
YearCenter = min(Year) + YearSpread/2; 
%
NormYear = (Year - YearCenter) * 2.0 / YearSpread; 
%% 
% Fitting, again: 

c1 = polyfit(NormYear, SExt, 1)
c2 = polyfit(NormYear, SExt, 2)
c3 = polyfit(NormYear, SExt, 3)
c4 = polyfit(NormYear, SExt, 4)
c5 = polyfit(NormYear, SExt, 5)
%
YearFine = (min(Year)-0.5:0.05:max(Year)+0.5).';
%
NormYearFine = (YearFine - YearCenter) * 2.0 / YearSpread;
%
r1 = polyval(c1, NormYearFine);
r2 = polyval(c2, NormYearFine);
r3 = polyval(c3, NormYearFine);
r4 = polyval(c4, NormYearFine);
r5 = polyval(c5, NormYearFine);
%% 
% Visualizing, again: 

figure; 
subplot(2,3,1), plot (Year, SExt, 'bo'), hold on, grid on, axis(ab), 
                plot (Year, SExt, 'k'), title("data")
subplot(2,3,2), plot (Year, SExt, 'bo'), hold on, grid on, axis(ab),  
                plot (YearFine, r1, 'k'), title("linear")
subplot(2,3,3), plot (Year, SExt, 'bo'), hold on, grid on, axis(ab),  
                plot (YearFine, r2, 'k'), title("quadratic")
subplot(2,3,4), plot (Year, SExt, 'bo'), hold on, grid on, axis(ab),  
                plot (YearFine, r3, 'k'), title("cubic")
subplot(2,3,5), plot (Year, SExt, 'bo'), hold on, grid on, axis(ab),  
                plot (YearFine, r4, 'k'), title("quartic")
subplot(2,3,6), plot (Year, SExt, 'bo'), hold on, grid on, axis(ab),  
                plot (YearFine, r5, 'k'), title("quintic")
%% 
% EOF.