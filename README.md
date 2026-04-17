# Alarm Intruder Detection System with Camera-Based Object Measurement

A real-time intrusion detection system that uses a camera feed to detect objects, measure their size, and trigger an audible alarm. Built as a semester project for the **Numerical Methods of Image Analysis (TNM-A)** course at FME, Brno University of Technology.

> **Instructor:** Dr. Jana Procházková  
> **Academic Year:** 2025/2026

---

## Overview

This project applies classical image analysis techniques — background subtraction, thresholding, edge detection, and morphological processing — to build a functional alarm system. When an intruder or foreign object enters the camera's field of view, the system detects it, estimates its physical size in pixels (and optionally in real-world units via calibration), and triggers a sound alert.

The primary implementation is in **MATLAB** (course requirement). A parallel **Python** (OpenCV) implementation is provided for portability and open-source accessibility.

---

## Features

- **Live camera feed** — captures frames from a webcam or video file
- **Background subtraction** — isolates moving or new objects from a static scene
- **Object segmentation** — binary thresholding (Otsu's method) + morphological cleanup (erosion/dilation) to extract clean object masks
- **Bounding box & size measurement** — computes the bounding rectangle, area (in pixels), and optionally calibrated dimensions (cm/mm) of each detected object
- **Audible alarm** — plays a warning sound when a detected object exceeds a configurable size threshold
- **Detection overlay** — draws bounding boxes and size annotations directly on the video feed

---

## Project Structure

```
alarm-intruder-camera/
├── matlab/
│   ├── main.m                  # Entry point — runs the detection loop
│   ├── capture_background.m    # Captures and averages background frames
│   ├── detect_objects.m        # Segmentation + connected component analysis
│   ├── measure_size.m          # Bounding box & area computation
│   ├── trigger_alarm.m         # Sound playback logic
│   ├── calibrate_camera.m      # (Optional) pixel-to-mm calibration
│   └── utils/
│       ├── apply_morphology.m  # Erosion, dilation, opening, closing
│       └── overlay_boxes.m     # Draw bounding boxes on frames
│
├── python/
│   ├── main.py                 # Entry point — runs the detection loop
│   ├── background.py           # Background model (averaging / MOG2)
│   ├── detector.py             # Thresholding + contour-based detection
│   ├── measurement.py          # Bounding rect, area, calibrated size
│   ├── alarm.py                # Sound playback (simpleaudio / pygame)
│   ├── calibration.py          # (Optional) pixel-to-mm mapping
│   └── requirements.txt        # Python dependencies
│
├── assets/
│   ├── alarm.wav               # Default alarm sound
│   └── sample_video.mp4        # Test video for development
│
├── docs/
│   ├── report.pdf              # Final project report (submitted to course)
│   └── architecture.png        # System pipeline diagram
│
├── README.md
└── LICENSE
```

---

## How It Works

The detection pipeline follows these stages:

1. **Background capture** — On startup, the system captures N frames of the empty scene and computes an average background image.
2. **Frame differencing** — Each new frame is subtracted from the background model. The absolute difference highlights regions where something has changed.
3. **Thresholding** — The difference image is converted to grayscale and binarized using Otsu's method to produce a binary mask.
4. **Morphological cleanup** — Erosion removes small noise blobs; dilation reconnects fragmented object regions. Opening and closing operations refine the mask.
5. **Connected components / Contour detection** — In MATLAB, `bwconncomp` + `regionprops` extracts object regions. In Python, `cv2.findContours` serves the same role.
6. **Size measurement** — For each detected region, the system computes the bounding box dimensions and pixel area. If a calibration factor is set, these are converted to real-world units.
7. **Alarm trigger** — If any object exceeds the minimum area threshold, the system plays an alarm sound.

---

## Getting Started

### MATLAB

**Requirements:** MATLAB R2020b+ with the Image Processing Toolbox.

```matlab
% 1. Open MATLAB and navigate to the matlab/ directory
% 2. Run the main script
main
```

### Python

**Requirements:** Python 3.8+

```bash
# 1. Clone the repository
git clone https://github.com/<your-username>/alarm-intruder-camera.git
cd alarm-intruder-camera/python

# 2. Install dependencies
pip install -r requirements.txt

# 3. Run the detector
python main.py
```

**Key dependencies:** `opencv-python`, `numpy`, `simpleaudio` (or `pygame` for cross-platform audio).

---

## Configuration

Key parameters can be adjusted at the top of `main.m` / `main.py`:

| Parameter | Default | Description |
|---|---|---|
| `BG_FRAMES` | 30 | Number of frames used to build the background model |
| `MIN_AREA` | 500 | Minimum object area (px²) to trigger detection |
| `THRESHOLD` | auto (Otsu) | Binarization threshold; auto by default |
| `MORPH_KERNEL` | 5×5 | Structuring element size for morphological ops |
| `ALARM_COOLDOWN` | 3.0 s | Minimum interval between repeated alarms |
| `CALIBRATION_FACTOR` | None | px-to-mm ratio (set via calibration routine) |

---

## Course Concepts Applied

This project draws on techniques covered throughout the TNM-A syllabus:

- **Image representation & acquisition** (Lectures 1–2) — working with RGB/grayscale frames from a camera
- **Histograms & thresholding** (Lectures 3–4) — Otsu's method for automatic binarization
- **Convolution & spatial filtering** (Lecture 5) — Gaussian blur for noise reduction before thresholding
- **Fourier domain filtering** (Lectures 6–7) — optional frequency-domain noise removal on noisy feeds
- **Noise analysis & filtration** (Lectures 9–10) — handling real-world sensor noise in the camera feed
- **Image segmentation** (Lecture 11) — connected component analysis, region-based segmentation
- **Object analysis** (Lecture 12) — bounding boxes, area, centroid, moment-based descriptors

---

## Roadmap

- [x] Project structure and README
- [ ] Background subtraction (static averaging)
- [ ] Otsu thresholding + morphological cleanup
- [ ] Connected component / contour detection
- [ ] Bounding box overlay and area measurement
- [ ] Alarm sound trigger with cooldown
- [ ] Camera calibration for real-world size estimation
- [ ] Python port with OpenCV
- [ ] Performance benchmarking (MATLAB vs. Python)
- [ ] Final report and presentation

---

## License

This project is released under the [MIT License](LICENSE).

---

## Acknowledgments

- **Dr. Jana Procházková** — course instructor, FME BUT
- Course materials and MATLAB scripts from the Numerical Methods of Image Analysis (TNM-A) lectures
- OpenCV documentation and tutorials for the Python implementation
