% Esta funci�n encuentra los picos y valles del conjunto de datos y obtiene
% el promedio de estos
function [rz,peaks,peaksX,valleys,valleysX] = avrgProfile(data)
    % guardar la media en una variable local
    z=mean(data);
    % inicializar las listas de �ndices de los picos y valles
    valleysX=[];
    peaksX=[];
    % inicializar las listas de los valores de los picos y valles
    peaks=[];
    valleys=[];
    % variable para guardar el n�mero de valles
    v=0;
    % variable para guardar el n�mero de picos
    p=0;
    % variable cuyo valor es aumentado hasta llegar al pico
    max=-2;
    % variable cuyo valor es decrementado hasta llegar al valle
    min=-2;
    % variable para indicar si la secci�n actual est� sobre o debajo
    % de la media
    isPeak=false;
    % variable del �ndice a procesarse
    i=1;
    
    %--------------omitir los valores inciales en la media-----------------
    while i<=length(data)
        if data(i)~=z
            break
        end
        i=i+1;
    end
    
    %----------inicializar isPeak en el lado correcto de la media----------
    if i<=length(data)
        if data(i)>z
            max=0;
            maxX=i;
            isPeak=true;
        else
            min=255;
            isPeak=false;
            minX=i;
        end
        i=i+1;
    end
    
    %-----iterar por el resto de los datos y guardar los picos y valles----
    while i<=length(data)
      delta=data(i)-z;
      if delta>=0
          if ~isPeak
              % rechazar el pico si no se ha procesado un valor
              % debajo de la media
              if max~=-2
                  v=v+1;
                  % add the peak to the peak list
                  valleys(v)=min;
                  % add the valley index to the peak index list
                  valleysX(v)=minX;
              end
              % inicializar el valor m�nimo del valle (considerando que 0
              % es el valor m�s peque�o para un pixel)
              max=-1;
          end
          % encontrar el valor del pico
          if data(i)>max
              max=data(i);
              maxX=i;
          end
          isPeak=true;
      elseif delta<=0
          if isPeak
              % rechazar el valle si no se ha procesado un valor
              % sobre de la media
              if min~=-2
                  p=p+1;
                  % add the peak to the peak list
                  peaks(p)=max;
                  % add the peak index to the peak index list
                  peaksX(p)=maxX;
              end
              % inicializar el valor m�nimo del valle (considerando que 0
              % es el valor m�s grande para un pixel)
              min=256;
          end
          % encontrar el valor del valle
          if data(i)<min
              min=data(i);
              minX=i;
          end
          isPeak=false;
      end
      i=i+1;
   end
    
   % calcular la suma de los valores de los picos y valles
   rz=sum(peaks)+sum(valleys);
   if(p+v>0)
       % dividir la suma entre el n�mero de picos y valles
       rz=rz/(p+v);
   end
end
