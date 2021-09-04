%A = [1 2 1 0; 0 1 0 1];
%c = [1 1 0 0];
%b = [4 1]';

%% pruebas caso 1 optimos finitos

%% subcaso 1.1
A = [1 1 1 0 0; 1 1 0 1 0; 1 -1 0 0 -1];
c = [3 1 0 0 0];
b = [2 3 1]';

%minimizar
simplex(A, b, c, true, true)

%% subcaso 1.2
A = [1 -1];
c = [3 0];
b = [1]';

%minimizar
simplex(A, b, c, true, true)

%% subcaso 1.3

A = [1 -1 0; 5 0 -1];
c = [1 0 0];
b = [25 30]';

%minimizar
simplex(A, b, c, false, true)



%% pruebas caso 2, optimos no finitos



%% pruebas caso 4, solución no factible 


%% subcaso 4.1
A = [-5 1 1 0 0; 5 1 0 -1 0; 2 1 0 0 1];
c = [-1 1 0 0 0];
b = [3 10 4]';

%maximizar
simplex(A, b, c, false, true)



