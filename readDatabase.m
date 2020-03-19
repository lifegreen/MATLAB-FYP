function Data = readDatabase(database, exercise, subject)
    exercise = getArrInput(exercise);    
    subject = getArrInput(subject);
    
    if ~(isscalar(exercise) && ismember(exercise, [1, 2, 3]))
        Data = NaN;
        return
    end
    
    list = [];
    if isempty(subject)
       name = sprintf("*E%d*.mat", exercise);
       list = dir(fullfile(database, name));
    else
       for s = subject
            name = sprintf("*S%d_*E%d*.mat", s, exercise);
            list = [list; dir(fullfile(database, name))];
       end
    end
   
    Data = readDataset(fullfile(list(1).folder, list(1).name));
    if numel(list) > 1
        for entry = 2:numel(list)
            gestures = readDataset(fullfile(list(entry).folder, list(entry).name));
            databaseInfo(gestures)

            Data = catDatabase(Data, gestures);
        end
    end
end

