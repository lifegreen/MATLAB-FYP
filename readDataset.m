function [gestures] = readDataset()
    load("H:\dos\WORK\Year 3\Final Year Project\Ninapro database\Database 1\S1_A1_E1.mat");

    winSize = 15;

    % Divide signal into time windows of 150ms
    len = floor(length(emg)/winSize)*winSize;

    windows = reshape(emg(1:len,:), winSize, 10, 1, []);
    labels = transpose(reshape(restimulus(1:len), winSize, []));  

    ignore = [];
    for i = 1:length(labels)
        if labels(i,1) ~= labels(i,end)
            ignore = [ignore, i];
        end
    end

    windows(:,:,:,ignore) = [];
    disp(size(windows))
    labels(ignore, :) = [];
    labels = categorical(labels(:,1));

    classes = unique(labels);
    gestures = cell(size(classes));
    for g = 1:numel(classes)
        gestures{g} = windows(:,:,:,(labels == classes(g)));
    end

    databaseInfo(gestures)
end

