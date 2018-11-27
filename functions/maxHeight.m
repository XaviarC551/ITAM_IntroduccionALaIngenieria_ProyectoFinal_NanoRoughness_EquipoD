% Esta función encuentra el valor máximo en de los datos proporcionados
function [rt]= maxHeight(data)
    [p, d]=maxPeakDepth(data);
    rt=p-d;
end
