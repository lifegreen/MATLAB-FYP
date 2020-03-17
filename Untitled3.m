for i = 1:6734
    if ~(c(1) == classify(net,a(:,:,:,i)))
        disp(i)
    end
end