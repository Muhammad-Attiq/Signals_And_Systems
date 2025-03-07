function [x, n] = impseq(n0, n1, n2)
    n = n1:n2;
    x = (n == n0);
    stem(n, x, 'filled');
    title('Unit Impulse');
    xlabel('n');
    ylabel('x[n]');
end
