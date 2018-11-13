function[Rq]=rootMeansSquare(data)
z = mean(data);
n = lenght(data);
sum = 0;
for i=1:n
    sum = (data(i)-z)^2;
end
Rq = sum/n;
end
