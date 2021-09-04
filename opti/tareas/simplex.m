function [x] = simplex(basis, b, c, mode ,verbose)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT: basis -> matriz de las restricciones
%        b -> vector(columna) de los valores de las restricciones
%        c-> vector(fila) de los costos 
%        mode-> booleano que en verdadero significa minimizar y en falso 
%               solicita maximizar
% 
% OUTPUT: x -> vector(columna) con la solución
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% chequeos de los requerimientos sobre las inputs

    lim_dim = size(basis);
    rnk = rank(basis);
    b_dims = size(b);   %crea las variables de las dimensiones de b y c
    c_dims = size(c);   %para chequeos de la correctitud de los parámetros
                        %ingresados
                    
    % si b no es un vector columna o no tiene el mismo número
    % de filas que A, entonces levante un error y sálgase
    
    if (b_dims(2) ~= 1) || (lim_dim(1) ~= b_dims(1))
        disp('el vector b no es un vector columna');
        disp('o el b no tiene tantas filas como la matrix "basis"(matriz A)');
        return
    end
    
    %A es (m x n), B es (m x m), N (m x (n-m) )
    % Revisa que el rango de A sea m
    
    if lim_dim(1) ~= rnk
        disp(['El rango de la matrix no es el necesario, rango actual: ' num2str(rnk) '']);
        disp(['El rango de la matrix necesario: ' num2str(lim_dim(1)) '']);
        disp('Considere reformular el problema');
        return
    end
    
    
    %% Inicio de la fase 1
    
    max_lenght = min(lim_dim);   
    main_sys_restrictions_indxs = 1:max_lenght;
    
    %inicia la primera fase del simplex
    [Ib, In] = fase1_simplex(basis, b, verbose);
    
    if verbose 
        fprintf('\n');
        disp('********************************');
        disp('Primera fase terminada.');
        disp('********************************');
        fprintf('\n');
    end
    
    max_indx_Ib = max(Ib);
    max_indx_In = max(In);
    

    
    %% chequeos del resultado de la primera fase 
    
    % si hay un índice en Ib o In que exceda los límites de la base
    % normalita, entonces no se pudieron sacar todas las variables
    % artificiales del programa, es decir no es factible 
    
    if (max_indx_Ib > lim_dim(2)) || (max_indx_In > lim_dim(2))
        disp('Este sistema no es solucionable probablemente');
        disp('La región no es factible');
        disp('Considere reformular el problema');
        return
    end
    
    %si se pide que se maximize entonces se invierte el signo de los costos
    %y se sigue con el proceso normal de solución (fase 2)
    if mode == false 
        c = -c;
    end
    
    %% Inicio de la fase 2
    
    %un codigo de salida de 0 significa que todo va bien y que se debe
    %seguir iterando, un codigo de salida de -1 indica que no hay solución
    %factible, y un código de salida de 1 indica que se ha terminado el
    %simplex
    
    ext_code = 0;
    x = 0;          %vector solución inicializado por defecto
    
    while (ext_code == 0) && (ext_code ~= 1)
        
            fprintf('\n');
            [Ib, In, x, ext_code] = from_basis_compute_all(basis, b, c, Ib, In, verbose);
            if verbose 
                disp('=================================');
            end
    end
    
    %caso en que no existe óptimo factible
    if ext_code == -1
           x = [];          %vector solución inicializado por defecto
           disp('Este problema no tiene óptimo factible');
           disp('Considere reformular el problema');
           return
    end
        
    if mode == false
        disp('El valor de la Función Objetivo para esta maximización es:');
        disp(-c*x);
    else
        disp('El valor de la Función Objetivo para esta minimización es:');
        disp(c*x);
    end
    
end