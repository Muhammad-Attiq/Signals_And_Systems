function [x,n]= stepseq(n0, n1, n2);
n = n1:n2;
x = (n >= n0);
stem(n, x, 'filled');
xlabel('n');
ylabel('x[n]');
grid on;
