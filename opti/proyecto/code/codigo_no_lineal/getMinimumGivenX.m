function [ans] = getMinimumGivenX(xstart)
 
    % numero de cultivos 
    n = 2;

    x = sym('x',1:n);
    assume(x>=1);

    % vea que para este caso la ecuación (I*X) - (C*X) = (I - C)*(X)
    % donde I y C son los vectores de ingresos y costos respectivamente 
    % (Ingresos y costos por tipo de arbol cultivado) 
    % unidades de dinero en millones de pesos

    % I = [cerezos, aguacate]
    % C = [cerezos, aguacate]

    I = [400 500];
    C = [20 50];

    H = 0;
    v = [2, 1];

    for i = 1:n
       H = log(x(i)).*sym(v(i)) + H; 
    end

    f = H + sum((sym( I - C )).*x);
    f = -f;
    r = [2 3];

    % Area total cultivable (en hectáreas)
    At = 200000;

    % recuerde las restricciones sobre
    % betas = [cerezos, aguacate]

    betas = [1.2  1];  

    % calculo de las restricciones para 
    b = betas.*(At./(n.*pi.*(r + r./10).^2));

    ineq_constrain = [];

    for i = 1:n
       ineq_constrain = [ineq_constrain x(i) - sym(b(i))];
       %ineq_constrain = [ineq_constrain -x(i) + 1];
    end

    eq_constrain = [];
    for i = 1:n
       eq_constrain = [eq_constrain (x(i).*((r(i) + r(i)./10).^2).*pi) - sym(At)];
    end

    f_eq = [sum(eq_constrain)]; 

    %xstart = [100; 10];
    epsilon = 0.1;
    interval = [1, 1000];
    verbose = 0;

    ans = metodo_penalizacion(f, f_eq, ineq_constrain, x, xstart, epsilon, interval, 100, verbose);
    disp(double(subs(-f, x, ans')));

end

