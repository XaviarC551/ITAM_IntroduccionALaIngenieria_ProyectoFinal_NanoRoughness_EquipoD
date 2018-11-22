function [rz,peaks,peaksX,valleys,valleysX] = avrgProfile(data)
    z=mean(data);
    valleysX=[];
    peaksX=[];
    peaks=[];
    valleys=[];
    v=0;
    p=0;
    max=-2;
    min=-2;
    isPeak=false;
    
    i=1;
    
    while i<=length(data)
        if data(i)~=z
            break
        end
        i=i+1;
    end
    if i<=length(data)
        if data(i)>z
            max=data(i);
            maxX=i;
            isPeak=true;
        else
            min=data(i);
            isPeak=false;
            minX=i;
        end
        i=i+1;
    end
    
    while i<=length(data)
      delta=data(i)-z;
      if delta>=0
          if ~isPeak
              if max~=-2
                  v=v+1;
                  valleys(v)=min;
                  valleysX(v)=minX;
              end
              max=-1;
          end
          if data(i)>max
              max=data(i);
              maxX=i;
          end
          isPeak=true;
      elseif delta<=0
          if isPeak
              if min~=-2
                  p=p+1;
                  peaks(p)=max;
                  peaksX(p)=maxX;
              end
              
              min=256;
          end
          if data(i)<min
              min=data(i);
              minX=i;
          end
          isPeak=false;
      end
      i=i+1;
   end
   %{
   if max~=-2 && isPeak
       p=p+1;
       peaks(p)=max;
       peaksX(p)=maxX;
   end
   if min~=-2 && ~isPeak
       v=v+1;
       valleys(v)=min;
       valleysX(v)=minX;
   end
   %}
   rz=sum(peaks)+sum(valleys);
   if(p+v>0)
       rz=rz/(p+v);
   end
end