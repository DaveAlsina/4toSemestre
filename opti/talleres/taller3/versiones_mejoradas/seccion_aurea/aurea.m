function [a, b] = aurea(init_a, init_b, I, fun_obj, verbose, graphical_mod)

    a = init_a;
    b = init_b;

    alpha = 0.618;

    lambda = a + (1 - alpha)*(b - a);
    mi = a + alpha*(b - a);
    iter = 0;


    while (b - a) > I
        iter = iter + 1;

        if verbose
            disp(['iteración: ' num2str(iter) ' ']);
            disp('a,    b,    lambda,    mi,    fun_obj(lambda),    fun_obj(mi)');
            disp([a, b, lambda, mi, fun_obj(lambda), fun_obj(mi)]);
            disp('-----------------------------------------------------------');
        end
            
        if fun_obj(lambda) > fun_obj(mi)
            a = lambda;
            lambda = mi;
            mi = a + alpha*(b - a);
            %fun_obj(mi);
        else 
            b = mi;
            mi = lambda;
            lambda = a + (1 - alpha)*(b - a);
            %fun_obj(lambda);
        end

        if graphical_mod
            xs = linspace(init_a, init_b, 10000);
            
            hold on 
            plot(xs, fun_obj(xs))
            grid on 
            scatter(a, fun_obj(a), 'bo')
            scatter(b, fun_obj(b), 'go')
            scatter(lambda, fun_obj(lambda), 'rx')
            scatter(mi, fun_obj(mi), 'kx')
            title('Algoritmo sección aurea');
            legend('función objetivo' , 'a', 'b', 'lambda', 'mu');
            hold off
            pause(1)
            
            clf;
        end 

    end




end