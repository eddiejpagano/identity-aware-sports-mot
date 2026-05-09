# Identity-Aware Sports MOT

An AI-powered sports vision and tactical analysis system for turning raw game film into structured player movement data, tactical context, and coach-friendly visualizations.

The project is designed around multi-object tracking in sports footage, with a focus on maintaining player identity over time and mapping player motion into a form that can support play reconstruction, formation analysis, and tactical review.

## Overview

Traditional film study at the high school and amateur level is slow, manual, and difficult to scale. This project aims to automate that workflow by combining computer vision, identity-aware tracking, and field-aware spatial analysis into one pipeline.

The long-term goal is to process broadcast or sideline sports footage and produce:

- persistent player tracks across frames
- team-level and player-level identity signals
- field-aligned position data
- tactical movement representations
- visual outputs for analysis and review

While the motivating use case is lacrosse, the overall pipeline is adaptable to other field and court sports such as football and basketball.

## Pipeline

The proposed system follows a staged vision pipeline:

1. **Video ingestion**
	Raw footage is prepared through normalization, stabilization, and frame-level preprocessing.

2. **Player detection**
	Players are localized in each frame using object detection models.

3. **Multi-object tracking**
	Detections are linked across time to maintain persistent identities through motion, camera movement, and partial occlusion.

4. **Identity understanding**
	Players are further characterized using team classification and, where feasible, jersey number recognition.

5. **Field mapping**
	Video coordinates are transformed into a top-down tactical view using homography and field markings.

6. **Play representation**
	Player positions and trajectories are converted into structured movement data for downstream tactical analysis.

7. **Visualization**
	Outputs can be rendered as annotated video, top-down tracking maps, and play reconstruction views.

## Why Identity-Aware Tracking Matters

Basic tracking is not enough for sports analysis. Tactical insights depend on knowing not just where motion occurred, but which player moved, how teams re-formed, and how spacing evolved over time.

Identity-aware tracking helps support:

- player-specific trajectory analysis
- off-ball movement understanding
- formation and spacing breakdowns
- possession and transition analysis
- cleaner downstream tactical visualizations

## Input Video Requirements

For best results, the source footage should follow these guidelines:

- **Resolution:** 1080p minimum, 4K preferred
- **Frame rate:** 30 FPS minimum, 60 FPS preferred
- **Camera position:** elevated view, ideally behind the end zone or from a central sideline perspective
- **Capture settings:** manual exposure and white balance when possible, with fast shutter speed to reduce motion blur

## Current Repository Layout

```text
.
├── configs/       # Configuration files
├── data/          # Datasets or intermediate artifacts
├── experiments/   # Small runnable experiments and prototypes
├── notebooks/     # Exploration and analysis notebooks
├── paper/         # Paper-related assets
├── scripts/       # Utility scripts
├── src/           # Core package source
├── tests/         # Test package
├── Dockerfile     # Container entrypoint
├── Makefile       # Convenience commands
└── README.md
```

At the moment, the repository is still in an early scaffold state. The current Docker entrypoint runs a simple example script in `experiments/test.py`.

## Getting Started

### Run with Docker

Build the image:

```bash
docker build -t identity-aware-sports-mot .
```

Run the container:

```bash
docker run --rm identity-aware-sports-mot
```

### Run with Make

If you have `make` available in your shell:

```bash
make build
make run
```

Or run both in one step:

```bash
make test
```

## Current Status

This repository currently contains the project scaffold and an initial Docker-based execution path. The full vision pipeline described above is the target system architecture and roadmap direction, rather than a complete implementation already present in the codebase.

## Roadmap

Planned areas of development include:

- baseline player detection for sports footage
- robust multi-object tracking under occlusion and motion
- team and jersey-based identity classification
- field homography and top-down tactical projection
- structured play and movement representation
- interactive visualization and analysis tooling

## Vision

The project is aimed at making advanced sports film analysis more accessible by reducing manual review time and producing clearer tactical insight from ordinary game video.
