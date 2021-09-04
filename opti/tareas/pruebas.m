%%%%%%%%%%%%
%% prueba 1, Casos óptimos finitos
%%%%%%%%%%%%

%% ejemplo 1

A = [1 2 3 1 0 0; 2 1 -1 0 1 0; -1 3 0 0 0 1];
c = [-1 2 -1 0 0 0];
b = [12 6 9]';

%minimizar en modo verbose
simplex(A, b, c, true, true)


%% ejemplo 2

A = [1 3 0 1 1 0 0; 2 1 0 0 0 1 0; 0 1 4 1 0 0 1];
c = [2 4 1 1 0 0 0];
b = [4 3 3]';

%maximizar en modo verbose
simplex(A, b, c, false, true)


%% ejemplo 3

A = [2 1 1 1 0; 0 2 -1 0 5];
c = [-1 -2 1 0 0];
b = [6 3]'; 

%minimizar en modo verbose
simplex(A, b, c, true, true)


%% ejemplo 4, ejercicio en clase 

A = [1 2  1 0; 0 1 0 1];
c = [1 1 0 0];
b = [4 1]';

%maximizar en modo verbose
simplex(A, b, c, false, true)


%%%%%%%%%%%%
%% prueba 2, Casos óptimos no finitos
%%%%%%%%%%%%


%% ejemplo 1

A = [-5 1 1 0 0; 5 1 0 -1 0; 2 1 0 0 1];
c = [-1 1 0 0 0];
b = [3 10 4]';

%minimizar en modo verbose
simplex(A, b, c, true, true)

%% ejemplo 2

A = [-2 -9 1 0 0; 5 -2 0 -1 0; 2 3 0 0 -1];
c = [7 -10 0 0 0];
b = [5 9 2]';

%maximizar en modo verbose
simplex(A, b, c, false, true)


%% ejemplo 3, ejercicio en clase 

A = [1 -2 1 0; -1 1 0 1];
c = [-1 -3 0 0];
b = [4 3]';


%minimizar en modo verbose
simplex(A, b, c, true, true)
 

%%%%%%%%%%%%
%% prueba 3, Casos de múltiples soluciones (optimos alternos)
%%%%%%%%%%%%

%% ejemplo 1
% -> transcribir problema aquí

A = [1 2 1 0; 1 1 0 1];
c = [2 4 0 0];
b = [4 5]';

%maximizar en modo verbose
simplex(A, b , c , false , true)


%% ejemplo 2
% -> transcribir problema aquí

A = [3 5 1 0 0 ; 8 -12 0 1 0; 7 3 0 0 1];
c = [14 6 0 0 0];
b = [15 12 14]';

%maximizar en modo verbose
simplex(A , b,c , false ,true)


%% ejemplo 3, ejercicio en clase

A = [1 2 1 0; -1 1 0 1];
c = [-2 -4 0 0];
b = [4 1]';

%minimizar en modo verbose
simplex(A, b, c, true, true)


%%%%%%%%%%%%
%% prueba 4, Casos de soluciones no factibles
%%%%%%%%%%%%


%% ejemplo 1

A = [-5 1 1 0 0; 5 1 0 -1 0; 2 1 0 0 1];
c = [5 1 0 0 0];
b = [3 10 4]';

%minimizar en modo verbose
simplex(A, b, c, true, true)

%% ejemplo 2

A = [1 -2 1 0; 1 -2 0 -1];
c = [1 1 0 0];
b = [4 40]';

%minimizar en modo verbose
simplex(A, b, c, true, true)    


%% ejemplo 3, ejercicio en clase
% -> transcribir problema aquí

A = [6 5 1 0 0 ; 20 20 0 1 0 ; 0 1 0 0 -1];
c = [1 1 0 0 0];
b = [300 100 30]';

%maximizar en modo verbose
simplex(A, b , c , false , true)






