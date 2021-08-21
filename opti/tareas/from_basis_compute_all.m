function [mincost, replace_indx, exit_code] = from_basis_compute_all(basis, b, c, Ib, In, verbose)
    
    exit_code = -1; %código de salida cuando el problema tiene un error o no se puede 
                    %resolver  
    

    %% Creación de todas las variables necesarias
    %matriz básica
    B = basis(:, Ib);
    %matriz no básica
    N = basis(:, In);
    
    %matriz inversa de la base(dejo de usarse por recomendación de matlab)
    %B_ = inv(B);
    
    %soluciones basicas
    %xb = B_ * b;
    xb = B\b;
    
        
    %vector de la solución
    x(Ib) = xb;
    x(In) = zeros(size(In));
    x = x';
    
    %% ¿es óptima la solución? 
    %costos reducidos
    %Cj = c(:,In) - c(:,Ib)*B_*N;
    Cj = c(:,In) - c(:,Ib)*(B\N);
     
    %función objetivo
    fo = c*x;

    %valor del costo reducido mínimo, y su respectivo índice
    [mincost, k] = min(Cj);
    replace_indx = -1;
    
    %% dado que la solución no es óptima
    if mincost < 0
        %calcula el vector y_k
        %y_k = B_ * basis(:, In(k));
        y_k = B\basis(:, In(k));
        
        %busca los índices del vector y_k con valores de entrada
        %mayores a cero
        y_ki_valid_indx = find(y_k > 0); 
        
        %% ¿no hay y_k's válidos?
        if(isempty(y_ki_valid_indx))
            return 
        end 
        
        %xb/y_k donde y_k es mayor que 0
        x_k = xb(y_ki_valid_indx)./ y_k(y_ki_valid_indx);
        
        %obtiene el valor mínimo de x_k y el índice correspondiente
        [x_k_min, x_k_indx] = min(x_k);
        
        %nuevo xb 
        xb = xb - (y_k * x_k_min);
        
        %obtiene el índice de la variable que se volvió cero
        replace_indx = find(xb == 0);
        
        %esto quiere decir que no hay novedades y que se encontró una
        %entrada que se pudo anular
        exit_code = 0;
    
    else 
        %esto quiere decir que no hay novedades y que se encontró una
        %entrada que se pudo anular
        exit_code = 1;
    end
    
    
    if verbose
        disp(['Dados los índices básicos: [' num2str(Ib) '] ']);
        disp(['Y dados los índices no básicos: [' num2str(In) '] ']);
        disp(['x es:']);
        disp(x);
        disp(['el valor de la función objetivo con dicho x es: ' num2str(fo) '']);
        disp(['el vector de costos reducidos es: ']);
        disp(Cj);
        disp(['ergo el vector que ingresa a la base es el de indx = ' num2str(In(k))'']);
        disp(['finalmente el vector que sale de la base es el de indx = ' num2str(Ib(replace_indx))'']);
    end
end