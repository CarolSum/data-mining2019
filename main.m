clf;

sprintPicsPath = '/Users/lijiehong/Desktop/dm/训练+测试/春天/';
summerPicsPath = '/Users/lijiehong/Desktop/dm/训练+测试/夏天/';
automnPicsPath = '/Users/lijiehong/Desktop/dm/训练+测试/秋天/';
winterPicsPath = '/Users/lijiehong/Desktop/dm/训练+测试/冬天/';

global typeArr;
global picHueAvgArr;
global picHueStdArr;

typeArr = [];
picHueAvgArr = [];
picHueStdArr = [];

% 解析训练集 获取每个季节的图片HSV的均值和标准差
disp('春天');
sprintHSV = getImagesHSV(sprintPicsPath, 1);
disp('夏天');
summerHSV = getImagesHSV(summerPicsPath, 2);
disp('秋天');
autumnHSV = getImagesHSV(automnPicsPath, 3);
disp('冬天');
winterHSV = getImagesHSV(winterPicsPath, 4);

data = [sprintHSV; summerHSV; autumnHSV; winterHSV;];
% 输出时间季节图像HSV特征数据
row_name=['春天'; '夏天'; '秋天'; '冬天'];
column_name=['H_avg'; 'H_std'; 'S_avg'; 'S_std'; 'V_avg'; 'V_std'];

set(figure(1),'position',[200 200 540 130]);
uitable(gcf,'Data',data,'Position',[20 20 490 90],'Columnname',column_name,'Rowname',row_name);


% 通过K-means聚类算法获取季节色调特征数据
centers = kmeans(4);
disp(centers);

column_name=["色调均值", "色调标准差"];
f = figure;
set(f,'position',[400 400 240 130]);
uit = uitable(f,'Data',centers,'Position',[20 20 200 100],'Columnname',column_name,'Rowname',row_name);

% 通过knn对图片季节类型进行识别
setupKnn(20);

% 单独获取训练集中每一种图片的色调数据
% sprintImgHue = getDirImagesHue(sprintPicsPath);
% summerImgHue = getDirImagesHue(summerPicsPath);
% autumnImgHue = getDirImagesHue(automnPicsPath);
% winterImgHue = getDirImagesHue(winterPicsPath);
% disp(sprintImgHue);
% 
% 
% sprintTestPicsPath = '/Users/lijiehong/Desktop/dm/训练+测试/测试集/春天/';
% summerTestPicsPath = '/Users/lijiehong/Desktop/dm/训练+测试/测试集/夏天/';
% autumnTestPicsPath = '/Users/lijiehong/Desktop/dm/训练+测试/测试集/秋天/';
% winterTestPicsPath = '/Users/lijiehong/Desktop/dm/训练+测试/测试集/冬天/';
% 
% % 获取测试集图片色调数据
% sprintTestPics = getDirImagesHue(sprintTestPicsPath);
% summerTestPics = getDirImagesHue(summerTestPicsPath);
% autumnTestPics = getDirImagesHue(autumnTestPicsPath);
% winterTestPics = getDirImagesHue(winterTestPicsPath);
% 
% trainData(:,:,1) = sprintImgHue;
% trainData(:,:,2) = summerImgHue;
% trainData(:,:,3) = autumnImgHue;
% trainData(:,:,4) = winterImgHue;
% trainDim=size(trainData);
% 
% for i=1:length(sprintTestPics)
%     testData=sprintTestPics(i,:);
% end
% 
% function result = getDirImagesHue(picsPath)
%     result = [];
%     imgPathList = dir([picsPath '*.jpg']);
%     if ~isempty(imgPathList)
%         for i = 1:length(imgPathList)
%             image_name = imgPathList(i).name;
%             image =  imread(strcat(picsPath,image_name));
%             hsva = rgb2hsv(image);
%             h = hsva(:,:,1);
%             result = [result;[mean(h, 'all'), std(h, 1, 'all')]];
%         end
%     end
% end


