t = -2:0.01:5; 
x = zeros(size(t)); 
x(t>=0 & t <= 1) = 2*t(t>=0 & t <= 1); 
x(t > 1 & t <= 2) = 2*(2 - t(t > 1 & t <= 2));  
h = cos(2*pi*t) .* (t >= 0 & t <= 4); 
y_conv = conv(x, h, 'same');  
  
subplot(3,1,1); 
plot(t, x, 'LineWidth', 1.5); 
title('Input Signal x(t)'); 
xlabel('Time (s)'); 
ylabel('Amplitude'); 
grid on; 
  
subplot(3,1,2); 
plot(t, h, 'LineWidth', 1.5); 
title('Impulse Response h(t)'); 
xlabel('Time (s)'); 
ylabel('Amplitude'); 
grid on; 
  
subplot(3,1,3); 
plot(t, y_conv, 'LineWidth', 1.5); 
title('System Response'); 
xlabel('Time (s)'); 
ylabel('Amplitude'); 
grid on;
