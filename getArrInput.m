function arr = getArrInput(input)
    if isstring(input)
        input = str2double(split(input));
        arr = input(~isnan(input));
    else
        arr = input;
    end
end

