function [rz] = avrg_profile(data, p, v)
cl    sorted=sort(data);
    s=0;
    l=length(sorted)
    for i=0:p-1
       s=s+sorted(l-i);
    end
    for i=1:v
        s=s+sorted(i);
    end
    rz=s/(p+v);
end