subplot(1,3,1);
colormap('gray');
signal2d = ReadImage('Lenna')/255;

linear = false;


size_image = size(signal2d);
n = size_image(1);
colormap('gray');
imshow(signal2d);
axis off;
title('Original function');

subplot(1,3,2);

taux_compression = 0.95;

qmf = MakeONFilter('Daubechies', 4);
coarse_scale = 2;
wc = FWT2_PO(signal2d, coarse_scale, qmf);

[size_wc1, size_wc2]=size(wc);

wc_plotted=wc;
wc_plotted(1:size_wc1/4, 1:size_wc2/4)=0;

imshow(sqrt(abs(wc_plotted)));
axis off;
title('Wavelet coefficients');

N_compression = round((1-taux_compression) * size_wc1 * size_wc2);

if linear==true
    % Linear compression
    N_coeff = size(wc);
    wc(N_compression:N_coeff) = 0;
else
    % Non linear compression
    wc_1d = wc(:);
    wcSorted = sort(abs(wc_1d), 'descend');
    coeff_min = wcSorted(N_compression);
    indices = find(abs(wc) < coeff_min);
    wc(indices) = 0;
end

yy = IWT2_PO(wc, coarse_scale, qmf);

subplot(1,3,3);
imshow(yy);
axis off;
title('Recontructed function');
