function [lambda_min] = quad_fit(f, interval, epsilon)

%% Objetivo inicial: Obtener la condición de los 3 puntos

    % es decir 
    % necesito tener lambdas tales que:
    % f(lambda1) < f(lambda2) < f(lambda3) y además: 
    % lambda1 < lambda2 < lambda3
  
    npoints = (interval(2) - interval(1))*100; 
    lambda1 = interval(1);                       %punto inicial (extremo izquierdo)
    lambda2 = lambda1 + 0.618; %abs(interval(1)).*0.618; %segundo punto arbitrariamente colocado
    lambda3 = 0;                                 %se inicializa lambda3 para su asignación
   
    if f(lambda2) >= f(lambda1)
        
        disp([f(lambda2), f(lambda1)])
        lambda3 = lambda2;      
        
        %punto medio del intervalo [lambda1 - lambda3]
        lambda2 = lambda1 + abs(lambda3 - lambda1)./2; 
        count = 2;

        hold on
        plot(linspace(interval(1), interval(2), npoints ), f(linspace(interval(1), interval(2), npoints )) )
        scatter(lambda1, f(lambda1), 'bx')
        scatter(lambda2, f(lambda2), 'ko')
        scatter(lambda3, f(lambda3), 'ro')
        legend('funcion', 'lambda1', 'lambda2', 'lambda3')
        hold off

        
        %hasta que obtenga que la condición de las f(lambdas) se cumple 
        %voy a ir dividiendo el pedacito de intervalo en 1/2, 1/4, 1/8, 
        %así sucesivamente hasta lograrlo
        while ~( (f(lambda1) >= f(lambda2)) && (f(lambda2) <= f(lambda3)) ) && (lambda2 >= interval(1))  
            lambda2 = lambda1 + abs(lambda3 - lambda1)./(2); 
            count = count + 1;
            
            clf;
            hold on
             plot(linspace(interval(1), interval(2), npoints ), f(linspace(interval(1), interval(2), npoints )) )
            scatter(lambda1, f(lambda1), 'bx')
            scatter(lambda2, f(lambda2), 'ko')
            scatter(lambda3, f(lambda3), 'ro')
            legend('funcion', 'lambda1', 'lambda2', 'lambda3')
            title('busqueda de la condicion de los 3 puntos')
            hold off
            pause(0.1);
            
        end
        
    else

        %lambda2 = lambda2;
        
        %avanza el punto más hacia la derecha
        lambda3 = lambda2 + (abs(lambda2).*0.618); %en búsca de f(lambda3) más
                                                   %grande
        count = 2;
        
        hold on
         plot(linspace(interval(1), interval(2), npoints ), f(linspace(interval(1), interval(2), npoints )) )
        scatter(lambda1, f(lambda1), 'bo')
        scatter(lambda2, f(lambda2), 'ko')
        scatter(lambda3, f(lambda3), 'rx')
        legend('funcion', 'lambda1', 'lambda2', 'lambda3')
        hold off
                                          
        while  ~( (f(lambda1) >= f(lambda2)) && (f(lambda2) <= f(lambda3)) ) && (lambda3 <= interval(2)) 
            lambda3 = lambda2 + (abs(lambda2).* (0.618) .* count);
            count = count +1;
            
            clf;
            hold on
             plot(linspace(interval(1), interval(2), npoints ), f(linspace(interval(1), interval(2), npoints )) )
            scatter(lambda1, f(lambda1), 'bo')
            scatter(lambda2, f(lambda2), 'ko')
            scatter(lambda3, f(lambda3), 'rx')
            legend('funcion', 'lambda1', 'lambda2', 'lambda3')
            title('busqueda de la condicion de los 3 puntos')
            hold off
            pause(0.1);
           
        end
        
        if  ~( ( f(lambda1) >= f(lambda2) ) && ( f(lambda2) <= f(lambda3) ) ) 
            disp("Apesar de haber buscado lamda3 que ayudara.");
            disp("Esta se salió del intervalo planteado sin cumplir con la restricción");
            disp("los valores de lambda son: ")
            disp([lambda1, lambda2, lambda3])
            disp("las respectivas evaluaciones de los lambdas son: ")
            disp([f(lambda1), f(lambda2), f(lambda3)])
        end
    end
    
    lambda = [lambda1 lambda2 lambda3];
    
%% Una vez satisfecha la condición de los 3 puntos

    %b_ij = @(i,j) lambda(i).^2 - lambda(j).^2;
    %a_ij = @(i,j) lambda(i) - lambda(j);

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
        
        disp("lambda")
        disp(lambda)
        disp("lambda min")
        disp(lambda_min)
        
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

