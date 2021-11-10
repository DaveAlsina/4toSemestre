
% vea que para este caso la ecuación (I*X) - (C*X) = (I - C)*(X)
% donde I y C son los vectores de ingresos y costos respectivamente 
% (Ingresos y costos por hectárea del tipo de cultivo) 
% unidades de dinero en millones de pesos

% I = [maiz, frijol, papa, albahaca, variables artificiales, ...]
% C = [maiz, frijol, papa, albahaca, variables artificiales, ...]

I = [18 10 5 21 0 0 0 0];
C = [5 4 2 4 0 0 0 0];

% Area total cultivable (en hectáreas)
At = 20;

% numero de cultivos 

n = 4;

% recuerde las restricciones sobre
% betas = [maiz, frijol, papa, albahaca]
betas = [1.2  1  1  1.2];  

% calculo de las restricciones para 
b = betas'.*(At/n);
b = [b; At];

% Matriz A:
%   
%     x1 x2 x3 x4 x5 x6 x7 x8
A = [ 1  0  0  0  1  0  0  0 ; ...
      0  1  0  0  0  1  0  0 ; ...   
      0  0  1  0  0  0  1  0 ; ...   
      0  0  0  1  0  0  0  1 ; ...
      1  1  1  1  0  0  0  0   ...
      ];

% maximizar en modo verbose
simplex(A, b, (I - C), false, true)  
  
  
  
  