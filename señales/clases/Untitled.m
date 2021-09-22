recObj = audiorecorder;
Fs = 96000;
nBits = 16;
nChannels = 1;
Id = -1;            %mic por defecto del computador

recObj = audiorecorder(Fs, nBits, nChannels, Id);

disp('Start Speaking')
recordblocking(recObj, 1);              %grabar un segundo
disp('End of recording');

x = getaudiodata(recObj);
N = length(x);

t = (0:N-1)/Fs;

Fx = fft(x);
f = 0:Fs/N:(Fs/N)*(N-1);

figure, plot(t,x);
figure, stem(f, abs(Fx));


%duplicar el tamaño de la señal
x2 = [x; zeros(N,1)]
N2 = length(x2);

t = (0:N2-1)/Fs;

Fx = fft(x2);
f = 0:Fs/N:(Fs/N)*(N-1);


