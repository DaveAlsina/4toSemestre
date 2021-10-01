
syms x [1 2] real           %variables simbólicas x1 y x2 empaquetadas en x
f(x1, x2) = x1^2 + x2.^2;     %función simbólica
xstart = [3 5];
epsilon = 0.005;
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
