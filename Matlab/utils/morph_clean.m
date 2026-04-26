function out = morph_clean(bw, se)
    opened = mdilate(merode(bw, se), se);   % remove speckles
    out    = merode(mdilate(opened, se), se); % fill holes
end
