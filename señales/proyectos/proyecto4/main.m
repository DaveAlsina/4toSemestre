%% Selección de la imagen para procesar

image1 = imread('diomedes.jpg');
imageGpuR = gpuArray(image1(:,:,1));
imageGpuG = gpuArray(image1(:,:,2));
imageGpuB = gpuArray(image1(:,:,3));

imshow(image1)


%% Transformación 1

timer2 = tic;
imageTransform2 = image1;

[newImageR, newImageG] = arrayfun(@transformation1, imageGpuB);
newImageR = gather( newImageR ); % Fetch the data back from the GPU
newImageG = gather( newImageG ); % Fetch the data back from the GPU
 
 
imageTransform2(:,:,1) = newImageR;
imageTransform2(:,:,2) = newImageG;
figure, imshow(imageTransform2)

endTime2 = toc(timer2);

%% Transformación 2

timer1 = tic;
imageTransform1 = image1;

newImage = arrayfun(@transformation2, imageGpuR, imageGpuG);
newImage = gather( newImage ); % Fetch the data back from the GPU
imageTransform1(:,:,3) = newImage;
figure, imshow(imageTransform1)

endTime1 = toc(timer1);
