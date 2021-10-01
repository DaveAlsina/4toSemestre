function [xlast] = metodo_newton(f, var, epsilon, x0, interval, verbose)

    %primera iter
     xprev = x0;
     df = diff(f);
     ddf = diff(f, 2);

     xlast = x0 - vpa(subs(df, var, x0))./ vpa(subs(ddf, var, x0));

     if verbose 
         hold on
             fplot(f, interval);
             scatter(vpa(xlast), subs(f, var, vpa(xlast)), 'go');
         hold off
         legend('función', 'Valor minimo');
         title('busqueda por método de Newton');
         pause(1);
     end 
     
     while abs((xlast - xprev)) >= epsilon
         xprev = xlast;
         xlast = xprev - vpa(subs(df, var, xprev))./ vpa(subs(ddf, var, xprev));
         
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
     end
     
     xlast = vpa(xlast);
end

