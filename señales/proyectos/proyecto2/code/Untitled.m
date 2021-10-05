recObj = audiorecorder;
fs = recObj.SampleRate; % Extrayendo la frecuencia de muestreo del objeto de grabación.
time =2;
recordblocking(recObj, time);
            
% extraer el audio
datosGrabacion = getaudiodata(recObj);
datosGrabacion = datosGrabacion ./ max(datosGrabacion);

%%

filename = '123.wav';
audiowrite(filename, datosGrabacion, fs);

%%

% probar el audio
sound(datosGrabacion,fs);

% procesar la información
n = length(datosGrabacion);
t = (0:n-1)/fs;

%graficar la señal de audio
plot(t, datosGrabacion);
xlim([0 time]);


%%
[coeffs, delta, deltaDelta, loc] = mfcc(datosGrabacion, fs, 'NumCoeffs', 30);
plot(coeffs)
title('MFCCs')

%%

F = repelem([1 2], [99]);

%%



%%
[B,dev,stats] = mnrfit(coeffs, F');





