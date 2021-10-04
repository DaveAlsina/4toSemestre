%% version larga prueba

f = @(x) ((x).^2)./10 - 2.*sin(x);             
interval = [-1 4];
i = 0.001;


quad_fit(f, [-1 4], i);


%% version clase, prueba

f = @(x) ((x).^2)./10 - 2.*sin(x);             
interval = [-1 4];
i = 0.001;

quad_fit_version_clase(f, [-1 4], [0 1 4], i);


%% 
f = @(x) x.^3 - x.^2 -x;             
interval = [0 4];
i = 0.001;

quad_fit_version_clase(f, interval, [0 2 4], i, 1);