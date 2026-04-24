function[newImage] = im_abs_diff(image1, image2)
    % convert images to double to prevent saturation error
    diff_double = abs(double(image1) - double(image2));

    % convert back to uint8
    newImage = uint8(diff_double);
end
