recObj = audiorecorder(16000, 24, 1);

% Extrayendo la frecuencia de muestreo del objeto de grabación.
fs = recObj.SampleRate;             
time =1;
recordblocking(recObj, time);
            
% extraer el audio
datosGrabacion = getaudiodata(recObj);
%%

% Don Trombón y don Trajín tienen un trueque para truquear la orquesta de 
% doña Troila.
%  
%  

sound(datosGrabacion, fs)



%% sapo sapito sapon
filename = 'noise4.wav';
audiowrite(filename, datosGrabacion, fs);