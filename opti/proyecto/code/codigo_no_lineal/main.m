% numero de cultivos 
n = 4;

% crea tantas variables simbólicas como número
% de cultivos hay
x = sym('x', [1 n]);
assume(x>=1);
assume(x,'real');

%% seteo de variables iniciales y funcion objetivo

% vea que para este caso la ecuación (I*X) - (C*X) = (I - C)*(X)
% donde I y C son los vectores de ingresos y costos respectivamente 
% (Ingresos y costos por tipo de arbol cultivado) 
% unidades de dinero en millones de pesos

% I = [cerezos, aguacate, mango, durazno]
% C = [cerezos, aguacate, mango, durazno]

I = [400  500  200  400];
C = [20   50   10   18];

% H es la función de ingresos del hummus
% (acá asumimos que no tiene costo alguno el hacer hummus)
H = 0;

% el vector fila v es un factor de escalamiento de los ingresos 
% de hummus para cierto tipo de cultivo, es como decir: 
% el arbol de mangos me da más hummus que el de duraznos
% [cerezos, aguacate, mango, durazno]
v = [2 1 3 2];

for i = 1:n
   H = log(x(i)).*sym(v(i)) + H; 
end

% función objetivo de ganancias totales para la empresa cultivadora
f = H + sum((sym( I - C )).*x);

% se multiplica por -1 porque queremos maximizar
f = -f;

% radio en metros que ocupa un arbol de cierto tipo (en metros)
% [cerezos, aguacate, mango, durazno]
r = [5  4  15 6];

% Area total cultivable (en metros cuadrados)
At = 200000;

% recuerde las restricciones sobre
% betas = [cerezos, aguacate, mango, durazno]

betas = [1.2  1  1.3  1.3];  

% calculo de las restricciones para las cantidades máximas que se pueden
% plantar
b1 = betas.*(At./(n.*pi.*(r + r./10).^2));

% calculo de las restricciones para las cantidades mínimas de cierto arbol
% que se pueden plantar
b2 = [1 1 1 1];


%% Calculo de las restricciones de igualdad y desigualdad

% generación de la lista de restricciones de desigualdad que acotan 
% superior mente al vector solución
ineq_constraint_upper = [];

for i = 1:n
   ineq_constraint_upper = [ineq_constraint_upper x(i) - sym(b1(i))];
   
end

% generación de la lista de restricciones de desigualdad que acotan 
% inferiormente al vector solución

ineq_constraint_lower = [];
for i = 1:n
    ineq_constraint_lower = [ineq_constraint_lower -x(i) + 1];
end

% generación de la lista de restricciones de igualdad
eq_constrain = [];

for i = 1:n
   eq_constrain = [eq_constrain (x(i).*((r(i) + r(i)./10).^2).*pi)];
end

eq_constrain = [ sum(eq_constrain)  - sym(At) ]; 

%% Corrido del algoritmo 

epsilon = 0.1;

%intervalo para la busqueda de linea con el método de newton
interval = [1, 10000];

% no mandar ningún tipo de output
% al ir corriendo el algoritmo
verbose = 0;

% número de puntos aleatorios que se van a poner como puntos iniciales
% para el descenso del gradiente
ntrials = 40;

% generación de la matrix de puntos iniciales
xstarts = 10000*rand(ntrials, n)' + 1;

% matrix para guardar los puntos solución
result = zeros(n,ntrials);

tStartPar = tic;        % timer para medir tiempo de ejecucion que toma

% ejecución en paralelo para el speedup ;)
% se roba 5 hilos para hacer el trabajo
p = parpool('local',5);

parfor i = 1:ntrials
    result(:, i) = metodo_penalizacion(f, eq_constrain, ineq_constraint_upper, ...
                ineq_constraint_lower, x, xstarts(:,i)', b1, b2, epsilon, ...
                interval, 100, verbose);
end
         
delete(gcp('nocreate'));

tEndPar = toc(tStartPar); % detiene el timer  

% busca de las soluciones cual da el mejor valor 
% para la función objetivo

f = -f; % la función objetivo vuelve a su forma original
curr_max_val = -Inf;
curr_max_idx = 0;

for i = 1:ntrials
     if  curr_max_val < double( subs(f, x, result(:, i)') ) 
         
         curr_max_val = double( subs(f, x, result(:, i)') ); 
         curr_max_idx = i;
     end
end

disp('El vector óptimo para maximizar ganancias dadas las restricciones es: ');
disp(result(:, curr_max_idx))
disp('El valor de la función objetivo es: ')
disp(curr_max_val);
disp('El valor del area ocupada con esta variable: ')
disp((((r + r./10).^2).*pi)*result(:, curr_max_idx));
disp('El area máxima posible es: ');
disp(At);


%% si quiere puede comparar con la versión Serial  
% y ver el speedup en su pc ;)

%tStartSer = tic; % timer para medir tiempo de ejecucion que toma en serial

%for i = 1:ntrials
%    result(:, i) = metodo_penalizacion(f, eq_constrain, ineq_constraint_upper, ...
%                ineq_constraint_lower, x, xstarts(:,i)', b1, b2, epsilon, ...
%                interval, 100, verbose);
%end

%tEndSer = toc(tStartSer);  % detiene el timer
%delete(gcp('nocreate'))

%disp('El speedup es de: ');
%disp( (tEndSer)/(tEndPar) );



