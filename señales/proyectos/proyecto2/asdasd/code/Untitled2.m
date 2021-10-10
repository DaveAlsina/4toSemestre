%main_path = 'C:\Users\dayan\OneDrive\Documentos\señales\Proyecto 2\parcial2_se-ales\code';
files = ["data\123_dave.wav", "data\sapo_dave.wav", "data\colores_dave.wav", ...
         "data\123_dayana.wav", "data\sapo_dayana.wav", "data\colores_dayana.wav", ...
         "data\sapo_esteban.wav", "data\sapo_edward.wav", ...
         "data\sapo_nelson.wav", "data\sapo_mariana.wav", ...
         "data\sapo_laura.wav", "data\sapo_ana.wav", "data\trabalenguas_cura_dayana.wav", ...
         "data\trabalenguas_cura_dave.wav", "data\trabalenguas_pablito_dayana.wav", ...
         "data\trabalenguas_pablito_dave.wav", "data\trabalenguas_cangrejo_dave.wav", ...
         "data\trabalenguas_cangrejo_dayana.wav"];
file_label  = [1 1 1 2 2 2 3 3 3 3 3 3 2 1 2 1 1 2];


%% calculo de todos los coeficientes
ks = [];    %Guarda los numeros de ventanas de cada mfcc para cada señal
allCoefs = [];  %Guarda todos los coeficientes de las mfcc para cada señal
                %(cada coeff del mfcc es guardado uno debajo del otro)


for file = 1:length(files)
    
    [signal, fs]  = audioread( files(file) );   %lee la muestra de audio
    signal = signal./max(signal);           %normaliza la muestra de audio
    
    [b, a] = butter(4, [20/(fs/2), 4000/(fs/2)]);
    filtered_signal = filter(b, a, signal);
    
    %calcula los coefs de la mfcc
    [coeffs, delta, deltaDelta, loc] = mfcc(filtered_signal, fs, 'NumCoeffs', 40);
    
    %obtienen la cantidad de ventanas de los coeffs size(coeffs)(1)
    coefsDim = size(coeffs);
    ks = [ks; coefsDim(1)];
    
    %guarda todos los coefs uno bajo el otro en una matriz
    allCoefs = [allCoefs; coeffs];
    %sound(filtered_signal, fs);
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


%% testeo
    
recObj = audiorecorder(16000, 24, 1);
fs = recObj.SampleRate; % Extrayendo la frecuencia de muestreo del objeto de grabación.
time =4;
recordblocking(recObj, time);
            
% extraer el audio
datosGrabacion = getaudiodata(recObj);
datosGrabacion = datosGrabacion ./ max(datosGrabacion);

%%
sound(datosGrabacion, fs);

%%
[b, a] = butter(4, [20/(fs/2), 4000/(fs/2)]);
filtered_signal = filter(b, a, datosGrabacion);
[coeffs, delta, deltaDelta, loc] = mfcc(filtered_signal, fs, 'NumCoeffs', 40);

%%
sound(filtered_signal, fs);


%% Regresion Logistica 
[P, ans1]=  Regresion_logistica(allCoefs,F,coeffs);

%predict = mnrval(B, coeffs, )
%%
%%%predict
max1 = 0;
size1 = size(ans1);
predict = zeros([size1(1) 1]);
indx_cate = 1;
prob =0;
for i = 1:size1(1)
    max1 = 0;
    for j = 1:2
        max1 = ans1(i,j);
        if max1 >= ans1(i,j+1)
            max1 = ans1(i,j);
            prob = ans1(i,j);
            cate = j; 
        elseif max1 <= ans1(i,j+1)
            max1 = ans1(i,j+1);
            prob = ans1(i,j+1);
            cate = j+1;
        end
      predict(i)=cate;
    end
end

labels2 = repelem([3], [size1(1)/2])';

%% Matriz de confución
grouporder = [1 2 3];
C = confusionmat(labels2,predict,'Order',grouporder);
confusionchart(C)





%% 
[signal, fs]  = audioread( "data/test/sapo_julieth.wav" );   %lee la muestra de audio
signal = signal./max(signal);           %normaliza la muestra de audio
sound(signal, fs);

[coeffs, delta, ~, loc] = mfcc(signal, fs, 'NumCoeffs', 40);
%[coeffs, delta, deltaDelta, loc] = mfcc(datosGrabacion, fs, 'NumCoeffs', 40);

%%
[b, a] = butter(4, [20/(fs/2), 4000/(fs/2)]);
filtered_signal = filter(b, a, signal);
[coeffs, delta, deltaDelta, loc] = mfcc(filtered_signal, fs, 'NumCoeffs', 40);

sound(signal, fs);
%% 
P =  Regresion_logistica(allCoefs,F,coeffs);
%%





