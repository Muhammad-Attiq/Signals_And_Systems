t = -1:0.001:1; 
tri_t = 1 - abs(t);  
tri_squared = tri_t.^2;
E_infinity = trapz(t, tri_squared);
fprintf('The total energy E(infinty) is: %.4f\n', E_infinity);
