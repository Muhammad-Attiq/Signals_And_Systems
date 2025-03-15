t=0:0.01:10; 
x=cos(2*pi*t); 
plot(t,x,'linewidth',2), grid on 
ylim([-2 2]) 
xlim([-1, 11])
y1=x.^2; 
plot(t,y1,'linewidth',2), grid on 
ylim([-0.5 1.5]) 
y2=t.*x; 
plot(t,y2,'linewidth',2), grid on
xlim([-1, 11])
