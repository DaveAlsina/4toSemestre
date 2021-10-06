main_path = 'C:\Users\Dave\Documents\Univ\4toSemestre\señales\proyectos\proyecto2\code';
files = ["data\123_dave.wav", "data\sapo_dave.wav", "data\colores_dave.wav", ...
         "data\123_dayana.wav", "data\sapo_dayana.wav", "data\colores_dayana.wav", ...
          "data\sapo_esteban.wav", "data\sapo_edward.wav", ...
         "data\sapo_nelson.wav", "data\sapo_mariana.wav", ...
         "data\sapo_laura.wav", "data\sapo_ana.wav"];
file_label  = [1 1 1 2 2 2 3 3 3 3 3 3];


%% calculo de todos los coeficientes
ks = [];    %Guarda los numeros de ventanas de cada mfcc para cada señal
allCoefs = [];  %Guarda todos los coeficientes de las mfcc para cada señal
                %(cada coeff del mfcc es guardado uno debajo del otro)


for file = 1:length(files)
    
    [signal, fs]  = audioread( files(file) );   %lee la muestra de audio
    signal = signal./max(signal);           %normaliza la muestra de audio
    
    %calcula los coefs de la mfcc
    [coeffs, delta, deltaDelta, loc] = mfcc(signal, fs, 'NumCoeffs', 40);
    
    %obtienen la cantidad de ventanas de los coeffs size(coeffs)(1)
    coefsDim = size(coeffs);
    ks = [ks; coefsDim(1)];
    
    %guarda todos los coefs uno bajo el otro en una matriz
    allCoefs = [allCoefs; coeffs];
    sound(signal, fs);
    disp('ya paso:')
    disp(files(file))
end

%% creación de las etiquetas

F = [];

for labelnum = 1:length(ks)
    
    a = file_label(labelnum);
    b = ks(labelnum);
    labels = repelem([a], [b])';    
    F = [F; labels];
end

%% Entrenamiento

[B,dev,stats] = mnrfit(allCoefs, F);


%% testeo
    
recObj = audiorecorder(16000, 8, 1);
fs = recObj.SampleRate; % Extrayendo la frecuencia de muestreo del objeto de grabación.
time =2;
recordblocking(recObj, time);
            
% extraer el audio
datosGrabacion = getaudiodata(recObj);
datosGrabacion = datosGrabacion ./ max(datosGrabacion);

%%
sound(datosGrabacion, fs);
%% 
[signal, fs]  = audioread( "data/colores_dayana.wav" );   %lee la muestra de audio
signal = signal./max(signal);           %normaliza la muestra de audio

[coeffs, delta, deltaDelta, loc] = mfcc(signal, fs, 'NumCoeffs', 40);
%[coeffs, delta, deltaDelta, loc] = mfcc(datosGrabacion, fs, 'NumCoeffs', 40);
ans1 = mnrval(B, coeffs);

sum(ans1(:,1))
sum(ans1(:,2))
sum(ans1(:,3))




