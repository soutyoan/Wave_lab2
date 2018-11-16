function error = compressFunction(points_x, points_y, family, dataset, taux_compression)
%%%%
% 
%
%%%%

    x = linspace(0,1,points_x);
    y1 = MakeSignal(dataset, points_x); 
        
    qmf = MakeONFilter(family, points_y);

    wc = FWT_PO(y1, 0, qmf); 
    
    %%%%% Compression %%%%
    N_compression = round((1-taux_compression) * points_x);
    wcSorted = sort(abs(wc), 'descend');
    coeff_min = wcSorted(N_compression);
    indices = find(abs(wc) < coeff_min);
    wc(indices) = 0;
    
    yy = IWT_PO(wc, 0, qmf); 
    
    error = norm(yy - y1)

end