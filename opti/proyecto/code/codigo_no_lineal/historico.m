function [x] = metodo_penalizacion(f_objetivo,f_eq, f_ineq, var, xstart, epsilon, interval, verbose)

    p = 1000000000;
    p = p*alpha;

    penalize_eq = 0;
    for i = 1:length(f_eq)
        penalize_eq = penalize_eq +  p.*(f_eq(i).^2);
    end


    penalize_ineq = 0;
    for i = 1:length(f_ineq)
       penalize_ineq = penalize_ineq + p.*(f_ineq(i).^2);     
    end


    q = f_objetivo + penalize_eq + penalize_ineq;

    gradientDescent(var, q, xstart, epsilon, interval, 100, verbose);


    
    
 %   
 %   fields = fieldnames(x_solved); % extract names of features
 %   solution = [];
    
 %   for i = 1:length(fields)
        
 %       expr = getfield(x_solved, fields{i});
 %       ans = limit(expr, p, inf);
 %       solution = [ solution ans];
 %   end
    
    x = x_solved;

end
