t=-3:0.1:3; 
x1=heaviside(t)-heaviside(t-1); 
x2=heaviside(t)-heaviside(t-2); 
a1=2;
a2=3; 
z=a1*x1+a2*x2;
y = 2*z
plot(t,y,'linewidth',2)
grid on 
ylim([-1 11]);
z1=2*x1; 
z3=3*x2;
y=a1*z1+a2*z2; 
plot(t,y,'linewidth',2),grid on 
ylim([-1 11]) 
