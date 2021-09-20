%% Example F from Lecture L3a:  how stable are these fits?
% Let's load the data first: 

clear all; close all; clc
Tin = readtable("2021-02-07--AnnualSeptNorthernSeaIceExtent.txt","ReadVariableNames",true);
% data from https://www.ncdc.noaa.gov/snow-and-ice/extent/sea-ice/N/9 
Year = Tin.Year; 
SExt = Tin.Mkm2; 
yb = [min(Year) max(Year)] % write out for which years we've read data 
eb = [min(SExt) max(SExt)] % min.- and max.-data
fa = [1960 2040 0 10]; % axis-bounds for the figures
%% 
% Before fitting, let's normalize the domain:

YN = (Year - Year(20))/40; % this should serve us sufficiently well
%% 
% Let's fit our models to slightly modified versions of the data:
%% 
% * for each version, we leave out one of the original data values
% * then we add 5% of random noise on top of the data

n = length(Year) % number of data entries
%% 
% We organize the different versions in columns, side by side:

SExtMod = zeros(n-1,n); % initialization: n-1 rows (one dropped), n versions
YearVer = zeros(n-1,n); % for the sake of simplicity, just set up the years in parallel
for i = 1:n
    ids = 1:n; ids(i)=[];          % ids are all indices, except for i
    YearVer(:,i) = YN(ids);        % copy over the (normalized) years
    SExtMod(:,i) = SExt(ids) + ... % copy over the original data (one entry dropped) ... 
        rand(n-1,1)*fa(4)/20;      % ... and add 2% of noise
end
%% 
% To look at these versions, just to get an idea of what we just did, let's 
% first load some colors:

C39 = readtable("map-39.csv"); 
ct = repmat(table2array(C39),3,1); % we repeat the table of colors sufficiently often to have enough colors
%% 
% Now, let's just plot these variants to get an idea about the amount of variation:

figure;
plot(YearVer(:,1)*40+Year(20), SExtMod(:,1), '+', 'Color', ct(1,:)), hold on, grid on, axis(fa)
for i = 2:n
    plot(YearVer(:,i)*40+Year(20), SExtMod(:,i), '+', 'Color', ct(i,:))
end
%% 
% Next, let's fit a LS-line to all of these variants:

cLinVer = zeros(2,n); % we get two coefficients per fit, for n variants
for i = 1:n
    cLinVer(:,i) = polyfit(YearVer(:,i), SExtMod(:,i), 1); % fit for all
end
%% 
% Next, let's look at these lines:

figure;
plot(Year, SExt, 'ok'), hold on, grid on, axis(fa); % plot the data first
plot(Year, SExt, ':k')
yFine = fa(1):1/12:fa(2); % span from left to right, with one sample per month
for i = 1:n
    plot(yFine, polyval(cLinVer(:,i), (yFine-Year(20))/40), "Color", ct(i,:))
end
%% 
% Would you say that least-square fitting of a linear model is stable?  Would 
% you say that we could possibly use it for prediction?  
%% 
% What if we had tried to predict the last 10 years, based on all data up to 
% that year?

cLinVer = zeros(2,n-10); % we get two coefficients per fit, for n variants
for i = 1:n
    cLinVer(:,i) = polyfit(YearVer(1:end-10,i), SExtMod(1:end-10,i), 1); % fit for all
end
%% 
% Let's have a look:

figure;
plot(Year, SExt, 'ok'), hold on, grid on, axis(fa); % plot the data first
plot(Year, SExt, ':k')
yFine = fa(1):1/12:fa(2); % span from left to right, with one sample per month
for i = 1:n
    plot(yFine, polyval(cLinVer(:,i), (yFine-Year(20))/40), "Color", ct(i,:))
end
%% 
% Should you have trusted this (hypothetical) prediction?
%% 
% Next, let's have a look at quadratic models:

cQuadVer = zeros(3,n); % we get three coefficients per fit, for n variants
for i = 1:n
    cQuadVer(:,i) = polyfit(YearVer(:,i), SExtMod(:,i), 2); % fit for all
end
%% 
% Of course, we wish to look at these fits!

