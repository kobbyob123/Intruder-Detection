function [output] = mdilate(bw, se)
    [rows, cols] = size(bw);
    [sr, sc] = size(se);
    pad_r = floor(sr/2);
    pad_c = floor(sc/2);
    
    padded = zeros(rows + 2*pad_r, cols + 2*pad_c);
    padded(pad_r+1:end-pad_r, pad_c+1:end-pad_c) = bw;
    
    output = zeros(rows, cols);
    for i = 1:rows
        for j = 1:cols
            region = padded(i:i+sr-1, j:j+sc-1);
            % dilate: output is 1 if ANY pixel under se is 1
            output(i,j) = any(region(se==1) == 1);
        end
    end
end
