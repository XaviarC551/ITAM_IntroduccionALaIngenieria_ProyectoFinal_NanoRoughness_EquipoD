function [rz] = avrgProfile(data)
    z=mean(data)
    peaks=[]
    valleys=[]
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
            isPeak=true;
        else
            min=data(i);
            isPeak=false;
        end
        i=i+1;
    end
    while i<=length(data)
      delta=data(i)-z;
      if delta>0
          if ~isPeak
              v=v+1;
              valleys(v)=min;
              max=-1;
          end
          if data(i)>max
              max=data(i);
          end
          isPeak=true;
      elseif delta<0
          if isPeak
              p=p+1;
              peaks(p)=max;
              min=256;
          end
          if data(i)<min
              min=data(i);
          end
          isPeak=false;
      end
      i=i+1;
   end
   if max~=-2 && isPeak
       p=p+1;
       peaks(p)=max;
   end
   if min~=-2 && ~isPeak
       v=v+1;
       valleys(v)=min;
   end
   rz=sum(peaks)+sum(valleys);
   if(p+v>0)
       rz=rz/(p+v);
   end
end