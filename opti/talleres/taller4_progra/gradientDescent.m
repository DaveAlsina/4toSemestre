function [xprev_double] = gradientDescent(x, f, xstart, epsilon, interval, max_iters, verbose)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input:     
%            x -> vector de variables simbolicas de las cuales depende f
%            f -> función a optimizar en función de las variables x
%            xstart -> Vector columna, vector inicial
%
%            epsilon -> magnitud aceptable del gradiente en el punto de solución 
%                      (sirve de criterio de finalización).
%
%            interval: intervalo para la búsqueda con el algoritmo de
%            busqueda de linea de newton
%
%            max_iters: n máximo de iteraciones
%            verbose: modo verboso activado o desactivado (true/false)
% Output:
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    gradf = gradient(f);        %función syms del gradiente
    normGradf = norm(gradf);    %función syms de la norma del gradiente
    
    xprev_cell = num2cell(xstart);   %convierte a xstart a una celda 
                                     %que si se puede 
                                     %mandar como parámetro a una symsfunc    
    xprev_double = xstart;
    
    if verbose == 1
       disp('El gradiente de f es: ');
       disp(gradf);
       disp('La posición inicial es: ');
       disp(xprev_double);
       disp('---------------------------------------------------------');
       disp('                   ');
    end
    
    %% primera iteración
    
    % evalua el gradiente en el punto inicial dado y toma la dirección
    % contraria a este
    directionk = - double( gradf(xprev_cell{:}) ); %esto es un vector col. normalito
    
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
    w = sym2cell(second_f(lambda, xprev_double, directionk));
    
    % evalua f en base a esa variable w, que a su vez solo dempende de 
    % syms 'lambda'
    
    f_lambda = f(w{:}); % en particular aquí pasa cada celda del 'vector'
                        % que corresponde la primera a x1*lambda por ejemplo
    
            
    if verbose == 1 
            lambdak = metodo_newton(f_lambda, lambda, epsilon, 0.5, interval, max_iters/2, false);
    else
            lambdak = metodo_newton(f_lambda, lambda, epsilon, 0.5, interval, max_iters/2, true);
    end                       
                        
    
    
    % vea que se retorna un vector 
    lambdak = double(lambdak);
    
    xprev_double = xprev_double + lambdak*directionk;
    xprev_cell = sym2cell( sym(xprev_double) );

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
        disp(['El error es de: ' num2str(double(normGradf(xprev_cell{:}))) ' ']);
        disp('---------------------------------------------------------');
        disp('                   ');
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%    iteración del loop %%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    while  (double(normGradf(xprev_cell{:}) > epsilon)) && (counter < max_iters)

        directionk = - double( gradf(xprev_cell{:}) );
        
        % crea una variable w que se mueve en toda la dirección solicitada 
        w = sym2cell(second_f(lambda, xprev_double, directionk));
        
        % evalua f en base a esa variable w, que asu vez solo dempende de 
        % syms 'lambda'
        f_lambda = f(w{:});
        
        if verbose == 1 
            lambdak = metodo_newton(f_lambda, lambda, epsilon, 0.5, interval, max_iters/2, false);
        else
            lambdak = metodo_newton(f_lambda, lambda, epsilon, 0.5, interval, max_iters/2, true);
        end
            
        % vea que se retorna un vector 
        lambdak = double(lambdak);
        
        xprev_double = xprev_double + lambdak*directionk;
        xprev_cell = sym2cell( sym(xprev_double) );
        
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
            disp(['El error es de: ' num2str(double(normGradf(xprev_cell{:}))) ' ']);
            disp('---------------------------------------------------------');
            disp('                   ');
        end

    end


end

