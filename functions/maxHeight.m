function [rt]= maxHeight(data)
[p, d]=maxPeakDepth(data);
rt=p-d;
end
