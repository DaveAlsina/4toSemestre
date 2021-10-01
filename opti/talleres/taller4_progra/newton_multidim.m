function [xk2] = newton_multidim(f, x, x0, epsilon, verbose)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Input: f -> función simbólica en función del conjunto de vars 'x'
%          x -> conjunto de variables simbólicas de 'f' 
%          x0 -> punto inicial en el espacio
%          epsilon -> distancia threshold entre la solución última y 
%                   la anterior a esta (se usa como criterio de conv.)
%
%         verbose -> modo de verbosidad de la función (1: displays)
%
%   Output: 
%           xk2 -> x óptimo
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




    gradf = gradient(f);            %cálculo del gradiente de f
    hessianf = jacobian(gradf);     %cálculo del hessiano de f
    invHessianf = inv(hessianf);    %obtiene la inversa del hessiano

    x0_syms = subs(x, x, x0)';         
    xk = x0_syms;
    
    %estas 2 vars intermedias se hacen principalmente con propositos 
    %de printear
    hessianainv_evaluada = subs(invHessianf, x, xk');
    gradf_evaluado = subs(gradf, x, xk');
    
    xk2 = xk - subs(invHessianf, x, xk') * subs(gradf, x, xk');
    counter = 1;
    
    if verbose == 1
        disp('*****************************************');
        disp(['        Iteración número ' num2str(counter) ' ']);
        disp('*****************************************');

        disp('x_{k}: ');
        disp(xk);
        disp('Hessiana inversa evaluada: ');
        disp(hessianainv_evaluada);
        disp('Gradiente de f evaluado en x{k}');
        disp(gradf_evaluado);


        disp('x_{k+1}: ');
        disp(xk2);
        disp('   ');
        
        disp('distancia entre la solución anterior y la actual: ');
        disp(double(norm( xk2 - xk )));
    end
    
    
    %% Continua las iteraciones

    
    while  double(norm( xk2 - xk ))  >= epsilon
        
        
        xk_assist = xk2;
        
        %estas 2 vars intermedias se hacen principalmente con propositos 
        %de printear
        hessianainv_evaluada = subs(invHessianf, x, xk2');
        gradf_evaluado = subs(gradf, x, xk2');
        
        xk2 = xk2 - hessianainv_evaluada * gradf_evaluado;
        xk = xk_assist;
        
        counter = counter + 1;
        
        if verbose == 1
            disp('*****************************************');
            disp(['        Iteración número ' num2str(counter) ' ']);
            disp('*****************************************');
            
            disp('x_{k}: ');
            disp(xk);
            disp('Hessiana inversa evaluada: ');
            disp(hessianainv_evaluada);
            disp('Gradiente de f evaluado en x{k}');
            disp(gradf_evaluado);
            
            
            disp('x_{k+1}: ');
            disp(xk2);
            disp('   ');
            
            disp('distancia entre la solución anterior y la actual: ');
            disp(double(norm( xk2 - xk )));
        end
        
    end

    xk2 = double(xk2);


%% fuentes

% https://www.mathworks.com/help/symbolic/sym.hessian.html


end

