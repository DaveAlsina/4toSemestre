%% ejemplo 1

syms x [1 2]
f = (x1 - 2).^4 + (x2 - 5).^2;
x0 = [0 2];
epsilon = 0.1;
verbose = 1;


newton_multidim(f, x, x0, epsilon,verbose)
%% ejemplo 2

syms x [1 2]
f = (x1 + x2 - 3).^2 + (x1 - x2 + 1).^2;
x0 = [3 5];
epsilon = 0.001;
verbose = 1;


newton_multidim(f, x, x0, epsilon,verbose)