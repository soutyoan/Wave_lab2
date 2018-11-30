function plotErrorCompression()

    range = (0.01 : 0.01 : 0.99); 
    family = 'Haar'; % choice of wavelet basis
    v_m = 4; % vanishing moment
    for i=1:99
        results(i) = errorCompression(family, v_m, i/100.0); 
    end
    
    loglog(range, results); 
    title (strcat(strcat("Error compression.", family), int2str(v_m))); 
    xlabel("compression");
    ylabel("error"); 
    name_fig = strcat(strcat("error_comp_", family), int2str(v_m));
    saveas(gcf, strcat(name_fig, '.png'));

end