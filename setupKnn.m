
function setupKnn(K)
    sprintPicsPath = '/Users/lijiehong/Desktop/dm/训练+测试/春天/';
    summerPicsPath = '/Users/lijiehong/Desktop/dm/训练+测试/夏天/';
    automnPicsPath = '/Users/lijiehong/Desktop/dm/训练+测试/秋天/';
    winterPicsPath = '/Users/lijiehong/Desktop/dm/训练+测试/冬天/';
    % 单独获取训练集中每一种图片的色调数据
    sprintImgHue = getDirImagesHue(sprintPicsPath);
    summerImgHue = getDirImagesHue(summerPicsPath);
    autumnImgHue = getDirImagesHue(automnPicsPath);
    winterImgHue = getDirImagesHue(winterPicsPath);
    disp(sprintImgHue);

    sprintTestPicsPath = '/Users/lijiehong/Desktop/dm/训练+测试/测试集/春天/';
    summerTestPicsPath = '/Users/lijiehong/Desktop/dm/训练+测试/测试集/夏天/';
    autumnTestPicsPath = '/Users/lijiehong/Desktop/dm/训练+测试/测试集/秋天/';
    winterTestPicsPath = '/Users/lijiehong/Desktop/dm/训练+测试/测试集/冬天/';

    % 获取测试集图片色调数据
    sprintTestPics = getDirImagesHue(sprintTestPicsPath);
    summerTestPics = getDirImagesHue(summerTestPicsPath);
    autumnTestPics = getDirImagesHue(autumnTestPicsPath);
    winterTestPics = getDirImagesHue(winterTestPicsPath);

    global trainData;
    trainData(:,:,1) = sprintImgHue;
    trainData(:,:,2) = summerImgHue;
    trainData(:,:,3) = autumnImgHue;
    trainData(:,:,4) = winterImgHue;
    trainDim=size(trainData);

    disp(trainDim);
    len = length(sprintImgHue);
    knn(len, K, sprintTestPics, 1);
    knn(len, K, summerTestPics, 2);
    knn(len, K, autumnTestPics, 3);
    knn(len, K, winterTestPics, 4);
end

function result = getDirImagesHue(picsPath)
    result = [];
    imgPathList = dir([picsPath '*.jpg']);
    if ~isempty(imgPathList)
        for i = 1:length(imgPathList)
            image_name = imgPathList(i).name;
            image =  imread(strcat(picsPath,image_name));
            hsva = rgb2hsv(image);
            h = hsva(:,:,1);
            result = [result;[mean(h, 'all'), std(h, 1, 'all')]];
        end
    end
end

function knn(trainLen, K, testPics, correctType)
    global trainData;
    correctCount = 0;
    fprintf('total test cases: %d\n', length(testPics));
    for i=1:length(testPics)
        testData=testPics(i,:);
        testData_rep=repmat(testData,trainLen,1);
        
        % 计算欧式距离
        diff1=(trainData(:,:,1)-testData_rep).^2;
        diff2=(trainData(:,:,2)-testData_rep).^2;
        diff3=(trainData(:,:,3)-testData_rep).^2;
        diff4=(trainData(:,:,4)-testData_rep).^2;
        
        distance1=(diff1(:,1)+diff1(:,2)).^0.5;
        distance2=(diff2(:,1)+diff2(:,2)).^0.5;
        distance3=(diff3(:,1)+diff3(:,2)).^0.5;
        distance4=(diff4(:,1)+diff4(:,2)).^0.5;
        
        %将四个一维数组合成一个二维矩阵
        temp=[distance1 distance2 distance3 distance4];
        distance=reshape(temp,1,4*trainLen);
        distance_sort=sort(distance);
        
        num1=0;
        num2=0;
        num3=0;
        num4=0;
        sum=0;
        for j=1:K
            for h=1:trainLen
                if distance_sort(j)==distance1(h)
                    num1=num1+1;
                    break;
                end
                if distance_sort(j)==distance2(h)
                    num2=num2+1;
                    break;
                end
                if distance_sort(j)==distance3(h)
                    num3=num3+1;
                    break;
                end
                if distance_sort(j)==distance4(h)
                    num4=num4+1;
                    break;
                end
            end
            sum=num1+num2+num3+num4;
            if sum>=K
                break;
            end
        end
        class=[num1 num2 num3 num4];
        classname=find(class(1,:)==max(class));
        fprintf('regnized type is %d and correct type is: %d\n', classname(1), correctType);
        if classname(1) == correctType
            correctCount = correctCount + 1;
        end
    end
    
    fprintf('correct cases: %d\n', correctCount);
end

