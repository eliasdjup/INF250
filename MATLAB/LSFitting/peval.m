%
%
% function peval:  evaluate the fitted polynomial 
%                  with coefficients c
% input:  coefficients c, x-values x
% output: est: estimated values at x
%
function est = peval(c, x)  
%
l = length(x); 
n = length(c)-1; 
%
A = ones(l,n+1); % inialize A with 1s in all places
%
for j=0:n-1
  A(:,n-j) = A(:,n-j+1) .* x; % fill in the powers of x
end
%
est = A * c; % multiply to evaluate 
%
%
