function [lambda_min] = quad_fit(f, interval, lambda, epsilon, verbose) 
%% Una vez satisfecha la condición de los 3 puntos

    %variable usada para poner la cantidad de puntos a usar en graficación
    npoints = (interval(2) - interval(1))*100; 
    count = 0;
    
    if verbose == 1
        disp('*******************************');
        disp(['Iteración número ' num2str(count) ' ']);
        disp('*******************************');
        disp('El vector lambda es: ');
        disp(lambda);
        disp('     ');
    end
    
    while abs(lambda(3) - lambda(1)) > epsilon
 
        b_ij = @(i,j) lambda(i).^2 - lambda(j).^2;
        a_ij = @(i,j) lambda(i) - lambda(j);
        
        %se encuentra el minimizador de la función cuadrática que pasa por los 
        %puntos dados en el vector lambda

        lambda_min = [b_ij(2,3) b_ij(3,1) b_ij(1,2)] * f(lambda)'; 
        lambda_min = lambda_min ./ ( 2 .* ( [a_ij(2,3) a_ij(3,1) a_ij(1,2)] * f(lambda)') );

        %condicional 1
        if lambda_min > lambda(2)
            
            disp("condicional 1")
            if f(lambda_min) > f(lambda(2))
                lambda = [lambda(1) lambda(2) lambda_min];
            else 
                lambda = [lambda(2) lambda_min lambda(3)];
            end

        %condicional 2
        elseif lambda_min < lambda(2)
            
            disp("condicional 2")
            if f(lambda_min) > f(lambda(2))
                lambda = [lambda_min lambda(2) lambda(3)];
            else 
                lambda = [lambda(1) lambda_min lambda(2)];
            end

        %condicional 3
        else
            
            disp("condicional 3")
            if abs(lambda(2) - lambda(1)) < abs(lambda(3) - lambda(2))
                lambda_min = lambda(2) + epsilon./2;
            else
                lambda_min = lambda(2) - epsilon./2;
            end
            
        end
        
        count = count +1;
        
        if verbose == 1
            disp('*******************************');
            disp(['Iteración número ' num2str(count) ' ']);
            disp('*******************************');
            disp('El vector lambda es: ');
            disp(lambda);
            disp('El minimizador de la función cuadrática');
            disp('que pasa por los lambdas es: ');
            disp(lambda_min);
            disp('     ');
            
        elseif verbose == 2 
            clf;
            hold on
            plot(linspace(interval(1), interval(2), npoints ), f(linspace(interval(1), interval(2), npoints )) )
            scatter(lambda(1), f(lambda(1)), 'bo')
            scatter(lambda(2), f(lambda(2)), 'kx')
            scatter(lambda(3), f(lambda(3)), 'ro')
            legend('funcion', 'lambda1', 'lambda2', 'lambda3')
            title('busqueda de optimo')
            hold off
            pause(0.1);
               
        elseif verbose == 3
            
            
            disp('*******************************');
            disp(['Iteración número ' num2str(count) ' ']);
            disp('*******************************');
            disp('El vector lambda es: ');
            disp(lambda);
            disp('El minimizador de la función cuadrática');
            disp('que pasa por los lambdas es: ');
            disp(lambda_min);
            disp('     ');
            
            clf;
            hold on
            plot(linspace(interval(1), interval(2), npoints ), f(linspace(interval(1), interval(2), npoints )) )
            scatter(lambda(1), f(lambda(1)), 'bo')
            scatter(lambda(2), f(lambda(2)), 'kx')
            scatter(lambda(3), f(lambda(3)), 'ro')
            legend('funcion', 'lambda1', 'lambda2', 'lambda3')
            title('busqueda de optimo')
            hold off
            pause(0.1);
            
        end
        
    end



end