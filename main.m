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
% setupKnn(20, centers);
data = setupKnn(1);

column_name=["������", "��ȷʶ����", "׼ȷ��"];
f = figure;
set(f,'position',[500 500 300 160]);
uit = uitable(f,'Data',data,'Position',[20 20 260 130],'Columnname',column_name,'Rowname',row_name);
