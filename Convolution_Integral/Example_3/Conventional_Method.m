time_points = -2:0.01:5;   
step_size = 0.01;         
total_points = length(time_points); 
  
input_signal = zeros(size(time_points)); 
input_signal(time_points >= 0 & time_points <= 1) = 2*time_points(time_points >= 0 & time_points <= 1); 
input_signal(time_points > 1 & time_points <= 2) = 2*(2 - time_points(time_points > 1 & time_points <= 2)); 
  
impulse_response = cos(2*pi*time_points) .* (time_points >= 0 & time_points <= 4); 
  
output_signal = zeros(1, 2*total_points - 1); 
  
for n = 1:2*total_points-1 
    for k = 1:total_points 
        if (n - k + 1 > 0) && (n - k + 1 <= total_points) 
            output_signal(n) = output_signal(n) + input_signal(k) * impulse_response(n - k + 1); 
        end 
    end 
end 
output_signal = output_signal * step_size; 
  
start_index = floor((length(output_signal) - total_points) / 2) + 1; 
final_output = output_signal(start_index:start_index + total_points - 1); 
  
subplot(3,1,1); 
plot(time_points, input_signal, 'LineWidth', 1.5); 
title('Input Signal x(t)'); 
grid on; 
  
subplot(3,1,2); 
plot(time_points, impulse_response, 'LineWidth', 1.5); 
title('Impulse Response h(t)'); 
grid on; 
  
subplot(3,1,3); 
plot(time_points, final_output, 'LineWidth', 1.5); 
title('System Response y(t)'); 
grid on; 
