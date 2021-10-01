function [xlast] = metodo_newton(f, var, epsilon, x0, interval, verbose)

    %primera iter
     count = 0;
     xprev = x0;
     df = diff(f);          %obtengo la primera derivada de f
     ddf = diff(f, 2);      %obtengo la segunda derivada de f

     %% realizo la primera iteración del algoritmo
     xlast = x0 - vpa(subs(df, var, x0))./ vpa(subs(ddf, var, x0));
 
     % display de valores del algoritmo 
     if verbose == 1

         disp([' Iteración no. ' num2str(count) '. ']);
         disp([' el valor de previo de x es: ' num2str(x0) ' ']);
         disp([' El numerador df(xprev) es: ' num2str( double(subs(df, var, x0)) ) ' ']);
         disp([' El denominador ddf(xprev) es: ' num2str( double(subs(ddf, var, x0)) ) ' ']);
         disp([' el valor de nuevo de x es: ' num2str( double(xlast) ) ' ']);
         disp([' El error es de: ' num2str( double(abs((xlast - x0))) ) ' ']);
         disp('---------------------------------------------------------');
         
     %muestro una animación para que se vea el progreso del algoritmo
     %esto es solo si el modo verboso se setea a nivel de verbosidad 2    
     elseif verbose == 2
         hold on
         fplot(f, interval);
         scatter(vpa(xlast), subs(f, var, vpa(xlast)), 'go');
         hold off
         legend('función', 'Valor minimo');
         title('busqueda por método de Newton');
         pause(1); 
     
     %se muestra una animación y display de valores del algoritmo    
     elseif verbose == 3
         
         disp([' Iteración no. ' num2str(count) ' ']);
         disp([' el valor de previo de x es: ' num2str(x0) ' ']);
         disp([' El numerador df(xprev) es: ' num2str( double(subs(df, var, x0)) ) ' ']);
         disp([' El denominador ddf(xprev) es: ' num2str( double(subs(ddf, var, x0))) ' ']);
         disp([' el valor de nuevo de x es: ' num2str(double(xlast)) ' ']);
         disp([' El error es de: ' num2str( double(abs((xlast - x0))) ) ' ']);
         disp('---------------------------------------------------------');
         
         hold on
         fplot(f, interval);
         scatter(vpa(xlast), subs(f, var, vpa(xlast)), 'go');
         hold off
         legend('función', 'Valor minimo');
         title('busqueda por método de Newton');
         pause(1); 
     end
     count = count + 1;
     
     
     %% Continuo iterando
     
     while abs((xlast - xprev)) >= epsilon
         xprev = xlast;
         xlast = xprev - vpa(subs(df, var, xprev))./ vpa(subs(ddf, var, xprev));
         
         % display de valores del algoritmo
         if verbose == 1

             disp([' Iteración no. ' num2str(count) '. ']);
             disp([' el valor de previo de x es: ' num2str( double(xprev) ) ' ']);
             disp([' El numerador df(xprev) es: ' num2str( double(subs(df, var, xprev))) ' ']);
             disp([' El denominador ddf(xprev) es: ' num2str( double(subs(ddf, var, xprev))) ' ']);
             disp([' el valor de nuevo de x es: ' num2str(double(xlast)) ' ']);
             disp([' El error es de: ' num2str( double(abs((xlast - xprev))) ) ' ']);
             disp('---------------------------------------------------------');
             
         %muestro una animación para que se vea el progreso del algoritmo
         %esto es solo si el modo verboso se setea a nivel de verbosidad 2    
         elseif verbose == 2
             
             clf;
             hold on
             fplot(f, interval);
             scatter(vpa(xlast), subs(f, var, vpa(xlast)), 'go');
             hold off
             legend('función', 'Valor minimo');
             title('busqueda por método de Newton');
             pause(1); 

         %se muestra una animación y display de valores del algoritmo    
         elseif verbose == 3

             disp([' Iteración no. ' num2str(count) '. ']);
             disp([' el valor de previo de x es: ' num2str(double(xprev)) ' ']);
             disp([' El numerador df(xprev) es: ' num2str( double(subs(df, var, xprev))) ' ']);
             disp([' El denominador ddf(xprev) es: ' num2str( double(subs(ddf, var, xprev))) ' ']);
             disp([' el valor de nuevo de x es: ' num2str(double(xlast)) ' ']);
             disp([' El error es de: ' num2str( double(abs((xlast - xprev))) ) ' ']);
             disp('---------------------------------------------------------');
             
             clf;
             hold on
             fplot(f, interval);
             scatter(vpa(xlast), subs(f, var, vpa(xlast)), 'go');
             hold off
             legend('función', 'Valor minimo');
             title('busqueda por método de Newton');
             pause(1); 
         end
         
         count = count + 1;
     end
     
     xlast = vpa(xlast);
end

