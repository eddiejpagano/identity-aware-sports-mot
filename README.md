# Identity-Aware Sports MOT

Identity-aware multi-object tracking for sideline sports footage, with a focus on reducing identity switches in dense environments such as lacrosse.

This project investigates a practical failure mode in modern tracking-by-detection pipelines: standard assignment-based trackers can follow motion well, but they often lose player identity when multiple athletes wear visually similar uniforms and interact under occlusion, overlap, or rapid direction changes.

## Problem

Assignment-based trackers such as BoT-SORT and ByteTrack depend heavily on motion cues and discriminative appearance embeddings. In team sports, those assumptions weaken quickly because many players share nearly identical visual features. As well as when players move in unpredictable ways and go over each other.

That creates a recurring failure pattern:

- two nearby players become difficult to distinguish
- the tracker assigns a detection to the wrong track
- the appearance model is updated with the wrong player

## Core Idea

Instead of replacing the tracker with a heavier end-to-end model, this project explores a modular augmentation to the assignment step.

The approach is an **augmented cost matrix framework** that injects sport-specific identity signals into standard MOT association logic without requiring full tracker retraining.

Two signals drive the approach:

1. **Team classification**
	Jersey color clustering acts as a hard or near-hard constraint that discourages impossible cross-team associations.

2. **Jersey number recognition**
	OCR-derived jersey numbers act as intermittent identity anchors. When a number is recognized with sufficient confidence, it strongly penalizes contradictory associations and helps recover from drift.

These are the cues people use naturally when watching sports film: color first, number when available.

## Objectives

The project is designed to:

- reduce identity switches in sideline sports footage
- reduce track fragmentation in crowded or overlapping scenes
- improve identity consistency without retraining the full tracker

## Research Focus

The emphasis is on evaluating whether **modular, sport-specific identity signals** can improve existing assignment-based MOT systems in a controlled and measurable way.

Key research questions include:

- how much can team-aware constraints reduce incorrect associations?
- when OCR signals are sparse or noisy, how much identity stability do they still provide?
- what anchor density is required before identity accuracy improves meaningfully?
- can lightweight domain priors outperform more architecturally complex tracking approaches in this setting?

## Planned Methodology

The intended evaluation flow is:

1. Use sideline lacrosse footage from fixed elevated camera positions.
2. Run baseline trackers such as BoT-SORT, ByteTrack, StrongSORT, or Deep OC-SORT.
3. Inject team and jersey-based cues into the assignment cost matrix.
4. Compare baseline and augmented variants under the same sequences.
5. Measure both traditional MOT quality and identity-specific stability.

## Evaluation Metrics

The project is expected to evaluate performance using common MOT metrics, including:

- IDSW
- Frag
- IDF1
- HOTA

In addition, the work proposes analyzing **anchor density versus identity accuracy** as a task-specific axis for understanding how often reliable identity cues must appear to keep tracks stable.

## Data Scope

The primary target domain is:

- sideline lacrosse footage
- fixed elevated camera setups
- real game conditions with overlap, occlusion, and similar uniforms

Although the initial focus is lacrosse, the framework is meant to generalize to other sports where appearance ambiguity makes identity persistence difficult.

## Why This Matters

Sports analysis depends on player identity, not just motion. A tracker that preserves position but loses identity becomes much less useful for tactical review, player-level analysis, or sequence reconstruction.

By improving the temporal duration of correct identity assignments, the system can support more reliable downstream analytics without requiring a fully bespoke tracking model from scratch.

## Repository Layout

```text
.
├── configs/       # Configuration files
├── data/          # Data assets and intermediate outputs
├── experiments/   # Prototypes and small runnable experiments
├── notebooks/     # Analysis notebooks
├── paper/         # Paper or manuscript-related assets
├── scripts/       # Utility scripts
├── src/           # Core source package
├── tests/         # Tests
├── Dockerfile     # Container definition
├── Makefile       # Convenience commands
└── README.md
```

The repository is currently in an early scaffold stage. The present Docker entrypoint runs a simple example script while the tracking pipeline is still being built out.

## Quick Start

### Docker

Build the image:

```bash
docker build -t identity-aware-sports-mot .
```

Run the container:

```bash
docker run --rm identity-aware-sports-mot
```

### Make

If `make` is available in your shell:

```bash
make build
make run
```

Or build and run in one step:

```bash
make test
```


## Next Steps

Near-term development is likely to focus on:

- baseline detector and tracker integration
- team classification from jersey appearance
- OCR-based jersey number extraction
- cost-matrix augmentation experiments
- benchmark evaluation against standard MOT baselines

## Summary

Identity-aware sports MOT is a focused attempt to make tracking-by-detection more reliable in team sports by adding the same cues that humans use instinctively: team color and jersey number. The project’s main claim is that these lightweight signals can meaningfully improve identity stability in assignment-based trackers without demanding a complete redesign of the underlying MOT system.
