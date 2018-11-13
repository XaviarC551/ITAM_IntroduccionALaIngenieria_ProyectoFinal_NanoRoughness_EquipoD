function [rsk]=skewness(data)
rq=(squareAvrage(data)).^3;
zm=mean(data);
z=0;
n=length(data);
for i=1:n
z=z+(zi-zm).^3;
end
rsk=z/(n*rq);
end