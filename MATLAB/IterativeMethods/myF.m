%
%
% some function myF for root finding ...
% .... x: independent variable
% .... b: offset-parameter
%
function y = myF(x,b) 
%
y = 2*cos(x*pi/2) + sin(x*pi)/3 + 3*x - b; 
%
%
