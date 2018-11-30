subplot(1,3,1);
colormap('gray');
img_name = 'Lenna'; % choice of image from ReadImage database
signal2d = ReadImage(img_name)/255;

linear = true; % choice to use linear or non linear approximation


size_image = size(signal2d);
n = size_image(1);
colormap('gray');
imshow(signal2d);
axis off;
title('Original function');

subplot(1,3,2);

taux_compression = 0.95; % choice of compression rate (must be in [0, 1])

fam_name = 'Haar'; % choice of orthogonal wavelet family
v_m = 4; % choice of vanishing moment
qmf = MakeONFilter(fam_name, v_m);
coarse_scale = 2; % choice of coarse scale for FWT2_PO and IFWT2_PO
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
    N_coeff = size_wc1 * size_wc2; 
    wc(N_compression:N_coeff) = 0;
else
    % Non linear compression
    wc_1d = wc(:);
    wcSorted = sort(abs(wc_1d), 'descend');
    coeff_min = wcSorted(N_compression);
    indices = find(abs(wc) < coeff_min);
    wc(indices) = 0;
end

size(wc)
size(find(abs(wc) == 0))

yy = IWT2_PO(wc, coarse_scale, qmf);

subplot(1,3,3);
imshow(yy);
axis off;
title('Reconstructed function');

name_fig=strcat(strcat("comp_", img_name), strcat(fam_name, int2str(100*taux_compression)));
saveas(gcf, strcat(name_fig, '.png'));
