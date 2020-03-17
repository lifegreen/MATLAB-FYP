function databaseInfo(gestures)
    total = 0;
    for g = 1:numel(gestures)
        fprintf("#%d - %d samples\n", g, size(gestures{g}, 4));
        total = total + size(gestures{g}, 4);
    end
    fprintf("TOTAL = %d\n", total);
end

