function [maxPeak,minValley] = extremosPeakValley(data)
max = data(1);
min = data(1);

for i=2:length(data)
    if data(i)>max
        max = data(i);
    end
    if data(i)<min
        min = data(i);
    end
end
maxPeak = max;
minValley = min;
end

