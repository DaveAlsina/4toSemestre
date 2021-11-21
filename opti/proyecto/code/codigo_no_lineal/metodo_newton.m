function [xlast] = metodo_newton(f, var, epsilon, x0, interval, max_iters, verbose)

    %primera iter
     xprev = x0;
     df = diff(f);          %se deriva f con respecto a var
     ddf = diff(f, 2);      %se deriva f con respecto a var por 2da vez

     xlast = x0 - vpa(subs(df, var, x0))./ (vpa(subs(ddf, var, x0)) + epsilon);

     if verbose 
         hold on
             fplot(f, interval);
             scatter(vpa(xlast), subs(f, var, vpa(xlast)), 'go');
         hold off
         legend('función', 'Valor minimo');
         title('busqueda por método de Newton');
         pause(1);
     end 
     
     count = 1;
     
     while ( abs((xlast - xprev)) >= epsilon ) && (count < max_iters)
         xprev = xlast;
         xlast = xprev - vpa(subs(df, var, xprev))./ (vpa(subs(ddf, var, xprev)) + epsilon);
         
         if verbose
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

