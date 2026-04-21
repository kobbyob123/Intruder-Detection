import cv2
import numpy as np
import matplotlib.pyplot as plt
import time

# make sure you have the dependencies before running

# Initialize webcam
cam = cv2.VideoCapture(0)

def capture_frame(cam):
    """
    a built in function to capture images
    args:
        cam: camera object
    """
    ret, frame = cam.read()
    if not ret:
        raise RuntimeError("Failed to capture frame")
    return frame

# Step 1: Capture the reference frame
print("Capturing reference frame in 3 seconds...")
time.sleep(3)
ref = capture_frame(cam)
ref_gray = cv2.cvtColor(ref, cv2.COLOR_BGR2GRAY)

# Step 2: Robber here haha
print("New Object Here... capturing in 5 seconds")
time.sleep(5)
current = capture_frame(cam)
current_gray = cv2.cvtColor(current, cv2.COLOR_BGR2GRAY)

# Step 3: Compute the absolute difference
diff_img = cv2.absdiff(current_gray, ref_gray)

# Step 4: Display everything side by side
fig, axes = plt.subplots(1, 3, figsize=(15, 5))

axes[0].imshow(cv2.cvtColor(ref, cv2.COLOR_BGR2RGB))
axes[0].set_title("Reference")
axes[0].axis("off")

axes[1].imshow(cv2.cvtColor(current, cv2.COLOR_BGR2RGB))
axes[1].set_title("Current")
axes[1].axis("off")

axes[2].imshow(diff_img, cmap="gray")
axes[2].set_title("Difference")
axes[2].axis("off")

plt.tight_layout()
plt.show()

# Apply Otsu Thresholding
# Optional pre-processing: Gaussian blur to reduce noise before Otsu
diff_blurred = cv2.GaussianBlur(diff_img, (5, 5), 0)
_, otsu_thresh = cv2.threshold(diff_blurred, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)

plt.figure(figsize=(6, 5))
plt.imshow(otsu_thresh, cmap="gray")
plt.title(f"Otsu Threshold (T = {_:.0f})")
plt.axis("off")
plt.show()

cam.release()
