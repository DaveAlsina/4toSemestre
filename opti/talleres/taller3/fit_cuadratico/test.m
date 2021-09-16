f = @(x) ((x).^2)./10 - 2.*sin(x);             
interval = [-3 5];
i = 0.001;

%plot(linspace(-5,5,100), f(linspace(-5,5,100)))
%[1 2 3 4] * f([1 2 3 4])'
%%
quad_fit(f, [-1 4] ,i);


