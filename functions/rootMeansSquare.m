% Esta funci�n obtiene la media cuadr�tica del conjunto de datos
% proporcionado
function[rq]=rootMeansSquare(data)
    z = mean(data);
    n = length(data);
    sum = 0;
    for i=1:n
        sum = sum+(data(i)-z)^2;
    end
    rq = sqrt(sum/n);
end
