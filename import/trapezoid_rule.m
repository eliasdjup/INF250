function Apprx = trapezoid_rule(f,I,m)

% f is a function in one variable
% I is a 1x2 vector
% m is the number of points used to create m-1 trapezoids.
% For example
%
% trapezoid_rule('exp(-x^2)',[-2,3],7)
%
% approximate the area under the function exp(-x^2) from x =-2 to x=3 using
% 6 trapezoids (using 7 points)
% and plots the trapezoids that are used in the aproximation.

close all
format long


x=I(1):(I(2)-I(1))/(m-1):I(2);
for j=1:1:length(x)
    y=subs(f,x);
end

Apprx = trapz(x,y);
ezplot(f, [I(1), I(2)])
hold on
plot(x,y,'r')
for k=1:1:length(x)-1
    rx = [x(k) x(k) x(k+1) x(k+1)];
    ry = [y(k) 0 y(k+1) 0];
    k = convhull(rx, ry);
    fill (rx(k), ry(k), 'g','facealpha', 0.23); 
end
stem(x,y,'r')

