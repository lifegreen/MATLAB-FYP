function base = catDatabase(base, set)
     for i = 1:numel(base)
         base{i, 1} = cat(4, base{i}, set{i});
     end
end
