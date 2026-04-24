function newI = rgb_2_gray(I)
    %[m, n, channels] = size(I);
    R = I(:,:,1);
    B = I(:,:,2);
    G = I(:,:,3);
    
    % ITU-R BT.601 standard
    newI = 0.298936021293775 * R + 0.587043074451121 * G + 0.114020904255103 * B;
end
