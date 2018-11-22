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
