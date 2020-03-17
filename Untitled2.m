load("H:\dos\WORK\Year 3\Final Year Project\Ninapro database\Database 1\S1_A1_E1.mat");

winSize = 15;

% Divide signal into time windows of 150ms
len = floor(length(emg)/winSize)*winSize;

windows = reshape(emg(1:len,:), winSize, 10, 1, []);
labels = reshape(restimulus(1:len), winSize, []);   

ignore = [];
for i = 1:length(labels)
    if labels(1,i) ~= labels(end,i)
        ignore = [ignore, i];
    end
end

windows(:,:,:,ignore) = [];
disp(size(windows))
labels(:,ignore) = [];
labels = categorical(labels(1,:));

len = length(labels);
idx = randperm(len, round(len/3));
XValid = windows(:,:,:,idx);
YValid = labels(idx);

XTrain = windows;
XTrain(:,:,:,idx) = [];
YTrain = labels;
YTrain(idx) = [];