% Esta funci�n encuentra el valor m�ximo en de los datos proporcionados
function [rt]= maxHeight(data)
    [p, d]=maxPeakDepth(data);
    rt=p-d;
end
