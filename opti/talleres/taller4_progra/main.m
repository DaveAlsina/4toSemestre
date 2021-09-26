

syms x [1 2] real           %variables simbólicas x1 y x2 empaquetadas en x
f(x1, x2) = x1^2 + x2.^2;     %función simbólica
xstart = [3 5];
epsilon = 0.0005;
interval = [-1000, 1000];
verbose = false

g = gradient(f);
ng = norm(g);

%%

hold on
fsurf(f, 'ShowContours', 'on')
%fsurf(ng, 'ShowContours', 'on')
%scatter3([0], [0], vpa(subs(f, x, [0 0]) ))
camlight
hold off

%%


a = double(g(1,2));
b = [2;3];

syms lambda
syms sf(lambda, a, b)
sf(lambda, a, b) = sym(b + lambda*a);

w = sym2cell(sf(lambda, [1 2], [0 0]))
f(w{:})


%%

syms x [1 2] real           %variables simbólicas x1 y x2 empaquetadas en x
f(x1, x2) = x1^3 + x2.^3;     %función simbólica
xstart = [3;5];
epsilon = 0.0005;
interval = [-1000, 1000];
verbose = false;

g = gradient(f);
ng = norm(g);

%%
gradientDescent(x, f, xstart, epsilon, interval, 100, verbose);

%%

% syms: 
%https://www.mathworks.com/help/symbolic/sym.html#mw_b4228c40-a002-49a8-a6cc-1bec4af17ca8

% calcular el grad: 
% https://www.mathworks.com/matlabcentral/answers/449917-how-to-calculate-gradients-of-a-symbolic-function
% https://uk.mathworks.com/matlabcentral/answers/319176-calculating-the-gradient-of-a-function

% conversion: https://www.mathworks.com/help/symbolic/conversion.html

% pasar vector a syms function:
% https://www.mathworks.com/matlabcentral/answers/436853-how-to-create-symbolic-function-for-vector-input
