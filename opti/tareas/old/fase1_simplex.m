%A = [1 1 -1 0; 2 1 0 -1];
%b = [1 1]';
%[I_B, I_N] = f_fase1(A,b);

%% Funciones
function [I_B, I_N] = f_fase1(A,b, verbose)

% Ejecuta la primera fase del algoritmo simplex
% args: 
%       A: matriz de coeficientes en estado fundamental (con variables de holgura)
%       b: vector de lado derecho de restricciones
%       ppl_idx: lista de indices de variables principales sin las de holgura ni las
%                artificiales
% returns:
%       I_B: Indice de vectores de A de base inicial
%       I_N: Indice de vectores no base de A

iter = 1; % contador de las iteraciones del algoritmo
disp("Iteracion "+num2str(iter));

% Verificacion inicial de que columnas finales forman identidad
% A2 es la matriz A con la identidad al final

if all(all(A(:,size(A,1))==eye(size(A,1))))
    A2 = A;
else
    A2 = [A, eye(size(A,1))];
end
%A;
%A2

indices_vars = (1:length(A2)); % lista de indices de variables de matriz extendida

% Seleccion de indices de base con vectores de matriz identidad
I_B = (size(A2,2) - size(A2,1)+1):size(A2,2);
I_N = 1:size(A,2);

% Cambio de coeficientes de funcion de costo
c2 = [zeros(size(A,2),1); ones(size(A2,2) - size(A,2),1)]';
c_B = c2(I_B); % coefs de base
c_N = c2(I_N); % coefs de no base
%disp("I_B = ")
%disp(I_B);

B = A2(:,I_B); % base
Binv = inv(B);
N = A2(:,I_N); % no base
x_b = B\b; % vector de valores con la base

% Vector de valores de x
x = zeros(size(A2,2),1);
x(I_B) = x_b;
%z0 = c_B*x_b; % costo inicial

%zf = z0; % costo final
wT = c_B*Binv;
c_N_bar = c_N - wT*N; % costo reducido

while iter == 1 || any(c_N_bar < 0)
    disp("Iteracion "+num2str(iter));
    disp("I_B = ")
    disp(I_B);
    disp("I_N = ")
    disp(I_N)
    disp("c = ")
    disp(c2)
    disp("x_B = ")
    disp(x_b)
    disp("x = ")
    disp(x)
    disp("C_N = ")
    disp(c_N_bar)

    % Buscamos el mas pequeño negativo
    %[~, idx_var_in] = min(c_N_bar); % ubicacion en I_N de variable que va a entrar
    % se busca las posiciones donde se encuentra el costo reducido minimo
    % idx_var_in = find(c_N_bar == min(c_N_bar)); % ubicacion en I_N de variable que va a entrar
    idx_var_in = c_N_bar == min(c_N_bar);
    disp("Indices no basicos posibles:")
    disp(I_N(idx_var_in))
    num_var_in = min(I_N(idx_var_in)); % numero de la variable que va a entrar
    disp("variable que entra: x"+num2str(num_var_in));

    % En y buscamos todos los que sean > 0
    y = Binv * A2(:,num_var_in);
    b_bar = Binv*b;

    mat_y_bb_idx = [y,b_bar,I_B'];
    mat_y_bb_idx = mat_y_bb_idx(y>0,:);

    % matriz de cocientes e indices respectivos
    Q = [mat_y_bb_idx(:,2)./mat_y_bb_idx(:,1),mat_y_bb_idx(:,3)];
    disp("y = ")
    disp(y)
    disp("b_bar = ")
    disp(b_bar)
    disp("Matriz de cocientes Q(idx): ")
    disp(Q);
    disp("eps = "+num2str(min(Q(:,1))))
    
    % Se elige el menor de los indices de las variables que salen
    num_var_out = min(Q(Q(:,1)==min(Q(:,1)),2)); % numero de la variable que sale
    % Intercambiando indices de variables
    disp("Se saca x"+num2str(num_var_out)+" remplazandola por x"+num2str(num_var_in))
    I_B(I_B==num_var_out) = num_var_in;
    disp("Se realizo el cambio en I_B")
    disp("Nuevo I_B:")
    disp(I_B)

    % CAMBIOS FINALES ANTES DE SIGUIENTE ITERACION
    iter = iter + 1; % Ahora ya no es el primer turno
    I_N = setdiff(indices_vars,I_B);
    disp("Nuevo I_N = ")
    disp(I_N)
    c_B = c2(I_B); % nuevos coefs de base
    c_N = c2(I_N); % nuevos coefs de no base
    disp("Nueva B:")
    B = A2(:,I_B); % base
    Binv = inv(B);
    N = A2(:,I_N); % no base
    x_b = B\b; % vector de valores con la base
    
    disp("x_b = ")
    disp(x_b)
    disp("I_B = ")
    disp(I_B);
    disp("I_N = ")
    disp(I_N);

    % Vector de valores de x
    x = zeros(size(A2,2),1);
    x(I_B) = x_b;
    z0 = c_B*x_b; % nuevo costo
    disp("Costo z0 = "+num2str(z0))

    wT = c_B*Binv;
    c_N_bar = c_N - wT*N; % es barra?
    disp("Algun valor de C_N < 0: "+num2str(any(c_N_bar < 0)))
    disp("=================================")
end
indices_va = [size(A,2)+1:size(A2,2)]; % indices de variables aleatorias
I_B = sort(I_B);
I_N = sort(I_N);
if any(ismember(I_B,indices_va))
    disp("ERROR: no hay solucion basica factible")
end
I_N = [setdiff(indices_vars,[indices_va I_B])];
disp("I_B: " + num2str(I_B));
disp("I_N: " + num2str(I_N));
end
