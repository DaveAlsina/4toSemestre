%% audio ligeramente más agudo

Fs = 8000;          %frecuencia de muestreo
T = 1/Fs;           %periodo de la señal   
L = 80000;           %largo de la señal
time = (0:L-1)*T;   %tiempo


signal1 = 4.*sin(time*10)+ 2.*sin(time*5) + sin((2.5)*time);
plot(time, signal1);
sound(signal1, Fs);


%% audio ligeramente más grave

signal2 = 4.*sin(time./(1.5))+ 2.*sin(time./(2)) + sin(time*4);
plot(time, signal2)
sound(signal2, Fs);


%% disfrutar del audiomix
for i = 1:0.1:1000
    sound(signal1, Fs);
    sound(signal2, Fs);
end


%% procesar el audio

signal3 = signal1 + signal2; 

fsignal3 = fft(signal3); 
espec = abs(fsignal3/L);
espec = espec(1:(L/2)+1);
espec(2:end-1) = 2*espec(2:end-1);


sgtitle('Transformada de fourier')

subplot(2,1,1);
plot(time, signal3);
title('Señal de audio');
xlabel('tiempo');
ylabel('Amplitud (unidades arb.)');


subplot(2,1,2);
plot(espec);
title('Transformada de fourier de la señal de audio');
xlabel('frecuencia (Hz)');
ylabel('Amplitud (unidades arb.)');













