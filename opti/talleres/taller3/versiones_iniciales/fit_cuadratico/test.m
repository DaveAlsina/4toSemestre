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