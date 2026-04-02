![MATLAB](https://img.shields.io/badge/MATLAB-Compatible-blue)
![License](https://img.shields.io/badge/license-MIT-green)
# Neural Correlates of Bilateral Proprioception & Training Adaptation

## Overview
![lowBetaprogression](https://github.com/user-attachments/assets/99af1a1d-f409-40bc-9a9f-9da2e97a92df)

This repository accompanies the research in:

* [*Neural correlates of bilateral proprioception and adaptation with training*](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0299873)
* [Doctoral dissertation: *Electrophysiological Data Analysis to Study Human Motion and Sensation: Searching for Features that Adapt with Training or Injury. Chapter 5*](https://www.proquest.com/openview/e886e72de61e1c21936213a5b8c63acc/1?pq-origsite=gscholar&cbl=18750&diss=y) 

The goal of this project is to **analyze how neural and behavioral features evolve with motor training**, with a particular focus on **bilateral proprioception** (the ability to sense the position and motion of one hand relative to the other, without looking.)

This repository extends the original work by:

* Reproducing key analyses from the paper
* Introducing **new exploratory analyses** not included in the publication
* Providing a **structured, reproducible pipeline** for multimodal data (EEG, motion capture, behavioral metrics)


For information about how the data were acquired, please read the references or contact me at : sebastianruedaparra13@gmail.com
<img width="623" height="720" alt="Picture3" src="https://github.com/user-attachments/assets/8267e3a1-1c20-46fe-a08c-43e2b7c3bbc1" />
<img width="988" height="248" alt="ExpTimming" src="https://github.com/user-attachments/assets/d9dc7d81-5db8-4a88-9459-8a8e7e1cce1d" />

---

## Data Source

Raw experimental data is hosted separately:
👉 [here](https://github.com/zevaz13/data-bilateralprop)

This includes:

* Raw EEG recordings
* Raw Motion capture (MoCap) data

---

## Project Goals

* 🔹 Reproduce core findings from the original study
* 🔹 Explore **training-related adaptation** using new feature representations
* 🔹 Analyze **standardized scores and inter-subject variability**
* 🔹 Present results with **clear, step-by-step visualizations**

---

## Methods & Tools

This project combines neuroscience, signal processing, and data science techniques:

### Signal Processing & Analysis

* EEG preprocessing and feature extraction (EEGLAB-based workflows)
* time-frequency-domain analysis

### Data Modalities

* 🧠 EEG (electrophysiology). See `EEG/README.md`   
* 🎯 Behavioral performance metrics. See  `behavioral/README.md`  
* 🦾 Motion capture (kinematics). See `moCap/README.md`  

### Software Stack

* MATLAB (R2019, R2022)
* EEGLAB toolbox
* BCI2000 functions (MIT License, included in this repository)
* Custom-built analysis functions

---

## Repository Structure (Planned)

```
├── data/                  # (Optional) Processed or sample data
├── scripts/               # Main analysis scripts
├── functions/             # Custom MATLAB functions
├── external/              # Third-party tools (EEGLAB, BCI2000 components)
├── figures/               # Generated figures and visualizations
├── examples/              # Step-by-step demo analyses
└── README.md
```

---

## Example Workflows

This repository will include **guided examples** demonstrating:

* End-to-end EEG preprocessing
* Feature extraction and normalization
* Standardized score computation
* Multimodal data alignment (EEG + MoCap + behavior)
* Visualization of training-related adaptation

Each example will include:

* Clear explanation of the goal
* Step-by-step code
* Intermediate outputs
* Final figures

---

## Key Analyses (In Progress)

* 📊 Standardized feature comparison across subjects
* 🔁 Training-induced changes in neural signals
* 📉 Motion capture metrics of proprioception

---

## Status

🚧 This repository is actively under development.
Code, documentation, and examples will be expanded over time.

---

## Citation

If you use this repository, please cite:

- Rueda Parra S, Perry JC, Wolbrecht ET, Gupta D (2024) Neural correlates of bilateral proprioception and adaptation with training. PLoS ONE 19(3): e0299873. https://doi.org/10.1371/journal.pone.0299873
* *Electrophysiological Data Analysis to Study Human Motion and Sensation: Searching for Features that Adapt with Training or Injury*

(Full citation details will be added soon)

---

## Contact

For questions, collaborations, or feedback, feel free to reach out.
email: sebastianruedaparra13@gmail.com

---
