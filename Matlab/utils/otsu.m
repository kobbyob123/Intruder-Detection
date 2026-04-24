function [threshold] = otsu(img)
    % img must be uint8 grayscale (0-255)
    img = double(img);
    total_pixels = numel(img);

    % Step 1: compute normalised histogram (probability of each intensity)
    hist_counts = zeros(1, 256);
    for i = 1:total_pixels
        val = img(i) + 1;  % MATLAB is 1-indexed, intensity 0 → bin 1
        hist_counts(val) = hist_counts(val) + 1;
    end
    p = hist_counts / total_pixels;  % normalised: sums to 1

    % sweep T from 0 to 255, compute between-class variance
    best_var = -1;
    threshold = 0;

    for t = 1:255
        w0 = sum(p(1:t));
        w1 = sum(p(t+1:end));

        if w0 == 0 || w1 == 0
            continue   % degenerate case — one class is empty
        end

        mu0 = sum((0:t-1)   .* p(1:t))   / w0;
        mu1 = sum((t:255)   .* p(t+1:end)) / w1;

        between_var = w0 * w1 * (mu0 - mu1)^2;

        if between_var > best_var
            best_var = between_var;
            threshold = t;
        end
    end
end
