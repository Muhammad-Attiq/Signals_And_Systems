t=-5:0.001:10; 
p=heaviside(t)-heaviside(t-5); 
y=t.*exp(-t).*p; 
plot(t,y,'linewidth',2),grid on 
ylim([-0.05 0.4]) 
legend('y(t)') 
plot(t+3,y,'linewidth',2),grid on 
ylim([-0.05 0.4]) 
legend('y(t-3)')
t=-5:0.001:10; 
p=heaviside(t-3)-heaviside(t-8); 
y=t.*exp(-t).*p; 
plot(t,y,'linewidth',2),grid on 
ylim([-0.01 0.2]) 
legend('S[x(t-3)]') 
