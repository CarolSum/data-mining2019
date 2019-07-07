clf;

sprintPicsPath = '/Users/lijiehong/Desktop/dm/ѵ��+����/����/';
summerPicsPath = '/Users/lijiehong/Desktop/dm/ѵ��+����/����/';
automnPicsPath = '/Users/lijiehong/Desktop/dm/ѵ��+����/����/';
winterPicsPath = '/Users/lijiehong/Desktop/dm/ѵ��+����/����/';

global typeArr;
global picHueAvgArr;
global picHueStdArr;

typeArr = [];
picHueAvgArr = [];
picHueStdArr = [];

% ����ѵ���� ��ȡÿ�����ڵ�ͼƬHSV�ľ�ֵ�ͱ�׼��
disp('����');
sprintHSV = getImagesHSV(sprintPicsPath, 1);
disp('����');
summerHSV = getImagesHSV(summerPicsPath, 2);
disp('����');
autumnHSV = getImagesHSV(automnPicsPath, 3);
disp('����');
winterHSV = getImagesHSV(winterPicsPath, 4);

data = [sprintHSV; summerHSV; autumnHSV; winterHSV;];
% ���ʱ�伾��ͼ��HSV��������
row_name=['����'; '����'; '����'; '����'];
column_name=['H_avg'; 'H_std'; 'S_avg'; 'S_std'; 'V_avg'; 'V_std'];

set(figure(1),'position',[200 200 540 130]);
uitable(gcf,'Data',data,'Position',[20 20 490 90],'Columnname',column_name,'Rowname',row_name);


% ͨ��K-means�����㷨��ȡ����ɫ����������
centers = kmeans(4);
disp(centers);

column_name=["ɫ����ֵ", "ɫ����׼��"];
f = figure;
set(f,'position',[400 400 240 130]);
uit = uitable(f,'Data',centers,'Position',[20 20 200 100],'Columnname',column_name,'Rowname',row_name);

% ͨ��knn��ͼƬ�������ͽ���ʶ��
setupKnn(20);

% ������ȡѵ������ÿһ��ͼƬ��ɫ������
% sprintImgHue = getDirImagesHue(sprintPicsPath);
% summerImgHue = getDirImagesHue(summerPicsPath);
% autumnImgHue = getDirImagesHue(automnPicsPath);
% winterImgHue = getDirImagesHue(winterPicsPath);
% disp(sprintImgHue);
% 
% 
% sprintTestPicsPath = '/Users/lijiehong/Desktop/dm/ѵ��+����/���Լ�/����/';
% summerTestPicsPath = '/Users/lijiehong/Desktop/dm/ѵ��+����/���Լ�/����/';
% autumnTestPicsPath = '/Users/lijiehong/Desktop/dm/ѵ��+����/���Լ�/����/';
% winterTestPicsPath = '/Users/lijiehong/Desktop/dm/ѵ��+����/���Լ�/����/';
% 
% % ��ȡ���Լ�ͼƬɫ������
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


