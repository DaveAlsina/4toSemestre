function [x] = metodo_penalizacion(f_objetivo, f_eq, f_ineq_up, f_ineq_low, var, ...
    xstart, constraints1, constraints2, epsilon, interval, max_iters,verbose)

    p = 1000000;
    
    % se crea una sola función para la penalización por salir de la
    % igualdad
    
    penalize_eq = 0;
    for i = 1:length(f_eq)
        penalize_eq = penalize_eq +  p.*(f_eq(i).^2);
    end


     q = f_objetivo + penalize_eq;
    
    x =  gradientDescent(var, q, f_ineq_up, f_ineq_low, constraints1, constraints2, xstart, epsilon, interval, max_iters, verbose);
    x = double(x);


end
