function ex1()

    number_curves = 5; 
    legends = {}

    for k=1:number_curves
        wave = MakeWavelet(4, k, 'Haar', 5, 'Mother'); 
        plot(wave); 
        legends{k} = strcat("k = ", int2str(k)); 
        hold 'on'
    end

    legend(legends); 

    hold 'off'

end