% Esta función obtiene la aspereza del conjunto de datos proporcionado,
% promediando las diferencias de todos los valores con la media
function [ra]= roughness(data)
    n=length(data);
    ra=0;
    z=mean(data);
    for i=1:n
       x=data(i);
       ra=ra+abs(x-z);
    end
    ra=ra/n;
end
