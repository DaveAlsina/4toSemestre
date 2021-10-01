%% ejemplo 1
% https://www.mathworks.com/help/symbolic/differentiation.html 

syms x
f = (x.^2)./10 - 2.*sin(x);
x0 = 2.5;
e = 0.0001;
interval = [-10 10];


j = metodo_newton(f, x, e, x0, interval, 3);

%% ejemplo 2

syms x
f1 = 2.*(x.^3) - 6.*x;
x01 = 2;
e2 = 0.001;
interval = [-10 10];


j = metodo_newton(f1, x, e2, x01, interval, 1);


%% ejemplo 3

syms x
f2 = (1/3).*(x.^3) - x;
x02 = 1/2;
e3 = 0.001;
interval = [-10 10];


j = metodo_newton(f2, x, e3, x02, interval, 3);



%% ejemplo 4

syms x
f2 = (1/3).*(x.^3) - x;
x03 = -1/2;
e3 = 0.001;
interval = [-10 10];


j = metodo_newton(f2, x, e3, x03, interval, 3);




