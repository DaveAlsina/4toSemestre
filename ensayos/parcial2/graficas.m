%% plot complex num

num = [(2 + 1.*1i), (2.5 + (3/2).*1i)];

plot(num, 'bo')
grid on
title('\emph{\textbf{Plano Complejo}}', 'Interpreter', 'latex')
xlabel('\textbf{Re}  \textit{(parte real)}','Interpreter','latex')
ylabel('\textbf{Im}  \textit{(parte imaginaria)}','Interpreter','latex')
legend('números complejos');


%% plot vector

[theta1,rho1] = cart2pol(real(num(1)), imag(num(1)));
[theta2,rho2] = cart2pol(real(num(2)), imag(num(2)));

theta = [theta1, theta2];
rho = [rho1, rho2];

polarplot(theta, rho, 'mo')
pax = gca;
pax.ThetaColor = 'blue';
pax.RColor = [0 .5 0];
grid on
rticklabels({'r = 0', 'r = 1','r = 2','r = 3'})
title('\textbf{\emph{Plano polar}}', 'Interpreter','latex')
legend('\textit{Version polar numeros complejos}', 'Interpreter', 'latex')




%% fuentes:


% usar latex para plots
% https://www.mathworks.com/matlabcentral/answers/21984-tex-latex-math-mode-symbols-in-legends-and-labels-in-matlab-figures

% plots planos polares
% https://www.mathworks.com/help/matlab/creating_plots/polar-axes-grid-lines-and-labels.html
% https://es.mathworks.com/help/matlab/ref/polarplot.html


