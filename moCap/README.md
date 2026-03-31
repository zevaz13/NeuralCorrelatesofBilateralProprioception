# Motion Capture Analysis

## Overview

This module analyzes **hand movement and proprioceptive performance** using motion capture data collected during the experiment.

The goal is to:

* Track **precise hand movements**
* Quantify **proprioceptive accuracy**
* Align movement data with experimental events (from EEG tasks)

---

## Task Demo

![Media1](https://github.com/user-attachments/assets/da83c07e-c77c-4c3a-ab9f-845249121252)

---

## How the System Works

Motion capture and EEG experiments were synchronized in real time.

* The experiment was controlled using **BCI2000**
* Motion capture data was recorded simultaneously
* Communication between systems was handled using:

  * **Arduino (serial communication)**
  * A **Python script** acting as a bridge

This setup allowed us to:

* Trigger motion capture recordings at the exact start of each trial
* Label movement data with task-specific identifiers

![System Diagram](https://github.com/user-attachments/assets/54dc0c0a-064e-4ad5-b8c7-457970577c34)

---

## Data Collection

We used a 4-camera motion tracking system to capture hand movements at high precision.

* Sampling rate: **120 Hz**
* Tracking method: **reflective markers on the hands**
* Coordinate system:

  * X → left/right
  * Y → up/down
  * Z → toward/away from the subject

Markers were placed on:

* Fingertips
* Finger joints
* Custom marker clusters attached to each hand

All markers on each hand were grouped as a **rigid body**, allowing robust tracking of fingertip position, which is the main variable used in the analysis.
(See paper for full task description)
---

## Example Data

Segmented motion capture data from a single trial:

![Example Data](https://github.com/user-attachments/assets/54358d81-753c-42a3-9ec7-8cb2a590f195)

---

## What We Measure: Proprioceptive Error

We quantify how accurately participants can **match or reproduce hand positions**.

### Key Idea

We compare **where the hand should be** vs. **where it actually is**.

---

### Types of Errors

#### 🔹 Matching Error (Bilateral Tasks)

* Compares left and right hand positions
* Measures how well one hand matches the other

```text
Error = | Left hand position − Right hand position |
```

---

#### 🔹 Replication Error (Unilateral Tasks)

* Compares current movement to a previously learned position
* Measures how accurately a position is reproduced

```text
Error = | Current position − Previous target position |
```

---

### How Errors Are Computed

* For each trial:

  * We take the **final ~100 ms of movement**
  * Average the position samples
* Trials with artifacts are removed (manual inspection)
* Final metric:

  * **Median error across trials** for each task

---

## Experimental Tasks

Data is grouped by task type:

* BDM / BDM-v → Bilateral matching
* UDR / UDR-v → Unilateral replication

(See paper for full task description)

---

## Running the Analysis

If starting from raw data:

1. Download the dataset:
   👉 https://github.com/zevaz13/data-bilateralprop

2. Set the path to the data in MATLAB:

```matlab
path2data = ''; % <-- update this
```

3. Run preprocessing:

```matlab
run('moCap/preprocessing/createErrorStructure.m')
```

This script:

* Loads raw motion capture data
* Computes matching and replication errors
* Organizes results into a structured format

If starting from processed errors data:
* We use the file with proprioceptive errors in moCap/medAbsAllconditions.mat
---

## Key Functions

* `createErrorStructure.m`
  → Main preprocessing pipeline

* `errorH2fromArray.m`

* `errorMH2fromArray.m`
  → Core error computation functions

---

## Notes

* Some plotting functions use external utilities (e.g., hatching for visualization)
* These are not essential and can be replaced if needed

---

## Takeaway

Motion capture allows us to move beyond simple performance metrics and directly measure **how accurately people perceive and control their movements**.

These error metrics provide a quantitative link between:

* Behavior (task performance)
* Motor control
* Underlying neural processes (EEG)




