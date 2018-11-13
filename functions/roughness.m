function [ra]= roughness(data)
n=length(data);
ra=0;
for i=1:n
   x=data(i);
   ra=ra+(x-mean(data));
end
ra=abs(ra/n);
end
