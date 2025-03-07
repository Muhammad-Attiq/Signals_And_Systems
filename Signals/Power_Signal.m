n = 0:99999; 
x = cos(pi/4 * n);
sum_squared = sum(abs(x).^2);
N = length(n); 
P_infinity = sum_squared / N;
disp(['The average power P_infinity is: ', num2str(P_infinity)]);
