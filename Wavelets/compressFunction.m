function compressFunction(points_x, points_y, family, dataset, taux_compression)
%%%%
% 
%
%%%%
    
    subplot(3,1,1);

    x = linspace(0,1,points_x);
    y1 = MakeSignal(dataset, points_x); 
    
    plot(x,y1); 
    
    title('Original function'); 
    
    subplot(3,1,2);
        
    qmf = MakeONFilter(family, points_y);

    wc = FWT_PO(y1, 0, qmf); 

    PlotWaveCoeff(abs(wc), 0, 0); 
    
    title('Wavelet coefficients');
    
    %%%%% Compression %%%%
    N_compression = round((1-taux_compression) * points_x);
    wcSorted = sort(abs(wc), 'descend');
    coeff_min = wcSorted(N_compression);
    indices = find(abs(wc) < coeff_min);
    wc(indices) = 0;
    
    yy = IWT_PO(wc, 0, qmf); 
    
    subplot(3,1,3);
    plot(x, yy); 
    title('Recontructed function'); 
    
    norm(yy - y1)

end