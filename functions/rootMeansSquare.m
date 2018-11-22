function[Rq]=rootMeansSquare(data)
z = mean(data);
n = length(data);
sum = 0;
for i=1:n
    sum = sum+(data(i)-z)^2;
end
Rq = sqrt(sum/n);
end
