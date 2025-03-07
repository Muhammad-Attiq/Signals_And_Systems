n=1:10; 
a=1.5; 
x=a.^n; 
stem(n,x,'fill','linewidth',2),grid on 
xlabel('Instance n'); 
ylabel('x[n]'); 
title('Discrete Sequences'); 
