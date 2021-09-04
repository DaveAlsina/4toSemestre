%A = [1 2 1 0; 0 1 0 1];
%c = [1 1 0 0];
%b = [4 1]';

%% pruebas caso 1 optimos finitos

%% subcaso 1.1
%A = [1 1 1 0 0; 1 1 0 1 0; 1 -1 0 0 -1];
%c = [3 1 0 0 0];
%b = [2 3 1]';

%minimizar
%simplex(A, b, c, true, true)

%% subcaso 1.2
%A = [1 -1];
%c = [3 0];
%b = [1]';

%minimizar
%simplex(A, b, c, true, true)

%% subcaso 1.3

%A = [1 -1 0; 5 0 -1];
%c = [1 0 0];
%b = [25 30]';

%minimizar
%simplex(A, b, c, false, true)



%% pruebas caso 2, optimos no finitos



%% pruebas caso 4, solución no factible 


%% subcaso 4.1
%A = [-5 1 1 0 0; 5 1 0 -1 0; 2 1 0 0 1];
%c = [-1 1 0 0 0];
%b = [3 10 4]';

%maximizar

%A = [1 3 0 1 1 0 0; 2 1 0 0 0 1 0; 0 1 4 1 0 0 1];
%c = [2 4 1 1 0 0 0];
%b = [4 3 3]';


%A = [2 1 1 1 0; 0 2 -1 0 1];
%c = [-1 -2 1 0 0];
%b = [6 3]';

% Solución normal.

%A = [1 2 1 0; 0 1 0 1];
%c = [1 1 0 0];
%b = [4,1]';

%A = [6 10 1 0; 2 1 0 1];
%c = [2000 3000 0 0];
%b = [100,20]';

%A = [12 20 1 0; 4 2 0 1];
%c = [4000 6000 0 0];
%b = [100,20]';

% Ejemplo de clase, múltiples soluciones.

A = [1 2 1 0; -1 1 0 1];
c = [-2 -4 0 0];
b = [4,1]';


% No tiene solución

%A = [-2 -9 1 0 0; 5 -2 0 -1 0; 2 3 0 0 -1];
%c = [-7 10 0 0 0];
%b = [5 9 2]';

%A = [1 -2 1 0; -1 1 0 1];
%c = [-1 -3 0 0]
%b = [4 3]'
simplex(A, b, c, true, false, false)



