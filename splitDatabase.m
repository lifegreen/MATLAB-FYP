function [XTrain, YTrain, XValid, YValid] = splitDatabase(data, ratio)
    XTrain = [];
    YTrain = categorical();
    XValid = [];
    YValid = categorical();
    
    numClass = numel(data);
    classes = categorical(0:(numClass-1));
    for i = 2:numClass
        len = size(data{i}, 4);
        
        idx = randperm(len, round(len * ratio));
        
        sel = true(len, 1);
        sel(idx) = false;

        XValid = cat(4, XValid, data{i}(:,:,:,idx));
        XTrain = cat(4, XTrain, data{i}(:,:,:,sel));
        
        temp(1:numel(idx), 1) = classes(i);
        YValid = [YValid; temp];
        clear temp
        
        temp(1:(len - numel(idx)), 1) = classes(i);
        YTrain = [YTrain; temp];
        clear temp
    end
end
