% Esta función obtiene la asimetría de los datos
function [rsk] = skewness(data)
    rsk=0;
    rq=rootMeansSquare(data)^3;
    zm=mean(data);
    z=0;
    n=length(data);
    for i=1:n
        z=z+(data(i)-zm)^3;
    end
    if n*rq~=0
        rsk=z/(n*rq);
end
