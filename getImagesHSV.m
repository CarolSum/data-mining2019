function result = getImagesHSV(picsPath, type)
    global typeArr;
    global picHueAvgArr;
    global picHueStdArr;
    imgPathList = dir([picsPath '*.jpg']);
    if ~isempty(imgPathList)
        H = [];
        S = [];
        V = [];
        for i = 1:length(imgPathList)
            image_name = imgPathList(i).name;
            image =  imread(strcat(picsPath,image_name));
            hsva = rgb2hsv(image);
            h = hsva(:,:,1);
            s = hsva(:,:,2);
            v = hsva(:,:,3);
            picHueAvgArr = [picHueAvgArr mean(h, 'all')];
            picHueStdArr = [picHueStdArr std(h, 1, 'all')];
            typeArr = [typeArr type];
            H = [H mean(h, 'all')];
            S = [S mean(s, 'all')];
            V = [V mean(v, 'all')];
        end
        display(mean(H, 'all'));
        display(std(H, 1, 'all'));
        display(mean(S, 'all'));
        display(std(S, 1, 'all'));
        display(mean(V, 'all'));
        display(std(V, 1, 'all'));
        result = [mean(H, 'all') std(H, 1, 'all') mean(S, 'all') std(S, 1, 'all') mean(V, 'all') std(V, 1, 'all')];
    end
end