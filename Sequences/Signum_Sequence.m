function [x, n] = sigseq(n0, n1, n2)
n = n1:n2;
x = -1*(n < n0) + 1*(n > n0);
stem(n, x, 'filled');
xlabel('n');
ylabel('x[n]');
title('Signum Sequence');
grid on;
