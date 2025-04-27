time_points = 0:0.01:10;   
step_size = 0.01;         
total_points = length(time_points); 
  
impulse_response = zeros(size(time_points)); 
impulse_response(time_points >= 1 & time_points <= 2) = 1; 
  
input_signal = zeros(size(time_points)); 
input_signal(time_points >= 1 & time_points <= 2) = 1;     
  
output_signal = zeros(1, 2*total_points - 1); 
  
for n = 1:2*total_points-1 
    for k = 1:total_points 
        if (n - k + 1 > 0) && (n - k + 1 <= total_points) 
            output_signal(n) = output_signal(n) + input_signal(k) * impulse_response(n - k + 1); 
        end 
    end 
end 
  
output_signal = output_signal * step_size; 
output_time = (0:length(output_signal)-1)*step_size; 
  
subplot(3,1,1); 
plot(time_points, input_signal, 'LineWidth', 1.5); 
title('Input Signal'); 
grid on; 
  
subplot(3,1,2); 
plot(time_points, impulse_response, 'LineWidth', 1.5); 
title('Impulse Response'); 
grid on; 
  
subplot(3,1,3); 
plot(output_time, output_signal, 'LineWidth', 1.5);  
title('Convolution Result '); 
xlim([0 10]);   
grid on; 
