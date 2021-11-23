function [x] = metodo_penalizacion(f_objetivo,f_eq, f_ineq, var, xstart, epsilon, interval, max_iters,verbose)

    %p = 10000000000000000000;
    p = 100000;
    
    penalize_eq = 0;
    for i = 1:length(f_eq)
        penalize_eq = penalize_eq +  p.*(f_eq(i).^2);
    end


    penalize_ineq = 0;
    for i = 1:length(f_ineq)
       penalize_ineq = penalize_ineq + p.*(f_ineq(i).^2);     
    end


    q = f_objetivo + penalize_eq + penalize_ineq;
    x =  gradientDescent(var, q, xstart, epsilon, interval, max_iters, verbose);
    x = double(x);

    
    
 %   
 %   fields = fieldnames(x_solved); % extract names of features
 %   solution = [];
    
 %   for i = 1:length(fields)
        
 %       expr = getfield(x_solved, fields{i});
 %       ans = limit(expr, p, inf);
 %       solution = [ solution ans];
 %   end
    
   % x = x_solved;

end
