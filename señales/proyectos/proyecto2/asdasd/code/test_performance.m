%% toma los nombres de los archivos de testeo

main_path = "data\test\";
files = ["p1.wav" "p2.wav" "p3.wav" "p4.wav" "p5.wav" ...
         "p6.wav" "p7.wav" "p8.wav" "dave1.wav" "dave2.wav" ...
         "dave3.wav" "dave4.wav" "dave5.wav" "dave6.wav" "dave7.wav" ...
         "dave8.wav" "dayana1.wav" "dayana2.wav" "dayana3.wav" ... 
         "dayana4.wav" "dayana5.wav" "dayana6.wav" "dayana7.wav" ...
         "dayana8.wav"];
     
ytest = [3 3 3 3 3 3 3 3 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2];


%% carga la matriz de betas y hace las predicciones 

load 'betas.mat'

predictions = [];


for i = 1:length(files)
    path = strcat(main_path, files(i));
    [signal, fs]  = audioread( path ); 
    disp(path);
    [prob, classification] = regresion_logistica_test(betas, signal, fs);
    predictions = [predictions; classification];
end

%% matriz de confusion






