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

% [imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');
%%
len = length(labels);
idx = randperm(len, round(len/3));
sel = true(len, 1);
sel(idx) = false;

XValid = windows(:,:,:,idx);
YValid = labels(idx);

XTrain = windows(:,:,:,sel);
YTrain = labels(sel);

%% Create Layers 
layers = [
    imageInputLayer([15 10])
  
    % Block 1
    convolution2dLayer([1 10], 32, 'Padding', 'same')
    reluLayer
    
    % Block 2 
    convolution2dLayer(3, 32, 'Padding', 'same')
    reluLayer
    averagePooling2dLayer(3, 'Stride', 3)
    
    % Block 3
    convolution2dLayer(5, 64, 'Padding', 'same')
    reluLayer
    averagePooling2dLayer(3, 'Stride', 3)
    
    % Block 4
    convolution2dLayer([5 1], 64, 'Padding', 'same')
    reluLayer
    
    % Block 5
    convolution2dLayer(1, 64, 'Padding', 'same')
%     reluLayer
%     maxPooling2dLayer(3, 'Stride', 3)
    
    fullyConnectedLayer(13)
    softmaxLayer
    classificationLayer];

%% Training options
options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',10, ...   
    'Shuffle','every-epoch', ...
    'Verbose',true, ...
    'Plots','training-progress');%     'ValidationData', {XValid, YValid}, ...
%     'ValidationFrequency',30, ...

%% Train Network
net = trainNetwork(XTrain, YTrain, layers, options);

%% Test Network

YPred = classify(net, XValid);

accuracy = sum(YPred == YValid)/numel(YValid)
