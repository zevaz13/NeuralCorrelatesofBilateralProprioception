# EEG Analysis

## Overview

This module analyzes EEG data to study how brain activity relates to **movement, proprioception, and training**.

You have two ways to work with the data:

### Option 1 — Use Precomputed Features (Recommended)

If you want to get started quickly, use the extracted features from the paper:
👉 https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0299873

* No preprocessing required
* Directly jump into analysis and modeling

---

### Option 2 — Full Pipeline (Raw Data → Features)

If you want full control, you can run the entire EEG pipeline:

* Download raw data from the data repository
* Update file paths in the scripts
* Run preprocessing + feature extraction

⚠️ This route requires more setup but gives full flexibility.

---

## Data Acquisition (Quick Summary)

* 32-channel EEG (10–10 system)
* Sampling rate: **512 Hz**
* Hardware: g.Hiamp system + BCI2000

Participants performed hand movement tasks guided by **auditory cues**.

### Precise Timing (Important)

We used a hardware-based trigger system to ensure accurate timing:

* Audio signal is split into two channels:

  * One goes to the speaker (what the participant hears)
  * One goes to a microcontroller (Teensy)
* The microcontroller converts the signal into a **TTL pulse**
* This pulse is recorded with the EEG data

👉 This ensures that event markers reflect when the sound was actually heard, not just when it was scheduled.

---

## Preprocessing

Preprocessing is implemented using **EEGLAB** and standard pipelines.

Required EEGLAB plugins:

* AMICA This one is hard to use, [check their wiki](https://sccn.ucsd.edu/~jason/amica_web.html). If not, change the code and use runica.
* CleanLine
* ICLabel
* PrepPipeline
* clean_rawdata
* dipfit
* firfilt
* fitTwoDipoles

⚠️ You will need to install these manually in EEGLAB.


---

### Running Preprocessing

1. Download the raw data repository
2. Update all paths pointing to `rawData`
3. Run the preprocessing scripts

A full overview of the pipeline is shown below:

![preprocessing](https://github.com/user-attachments/assets/bda36c4c-00e7-4a2b-93cf-a2bd9b71ec8f)

---

## Feature Extraction

We extract **time-frequency features** to capture how brain activity evolves during movement.

### Method

* Time-frequency decomposition using **Morlet wavelets**
* Frequency range: **2–35 Hz**
* Baseline normalization (relative change from pre-stimulus activity)

This produces **ERSPs (Event-Related Spectral Perturbations)**:

* Measures changes in spectral power over time
* Expressed relative to a baseline period

---

### Features Used

We summarize ERSPs into interpretable features by averaging over:

#### Frequency Bands

* μ (mu) band
* Low-β band

#### Time Windows

* 0–200 ms → motor planning
* 200–400 ms → movement onset
* 400–800 ms → movement execution/offset

#### Regions of Interest (ROIs)

* Sensorimotor areas (see figure in repo)

---

### Final Features

Each feature represents:

```text
Mean ERSP over (frequency band × time window × brain region)
```

These are computed for all experimental tasks:

* TDS
* BDM / BDM-v
* UDR / UDR-v

Different combinations of these features are used to answer specific research questions.

---

## Takeaway

This pipeline transforms raw EEG signals into **interpretable features** that capture:

* Motor planning and execution
* Sensorimotor rhythms (μ and β)
* Changes associated with training and proprioception

👉 You can either:

* Use precomputed features for fast analysis
* Or run the full pipeline for complete control and reproducibility
