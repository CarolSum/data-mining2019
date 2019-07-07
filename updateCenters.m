
function centers = updateCenters(K)
    global typeArr;
    global picHueAvgArr;
    global picHueStdArr;
    centers = [];
    len = length(typeArr);
    for i=1:K
        tempHueAvg = [];
        tempHueStd = [];
        
        for j=1:len
            if typeArr(j) == i
                tempHueAvg = [tempHueAvg; picHueAvgArr(j)];
                tempHueStd = [tempHueStd; picHueStdArr(j)];
            end
        end
        
        centers = [centers; [mean(tempHueAvg), mean(tempHueStd)]];
    end
end
