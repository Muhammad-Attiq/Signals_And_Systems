t = 0:0.001:5;  
x_t = t .* cos(2*pi*t); 
subplot(3,2,1); 
plot(t, x_t, 'LineWidth', 1.5); grid on; 
subplot(3,2,2); 
plot(-t, x_t, 'LineWidth', 1.5); grid on; 
subplot(3,2,3); 
plot(t/5, x_t, 'LineWidth', 1.5); grid on; 
subplot(3,2,4); 
plot(1+3*t, x_t, 'LineWidth', 1.5); grid on; 
subplot(3,2,5); 
plot(-1-3*t, x_t, 'LineWidth', 1.5); grid on; 
