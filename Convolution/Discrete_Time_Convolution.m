kx=[0 1]; 
x=[1 2]; 
stem(kx,x,'fill','linewidth',2),grid on 
axis([-0.1 3.1 -0.1 2.1])
kh=0:3;
h=[2 1 1 1]; 
stem(kh,h,'fill','linewidth',2),grid on 
axis([-0.1 3.1 -0.1 2.1]) 
legend('h[k]')  
stem(-kh,h,'fill','linewidth',2) ,grid on 
axis([-3.1 0.1 -0.1 2.1]) 
legend('h[-k]') 

stem(kx,x,'fill','linewidth',2),grid on 
axis([-5.1 3.1 -0.1 2.1]) 
legend('x[k]') 
n=-2; 
stem(-kh+n,h,'fill','linewidth',2), grid on 
axis([-5.2 3.1 -0.1 2.1]) 
legend('h[-2-k]')

stem(kx,x,'fill','linewidth',2),grid on 
axis([-5.1 3.1 -0.1 2.1]) 
legend('x[k]') 
n = 0;
stem(-kh+n,h,'fill','linewidth',2),grid on 
axis([-5.2 3.1 -0.1 2.1]) 
legend('h[n-k]=h[0-k]') 
stem(kx,x,'fill','linewidth',2),grid on 
axis([-5.1 3.1 -0.1 2.1]) 
legend('x[k]')
n = 1;
stem(-kh+n,h,'fill','linewidth',2),grid on 
axis([-5.2 3.1 -0.1 2.1]) 
legend('h[n-k]=h[0-k]') 

stem(kx,x,'fill','linewidth',2),grid on 
axis([-5.1 3.1 -0.1 2.1]) 
legend('x[k]')
n = 2;
stem(-kh+n,h,'fill','linewidth',2),grid on 
axis([-5.2 3.1 -0.1 2.1]) 
legend('h[n-k]=h[2-k]')

stem(kx,x,'fill','linewidth',2),grid on 
axis([-5.1 3.1 -0.1 2.1]) 
legend('x[k]') 
n=3; 
stem(-kh+n,h,'fill','linewidth',2),grid on 
axis([-5.2 3.1 -0.1 2.1]) 
legend('h[n-k]=h[3-k]')

stem(kx,x,'fill','linewidth',2),grid on 
axis([-2.1 6.1 -0.1 2.1]) 
legend('x[k]')
n = 4;
stem(-kh+n,h,'fill','linewidth',2),grid on 
axis([-2.1 6.1 -0.1 2.1]) 
legend('h[n-k]=h[4-k]') 

stem(kx,x,'fill','linewidth',2),grid on 
axis([-2.1 6.1 -0.1 2.1]) 
legend('x[k]') 
n=5; 
stem(-kh+n,h,'fill','linewidth',2),grid on 
axis([-2.1 6.1 -0.1 2.1]) 
legend('h[n-k]=h[5-k]') 

n=0:4; 
y=[2 5 3 3 2]; 
stem(n,y,'fill','linewidth',2),grid on 
axis([-0.1 4.1 -0.1 5.1]) 
legend('y[n]');
