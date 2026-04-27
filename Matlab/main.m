clear; clc;

cam = webcam;

% Capture the reference
disp('Capturing reference frame in 3 seconds...');
pause(3);
ref = cam.snapshot;
ref_gray = rgb_2_gray(ref);

% Capture Current
disp('New Object Here... capturing in 5 seconds');
pause(5);
current = cam.snapshot;
current_gray = rgb_2_gray(current);

% Compute the absolute difference
diff_img = im_abs_diff(ref_gray, current_gray);

% Apply Otsu Thresholding to binarize it 
T = otsu(diff_img);
binary_mask = diff_img > T;

% Morphology Clean-Up
se = ones(5, 5);  % 5x5 square structuring element — tune this
clean_mask = morph_clean(binary_mask, se);

% Identify Components in Image
[labels, n] = connected_components(clean_mask);
objects = region_props(labels, n);

% Filter out noise — keep only objects above a minimum area
MIN_AREA = 500;  % tune this
intruders = objects([objects.area] > MIN_AREA);

fprintf('Detected %d intruder(s)\n', numel(intruders));

% Draw bounding boxes on a display copy
display_img = repmat(uint8(clean_mask) * 255, [1 1 3]);  % binary → RGB

for k = 1:numel(intruders)
    bb = intruders(k).bbox;
    x1 = bb(1); y1 = bb(2);
    x2 = bb(1) + bb(3) - 1;
    y2 = bb(2) + bb(4) - 1;
    % left edge
    display_img(y1:y2, x1, 1) = 255;
    display_img(y1:y2, x1, 2) = 0;
    display_img(y1:y2, x1, 3) = 0;
    % right edge
    display_img(y1:y2, x2, 1) = 255;
    display_img(y1:y2, x2, 2) = 0;
    display_img(y1:y2, x2, 3) = 0;
    % top edge
    display_img(y1, x1:x2, 1) = 255;
    display_img(y1, x1:x2, 2) = 0;
    display_img(y1, x1:x2, 3) = 0;
    % bottom edge
    display_img(y2, x1:x2, 1) = 255;
    display_img(y2, x1:x2, 2) = 0;
    display_img(y2, x1:x2, 3) = 0;
end

if numel(intruders) > 0
    fprintf('ALARM — %d intruder(s) detected\n', numel(intruders));

    for k = 1:numel(intruders)
        fprintf('  Object %d: area=%d px, centroid=(%.1f, %.1f), bbox=[%d %d %d %d]\n', ...
            k, ...
            intruders(k).area, ...
            intruders(k).centroid(1), intruders(k).centroid(2), ...
            intruders(k).bbox(1), intruders(k).bbox(2), ...
            intruders(k).bbox(3), intruders(k).bbox(4));
    end

    alarm_sound();
else
    fprintf('No intruders detected\n');
end

imshow(display_img);

% Turn off camera
clear cam
