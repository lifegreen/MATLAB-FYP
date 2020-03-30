for i = 1:6734
    if ~(classes(1) == classify(net,a(:,:,:,i)))
        disp(i)
    end
end