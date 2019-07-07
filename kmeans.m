function centers = kmeans(K)
    global typeArr;
    global picHueAvgArr;
    global picHueStdArr;
    len = length(picHueAvgArr);
    % ��ʼ����ȡK���ص����ĵ�
    centers = updateCenters(K);
    centersType = [1;2;3;4];
    
    % ִ���������ֱ������
    % ����ÿ���㵽�����ĵ�ľ��룬���õ������Ĵ������Ϊ������̾���Ĵ����ĵ�����
    % ���ݸ��º�Ĵ������¼���ÿ���ص����ĵ�
    % �ж�ÿ�����ĵ��Ƿ��ȶ�������һ��λ������
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