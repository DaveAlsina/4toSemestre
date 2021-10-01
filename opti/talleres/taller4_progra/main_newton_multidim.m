%% ejemplo 1

syms x [1 2]
f = (x1 - 2).^4 + (x2 - 5).^2;
x0 = [0 2];
epsilon = 0.1;
verbose = 1;


newton_multidim(f, x, x0, epsilon,verbose)
%%