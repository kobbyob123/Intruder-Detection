clear; clc;

cam = webcam;

% Step 1: Capture the reference
disp('Capturing reference frame in 3 seconds...');
pause(3);
ref = cam.snapshot;
ref_gray = rgb_2_gray(ref);

% Step 2: Robber here haha
disp('New Object Here... capturing in 5 seconds');
pause(5);
current = cam.snapshot;
current_gray = rgb_2_gray(current);

% Step 3: Compute the absolute difference
diff_img = im_abs_diff(ref_gray, current_gray);

% Step 4: Display everything side by side
figure;
subplot(1,3,1); imshow(ref);       title('Reference');
subplot(1,3,2); imshow(current);   title('Current');
subplot(1,3,3); imshow(diff_img, []); title('Difference');

% Apply Otsu Thresholding to binarize it 
% (any noise in the image? must be fixed before applying otsu)



% Turn of camera
clear cam