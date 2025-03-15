t1=-3:0.1:0; 
x1=zeros(size(t1)); 
t2=0:0.1:1; 
x2=ones(size(t2)); 
t3=1:0.1:3; 
x3=zeros(size(t3)); 
t=[t1 t2 t3]; 
x=[x1 x2 x3]; 
plot(t,x,'linewidth',2),grid on 
ylim([-0.1 1.1]); 
legend('x(t)')
plot(t,3*x,'linewidth',2),grid on 
ylim([-0.1 3.1]); 
legend('y(t)');
