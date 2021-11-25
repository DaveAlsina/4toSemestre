%% Grafica de la transformación 1 (escala 1)

duration = 1;
r = 1;

B = linspace(0, duration, (duration)*100000);
R = r.*cos(B.*50);
G = r.*sin(B.*50);

map = [R' G' B'];


figure, scatter3(map(:,1), map(:,2), map(:,3), 4, map);
title('Mapeo de colores de la transformación I');
xlabel('R')
ylabel('G')
zlabel('B')


%% Gráfica de la transformación 2 (escala 2)

[R2, G2] = meshgrid(0:0.025:1);
B2 = (sin(R2) + cos(G2.*10).^2)./2;

CO(:,:,1) = R2;
CO(:,:,2) = G2;
CO(:,:,3) = B2;


s = surf(R2, G2, B2, CO)
title('Mapeo de colores de la transformación II');
xlabel('R')
ylabel('G')
zlabel('B')




