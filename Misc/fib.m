function f = fib(n)

f = zeros(1,n);
f(2)=1;

for i = 3: n
    f(i)=f(i-1)+f(i-2);
   
end
end