figure;
plot(Year, SExt, 'ok'), hold on, grid on, axis(fa); % plot the data first
plot(Year, SExt, ':k')
yFine = fa(1):1/12:fa(2); % span from left to right, with one sample per month
for i = 1:n
    plot(yFine, polyval(cQuadVer(:,i), (yFine-Year(20))/40), "Color", ct(i,:))
end
%% 
% How do these quadratic fits compare to the linear fits?
%% 
% So let's try this hypothetical prediction, once again:

cQuadVer = zeros(3,n-10); % we get three coefficients per fit, for n variants
for i = 1:n
    cQuadVer(:,i) = polyfit(YearVer(1:end-10,i), SExtMod(1:end-10,i), 2); % fit for all
end
%% 
% Visualiation helps to see what we've got:

figure;
plot(Year, SExt, 'ok'), hold on, grid on, axis(fa); % plot the data first
plot(Year, SExt, ':k')
yFine = fa(1):1/12:fa(2); % span from left to right, with one sample per month
for i = 1:n
    plot(yFine, polyval(cQuadVer(:,i), (yFine-Year(20))/40), "Color", ct(i,:))
end
%% 
% How good would a prediction, based on a quadratic model, have been?
%% 
% No surprise, we crank up the order once again, now to cubic fits:

cCubVer = zeros(4,n); % we get four coefficients per fit, for n variants
for i = 1:n
    cCubVer(:,i) = polyfit(YearVer(:,i), SExtMod(:,i), 3); % fit for all
end
%% 
% And visualization!

figure;
plot(Year, SExt, 'ok'), hold on, grid on, axis(fa); % plot the data first
plot(Year, SExt, ':k')
yFine = fa(1):1/12:fa(2); % span from left to right, with one sample per month
for i = 1:n
    plot(yFine, polyval(cCubVer(:,i), (yFine-Year(20))/40), "Color", ct(i,:))
end
%% 
% If it was not clearly visible for the quadratic fits, yes, it certainly becomes 
% visible now: outside of the data domain, our fitted cubic models are no longer 
% reliable.
%% 
% Also here, we try this hypothetical prediction:

cCubVer = zeros(4,n-10); % we get four coefficients per fit, for n variants
for i = 1:n
    cCubVer(:,i) = polyfit(YearVer(1:end-10,i), SExtMod(1:end-10,i), 3); % fit for all
end
%% 
% Let's look:

figure;
plot(Year, SExt, 'ok'), hold on, grid on, axis(fa); % plot the data first
plot(Year, SExt, ':k')
yFine = fa(1):1/12:fa(2); % span from left to right, with one sample per month
for i = 1:n
    plot(yFine, polyval(cCubVer(:,i), (yFine-Year(20))/40), "Color", ct(i,:))
end
%% 
% But let's do one more step, i.e., quartic fits:

cQuartVer = zeros(5,n); % we get five coefficients per fit, for n variants
for i = 1:n
    cQuartVer(:,i) = polyfit(YearVer(:,i), SExtMod(:,i), 4); % fit for all
end
%% 
% And visualization, of course:

figure;
plot(Year, SExt, 'ok'), hold on, grid on, axis(fa); % plot the data first
plot(Year, SExt, ':k')
yFine = fa(1):1/12:fa(2); % span from left to right, with one sample per month
for i = 1:n
    plot(yFine, polyval(cQuartVer(:,i), (yFine-Year(20))/40), "Color", ct(i,:))
end
%% 
% Once again: which models (fits) are suitable for prediction?
%% 
% Last, but not least, we play our hypothetical prediction, also here:

cQuartVer = zeros(5,n-10); % we get five coefficients per fit, for n variants
for i = 1:n
    cQuartVer(:,i) = polyfit(YearVer(1:end-10,i), SExtMod(1:end-10,i), 4); % fit for all
end
%% 
% And visualization:

figure;
plot(Year, SExt, 'ok'), hold on, grid on, axis(fa); % plot the data first
plot(Year, SExt, ':k')
yFine = fa(1):1/12:fa(2); % span from left to right, with one sample per month
for i = 1:n
    plot(yFine, polyval(cQuartVer(:,i), (yFine-Year(20))/40), "Color", ct(i,:))
end
%% 
% EOF.