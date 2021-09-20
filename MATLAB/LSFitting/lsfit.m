%
%
% function lsfit:
% input:  x-values x, y-values y, and order n 
% output: coeffs: coefficients of the fitted polynomial
%
function coeffs = lsfit(x, y, n)  
%
l = length(x); 
%
A = ones(l,n+1); % inialize A with 1s in all places 
%
for j=0:n-1
  A(:,n-j) = A(:,n-j+1) .* x; % fill in the powers of x
end
%
% setup the normal equations
B = A.' * A; 
z = A.' * y; 
%
coeffs = B \ z; % solve for the coefficients 
%
%
