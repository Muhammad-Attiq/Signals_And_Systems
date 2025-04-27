t = -3:0.01:6; 
h = exp(-t).*(t >= 0); 
x = zeros(size(t)); 
x(t >= -1 & t <= 0.5) = 0.6; 
x(t > 0.5 & t <= 3) = 0.3; 
y_conv = conv(x, h, 'same');  
  
subplot(3,1,1); 
plot(t, x, 'LineWidth', 1.5); 
title('Input Signal x(t)'); 
grid on; 
subplot(3,1,2); 
plot(t, h, 'LineWidth', 1.5); 
title('Impulse Response h(t)'); 
grid on; 
  
subplot(3,1,3); 
plot(t, y_conv, 'LineWidth', 1.5); 
title('Output Signal y(t)'); 
grid on; 
