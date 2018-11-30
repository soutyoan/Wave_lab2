function plotErrorCompression()

    range = (0.01 : 0.01 : 0.99); 

    for i=1:99
        results(i) = errorCompression('Haar', 4, i/100.0); 
    end

    loglog(range, results); 
    title (strcat("Error compression.")); 
    xlabel("compression");
    ylabel("error"); 

end