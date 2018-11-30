function error = compressFunction(family, vanishing_moment, taux_compression)
%%%%
% family : orthogonal wavelet family
% vanishing_moment : vanishing moment 
% taux_compression : compression rate

% computation of error rate
%%%%

    signal2d = ReadImage('Lenna')/255;

    linear = false;

    size_image = size(signal2d);
    n = size_image(1);

    qmf = MakeONFilter(family, vanishing_moment);
    coarse_scale = 2;
    wc = FWT2_PO(signal2d, coarse_scale, qmf);

    [size_wc1, size_wc2]=size(wc);

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
    
    error = norm(yy - signal2d); 

end