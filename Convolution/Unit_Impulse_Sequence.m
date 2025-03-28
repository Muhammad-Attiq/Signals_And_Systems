x=[1 0 0 0]; 
n=0:3; 
stem(n,x,'fill','linewidth',2),grid on 
axis([-0.2 3.2 -0.1 1.1]) 
legend('x[n]=\delta[n]')
h=[2 4 3 1]; 
n=0:3; 
stem(n,h,'fill','linewidth',2),grid on 
axis([-0.2 3.2 -0.1 4.1]) 
legend('h[n]') 
y=conv(x,h); 
stem(0:6,y,'fill','linewidth',2),grid on 
axis([-0.2 6.2 -0.1 4.1]) 
legend('y[n]=h[n]')
