% Esta función obtiene la media de los datos proporcionados
function [z] = mean(data)
    n=length(data);
    z=0;
    for i=1:n
        z=z+data(i);
    end
    z=z/n;
end

