function [xprev_double] = gradientDescent(x, f0, f_ineq_up, f_ineq_low, ...
constraints1, constraints2, xstart, epsilon, interval, max_iters, verbose)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input:     
%            x  -> vector de variables simbolicas de las cuales depende f.
%
%            f0 -> función objetivo que tiene en cuenta la penalización por
%            dejar de cumplir la restricción de igualdad.
%
%            f_ineq_up  -> lista de funciones de desigualdad que son
%            acotadas superiormente por los coeficientes del vector
%            'constraints1'.
%
%            f_ineq_low -> lista de funciones de desigualdad que son
%            acotadas inferiormente por los coeficientes del vector
%            'constraints2'.
%
%            constraints1 -> restricciones que acotan superiormente.
%            constraints2 -> restricciones que acotan inferiormente.
%
%            xstart     -> Vector columna, vector inicial.
%            epsilon    -> magnitud aceptable del gradiente en el punto de solución 
%                       (sirve de criterio de finalización).
%
%            interval -> intervalo para la búsqueda con el algoritmo de
%            busqueda de linea de newton.
%
%            max_iters  ->  n máximo de iteraciones.
%            verbose    ->  modo verboso activado o desactivado (true/false).
%
% Output:
%            xprev_double   ->  Vector solución
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % vector de penalidades 'personalizadas' para cada 
    % restriccion que se incumpla en particular, por ejemplo si 
    % se quebranta una restriccion de desigualdad que acota superiormente 
    % solo el castigo para esa va a ser actualizado y aumentado
    
    p = ones(1,2*length(x));
    alpha = 10;                 % factor de aumento de penalidad
    
    % Construlle una función de penalización dadas las restricciones que
    % se ven quebrantadas
    f = f0;
 
    for i = 1:length(x)
        
        if xstart(i) > constraints1(i)
            p(i) = p(i).*alpha;         % aumenta el castigo particular
            f    = f + p(i).*(f_ineq_up(i).^2);
        end
        
        if xstart(i) < constraints2(i)
            p(i+length(x)) = p(i+length(x)).*alpha; % aumenta el castigo particular
            f              = f + p(i+length(x)).* (f_ineq_low(i).^2);
        end
        
    end
    
    grad =  gradient(f);        %función syms del gradiente
    normGrad =  norm(f);        %función syms de la norma del gradiente

    
    xprev_cell = num2cell(xstart);   %convierte a xstart a una celda 
                                     %que si se puede 
                                     %mandar como parámetro a una symsfunc    
    xprev_double = xstart';
    
    if verbose >= 1
       disp('El gradiente de f es: ');
       disp(grad);
       disp('La posición inicial es: ');
       disp(xprev_double);
       disp('---------------------------------------------------------');
       disp('                   ');
    end
    
    %% primera iteración
    
    % evalua el gradiente en el punto inicial dado y toma la dirección
    % contraria a este
    directionk = - double( subs(grad, x, xprev_cell) ); %esto es un vector col. normalito
    
    % ahora se quiere obtener el valor mínimo de la función parametrizada
    % en una dirección así:
    % lambdak = lambda tal que minimice f(xk + lambda*directionk)
    
    % crea una variable w que se mueve en toda la dirección solicitada 
    syms lambda   
    syms second_f(lambda, a, b)
    
    %donde a es xk y b es directionk
    second_f(lambda, a, b) = sym(a + lambda .* b);
    
    % w se mueve en toda la dir. solicitada
    % w es un vector que indicaba la dir. a moverse en función de lambda
    % osea es un vector multiplicado por lambda  
    w = sym2cell(second_f(lambda, xprev_double, directionk)');
    
    % evalua f en base a esa variable w, que a su vez solo dempende de 
    % syms 'lambda'
    
    f_lambda = subs(f, x, w); % en particular aquí pasa cada celda del 'vector'
                        % que corresponde la primera a x1*lambda por ejemplo
    
            
    if (verbose == 1) || (verbose == 0) 
            lambdak = metodo_newton(f_lambda, lambda, epsilon, 0.5, interval, max_iters/2, false);
               
    elseif (vebose > 1)
            lambdak = metodo_newton(f_lambda, lambda, epsilon, 0.5, interval, max_iters/2, true); 
    end
                        
    
    
    % vea que se retorna un vector 
    lambdak = double(lambdak);
    
    xprev_double = xprev_double + lambdak*directionk;
    xprev_cell = sym2cell( sym(xprev_double') );

    counter = 1;
    
    %nivel 1 de verbosidad (solo displays en consola)
    if verbose == 1
        disp(['Iteración número [' num2str(counter) '] ']);
        disp('Se optimizó siguiendo la dirección contraria al gradiente: ');
        disp(directionk);
        disp('El tamaño de paso en dicha dirección es: ');
        disp(lambdak);
        disp('La nueva ubicación es: ');
        disp(xprev_double);
        
        disp(['El error es de: ' num2str( double( subs(normGrad, x, xprev_cell) )) ' ']);
        disp('---------------------------------------------------------');
        disp('                   ');
    end
    
    % Construlle una función de penalización dadas las restricciones que
    % se ven quebrantadas
    f = f0;

    for i = 1:length(x)
        
        if xprev_double(i) > constraints1(i)
            p(i) = p(i).*alpha;                 % aumenta el castigo particular 
            f = f + p(i).* (f_ineq_up(i).^2);
        end
        
        if xprev_double(i) < constraints2(i)
            p(i+length(x)) = p(i+length(x)).*alpha; % aumenta el castigo particular
            f = f + p(i+length(x)).* (f_ineq_low(i).^2);
        end
        
    end
    
    grad =  gradient(f);        %función syms del gradiente
    normGrad =  norm(f);        %función syms de la norma del gradiente
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%    iteración del loop %%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    while  ( double(subs(normGrad, x, xprev_cell)) > epsilon) && (counter < max_iters)

        directionk = - double( subs(grad, x, xprev_cell) );
        
        % crea una variable w que se mueve en toda la dirección solicitada 
        w = sym2cell(second_f(lambda, xprev_double, directionk)');
        
        % evalua f en base a esa variable w, que asu vez solo dempende de 
        % syms 'lambda'
        f_lambda = subs(f, x, w);
        
        if (verbose == 1) || (verbose == 0) 
            lambdak = metodo_newton(f_lambda, lambda, epsilon, 0.5, interval, max_iters/2, false);
        
        elseif (vebose > 1)
            lambdak = metodo_newton(f_lambda, lambda, epsilon, 0.5, interval, max_iters/2, true);
        end
            
        % vea que se retorna un vector 
        lambdak = double(lambdak);
        
        xprev_double = xprev_double + lambdak*directionk;
        xprev_cell = sym2cell( sym(xprev_double') );
        
        counter = counter + 1;
        
        %nivel 1 de verbosidad (solo displays en consola)
        if verbose == 1
            disp(['Iteración número [' num2str(counter) '] ']);
            disp('Se optimizó siguiendo la dirección contraria al gradiente: ');
            disp(directionk);
            disp('El tamaño de paso en dicha dirección es: ');
            disp(lambdak);
            disp('La nueva ubicación es: ');
            disp(xprev_double);
            disp(['El error es de: ' num2str( double( subs(normGrad, x, xprev_cell) )) ' ']);
            disp('---------------------------------------------------------');
            disp('                   ');
        end


        % Construlle una función de penalización dadas las restricciones que
        % se ven quebrantadas
        f = f0;

        for i = 1:length(x)

            if xprev_double(i) > constraints1(i)
                p(i) = p(i).*alpha;     % aumenta el castigo particular
                f = f + p(i).* (f_ineq_up(i).^2);
            end

            if xprev_double(i) < constraints2(i)
                p(i+length(x)) = p(i+length(x)).*alpha;     % aumenta el castigo particular
                f = f + p(i+length(x)).* (f_ineq_low(i).^2);
            end

        end

        grad =  gradient(f);        %función syms del gradiente
        normGrad =  norm(f);        %función syms de la norma del gradiente
        
    end


end

