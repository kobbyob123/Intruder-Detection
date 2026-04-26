function out = morph_clean(bw, se)
    opened = dilate(erode(bw, se), se);   % remove speckles
    out    = erode(dilate(opened, se), se); % fill holes
end
