function [windows, labels] = split(signal, winSize, overlap, stimulus)
    classes = categorical(unique(stimulus)); % Get labels
    % Check that overlap < winSize/2 
    len = floor(size(signal, 1) / (winSize-overlap)); % Max number of windows
    
    windows = cell(len,1);
    labels  = classes(ones(len,1));
    entry = 0;
    
    for i = 1:len
        
        start  = (i-1) * (winSize-overlap) + 1;
        finish = start + winSize - 1;
        
        if (stimulus(start) == stimulus(finish)) % Ignore windows that have state transitions
            entry = entry + 1;
            windows(entry) = {reshape(signal(start:finish,:),winSize,[],1)};
            labels(entry) = classes(stimulus(start) + 1);
        end
        
    end
    
    windows = windows(1:entry);
    labels = labels(1:entry);
end