%fun_obj = @(x) x.^2 + 2*x + 1;
%init_a = -4;
%init_b = 2;

fun_obj = @(x) x.^2 + cos(x);
init_a = -3;
init_b = 2;

I = 0.001;

[a, b] = aurea(init_a, init_b, I, fun_obj, true, true);