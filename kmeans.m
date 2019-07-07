function centers = kmeans(K)
    global typeArr;
    global picHueAvgArr;
    global picHueStdArr;
    len = length(picHueAvgArr);
    % 初始化获取K个簇的中心点
    centers = updateCenters(K);
    centersType = [1;2;3;4];
    
    % 执行下面迭代直到收敛
    % 计算每个点到簇中心点的距离，将该点所属的簇类更新为具有最短距离的簇中心点的类别
    % 根据更新后的簇类重新计算每个簇的中心点
    % 判断每个中心点是否稳定（与上一次位置相差不大）
    count = 0;
    
    while 1
        disp('count');
        disp(count);
        for i=1:len
            lastDist = Inf;
            belongCentersId = 0;
            for j=1:K
                distance = pdist([picHueAvgArr(i), picHueStdArr(i); centers(j, :)]);
                if distance < lastDist
                    lastDist = distance;
                    belongCentersId = j;
                end
            end
            
            if belongCentersId ~= 0
                typeArr(i) = centersType(belongCentersId);
            end
        end
        
        newCenters = updateCenters(K);
        isFinished = 1;
        for i=1:K
            if pdist([centers(i,:); newCenters(i, :)]) > 0.00001
                isFinished = 0;
            end
        end
        centers = newCenters;
        if isFinished == 1
            break
        end
        disp(centers);
        count=count+1;
    end
end