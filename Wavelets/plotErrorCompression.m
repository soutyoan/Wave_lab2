function plotErrorCompression(points_x, points_y, family, dataset)

    range = (0.01 : 0.01 : 0.99); 

    for i=1:99
        results(i) = errorCompression(points_x, points_y, family, dataset, i/100.0); 
    end

    loglog(range, results); 
    title (strcat("Error compression. Curve Sampling = ", int2str(points_x))); 
    xlabel("compression");
    ylabel("error"); 

end