function showFunctions(data)
    text(1,250,char("Z="+num2str(mean(data))))
    text(1,230,char("Ra="+num2str(roughness(data))))
    text(1,210,char("Rq="+num2str(rootMeansSquare(data))))
    [max,min]=maxPeakDepth(data)
    text(1,190,char("Max="+num2str(max)))
    text(1,170,char("Min="+num2str(min)))
    text(1,150,char("Rt="+num2str(maxHeight(data))))
    text(1,130,char("Rz="+num2str(avrgProfile(data))))
    text(1,110,char("Rsk="+num2str(skewness(data))))
end

