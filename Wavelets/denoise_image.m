img_name='Lenna'; % choice of image
for i=1:10
    subplot(1,2,1);
    signal2d = ReadImage(img_name) / 255;
    [n, n2] = size(signal2d);
    sigma=0.01*i;
    signal2d = signal2d + GWN2(n, sigma);
    imshow(signal2d);
    title(strcat('Noisy image witth Gaussian White Noise, \sigma =  ', num2str(sigma))); 


    subplot(1,2,2);
    L=4;
    fam='Symmlet';
    qmf=MakeONFilter(fam, L);
    imshow(ThreshWave2(signal2d, 'qmf', qmf));
    title(strcat(strcat('Filtered image with  ', fam), strcat(',L=', int2str(L))));
    name_fig = strcat('denoise_lenna', int2str(i));
    saveas(gcf, strcat(name_fig, '.png'));
    
end
