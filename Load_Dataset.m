list = [];
pool = {};
list = [list, load("H:\dos\WORK\Year 3\Final Year Project\Ninapro database\Database 1\S1_A1_E1.mat")];
% list = [list, load("H:\dos\WORK\Year 3\Final Year Project\Ninapro database\Database 1\S2_A1_E1.mat")];


for subject = 1:length(list)
    %labels = categorical(unique(restimulus)); % Get labels
    
    % Divide signal into time windows of 150ms
    len = floor(length(list(subject).emg)/15)*15;
    list(subject).emg = list(subject).emg(1:len,:); % Ignore the remainder
    windows = reshape(list(subject).emg, 15, 10, []);
    
    for win = 1:size(windows,3)
        category = list(subject).restimulus(15*(win-1)+1);
        name = sprintf("S%d_R%d_W%d", subject, list(subject).rerepetition(15*(win-1)+1), win);
        
        switch category
            case 0 % Rest
                label = "Rest";
                
            case 1 %Index flexion
                label = "Index flexion";
                
            otherwise 
                disp('Invalid stimulus')     
        end
        
        emg = windows(:,:,win);
        save(fullfile(label,name), "emg")
        
        
    end
end 
