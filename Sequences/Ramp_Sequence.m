function [x, n] = rampseq(n0, n1, n2);
n = n1:n2;
x = (n - n0) .* (n >= n0);
stem(n, x, 'filled');
xlabel('n');
ylabel('x(n)');
title('Ramp Sequence');
grid on;
