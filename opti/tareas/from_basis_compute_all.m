function [Ib, In, x, exit_code] = from_basis_compute_all(basis, b, c, Ib, In, verbose)
    
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

    %valores de los costos reducidos mínimos, y su respectivos índices
    mincost = min(Cj);
    min_cost_indxs = find( Cj == mincost);
    
    %obtiene el valor mínimo de los de los índices de costos reducidos
    %que son elegibles para entrar a la base, y el índice de 
    %este vector que debe entrar a la base
    
    %ej: vector de indices, (* significa que son costos red. elegibles)
    %el costo red. elegido es el de menor índice y se pone entre ()
    %[3*, 5, (1*)]
    
    replace_non_basic_vec = min( In(min_cost_indxs) );
    replace_non_basic_vec_idx = find(In == replace_non_basic_vec);
    
    replace_indx = -1;
    
    %% dado que la solución no es óptima
    if mincost < 0
        %calcula el vector y_k
        %(B_inversa * a_k)
        y_k = B\basis(:, replace_non_basic_vec);
        
        %busca los índices del vector y_k con valores de entrada
        %mayores a cero
        y_ki_valid_indx = find(y_k > 0); 
        
        %% ¿no hay y_k's válidos?
        if(isempty(y_ki_valid_indx))
            
            if verbose 
               disp('Terminando ejecución...');
               disp(['Dados los índices básicos: [' num2str(Ib) '] ']);
               disp(['Y dados los índices no básicos: [' num2str(In) '] ']);
               disp(['no hay y_k mayores que cero']);
               disp('y_k: ')
               disp(y_k);
               disp(['el valor de la función objetivo con dicho x es: ' num2str(fo) '']);
               disp(['el vector de costos reducidos es: ']);
               disp(Cj);
            end
            
            return 
        end 
        
        %xb/y_k, donde y_k es mayor que 0
        x_k = xb(y_ki_valid_indx)./ y_k(y_ki_valid_indx);
        
        %obtiene el valor mínimo de x_k (epsilon) y el índice correspondiente
        [x_k_min, x_k_indx] = min(x_k);
        
        %nuevo xb 
        %xb - y_k * epsilon
        xb = xb - (y_k * x_k_min);
        
        %obtiene los índices de las variables que se volvieron cero
        replace_indx = find(xb == 0);
        
        %podrían haber varias xb que se anulen entonces por legla 
        %de bland se escoje la de menor índice
        
        %obtiene el valor mínimo de los índices básicos que se
        %pueden reemplazar
        %ej: [3*, 5, (1*)]
        replace_basic_vec = min( Ib(replace_indx) );
        replace_indx = find( Ib == replace_basic_vec );
                              
        %esto quiere decir que no hay novedades y que se encontró una
        %entrada que se pudo anular
        exit_code = 0;
    
        %prints para el usuario antes de cambiar los índices basicos y no
        %basicos
        if verbose
            disp(['Dados los índices básicos: [' num2str(Ib) '] ']);
            disp(['Y dados los índices no básicos: [' num2str(In) '] ']);
            disp(['x es:']);
            disp(x);
            disp(['el valor de la función objetivo con dicho x es: ' num2str(fo) '']);
            disp(['el vector de costos reducidos es: ']);
            disp(Cj);
            disp(['epsilon (tamaño de paso) es: [' num2str(x_k_min) ']']);
        end
        
        %se hace la actualización de los índices básicos y los
        %no básicos

        Ib(replace_indx) = replace_non_basic_vec;
        In(replace_non_basic_vec_idx) = replace_basic_vec;

        if verbose 
           disp(['ergo los nuevos indices básicos son = [' num2str(Ib) ']']);
           disp(['finalmente los nuevos índices no básicos son = [' num2str(In) ']']); 
        end
        
        return 
    else 
        %esto quiere decir que no hay novedades y que se encontró una
        %entrada que se pudo anular
        exit_code = 1;
        
        if verbose
            disp(['x es:']);
            disp(x);
            disp(['el valor de la función objetivo con dicho x es: ' num2str(fo) '']);
            disp(['el vector de costos reducidos es: ']);
            disp(Cj);
            disp(['ergo los indices básicos son = [' num2str(Ib) ']']);
            disp(['finalmente los índices no básicos son = [' num2str(In) ']']);
        end
        
        return 
    end
    

   
end