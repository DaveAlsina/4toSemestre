%% ejemplo 1
% https://www.mathworks.com/help/symbolic/differentiation.html 

syms x
f = (x.^2)./10 - 2.*sin(x);
x0 = 2.5;
e = 0.0001;
interval = [-10, 10];

j = metodo_newton(f, x, e, x0, interval, true)

%% ejemplo 2