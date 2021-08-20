function [mincost, replace_indx, exit_code] = from_basis_compute_all(basis, b, c, Ib, In)
    
    exit_code = -1; %código de salida cuando el problema tiene un error o no se puede 
                    %resolver  
    
    %% Creación de todas las variables necesarias
    %matriz básica
    B = basis(:, Ib);
    %matriz no básica
    N = basis(:, In);
    %matriz inversa de la base
    B_ = inv(B);
    
    %soluciones basicas
    xb = B_ * b;
        
    %vector de la solución
    x(Ib) = xb;
    x(In) = zeros(size(In));
    x = x';
    
    %% ¿es óptima la solución?
    
    %costos reducidos
    Cj = c(:,In) - c(:,Ib)*B_*N;
    
    %función objetivo
    fo = c.*x;
    
    %valor del costo reducido mínimo, y su respectivo índice
    [mincost, k] = min(Cj);
    replace_indx = -1;
    
    %% la solución no es óptima
    if mincost < 0
        %calcula el vector y_k
        y_k = B_ * basis(:, In(k));
        
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
        
        xb = xb - (y_k * x_k_min);
        
        %obtiene el índice de la variable que se volvió cero
        [, replace_indx] = find(xb == 0);
    end
end