# Behavioral Analysis: Manual Dexterity

## Overview

This module analyzes **manual dexterity** to investigate the effects of long-term motor training (piano expertise) on human performance.

We evaluate both:

* **Fine motor control**
* **Gross motor control**

using standardized behavioral assessments, and compare:

* Between groups (controls vs. skilled pianists)
* Within subjects (left vs. right hand)

---

## Behavioral Tests

### 🔹 Nine-Hole Peg Test (9HPT) — *Fine Dexterity*

The 9HPT measures **unilateral fine motor dexterity**.

* Task: Place and remove 9 pegs into a board as quickly as possible
* Metric: **Completion time (seconds)**
* Interpretation: Lower time = better performance

**Reference:**
Mathiowetz et al., 1985 — *Adult Norms for the Nine Hole Peg Test of Finger Dexterity*

---

### 🔹 Box and Blocks Test (B&B) — *Gross Dexterity*

The B&B measures **unilateral gross manual dexterity**.

* Task: Move as many blocks as possible across a partition in 60 seconds
* Metric: **Number of blocks moved**
* Interpretation: Higher count = better performance

**Reference:**
Mathiowetz et al., 1985 — *Adult Norms for the Box and Block Test of Manual Dexterity*

---

## Analysis Approach

We analyze dexterity at two levels:

### 1. Univariate Analysis

Each test is analyzed independently:

* 9HPT → fine dexterity
* B&B → gross dexterity

Comparisons:

* **Between groups:** controls vs. skilled
* **Between hands:** left vs. right (within group)

---

### 2. Multivariate (Bidimensional) Analysis

We model dexterity as a **2D feature vector per hand**:

```text
[9HPT (fine), B&B (gross)]
```

This allows us to:

* Capture relationships between fine and gross motor control
* Perform **joint statistical comparisons** between hands

---

## Statistical Methods

We use **nonparametric and multivariate statistical tests**:

* **Wilcoxon Rank-Sum Test**

  * Between-group comparisons (controls vs. skilled)

* **Wilcoxon Signed-Rank Test**

  * Within-subject comparisons (left vs. right hand)

* **Hotelling’s T² Test (paired)**

  * Multivariate comparison of dexterity vectors between hands

* **False Discovery Rate (FDR) correction**

  * Adjusts for multiple comparisons
  * Significance threshold: **adjusted p < 0.05**

**Reference:**
Benjamini & Hochberg, 1995 — *Controlling the False Discovery Rate*

---

## Results Summary

### 🔹 Group Differences

* Skilled participants showed **better average performance** in both tests
* However, differences were **not statistically significant** (p > 0.05)

---

### 🔹 Inter-Hand Differences

* **Controls:**

  * Dominant hand significantly outperformed non-dominant hand
  * B&B: p = 0.033
  * 9HPT: p = 0.042

* **Skilled (Pianists):**

  * No significant differences between hands
  * Suggests **greater bilateral symmetry (ambidexterity)**

---

### 🔹 Multivariate Dexterity (Key Insight)

Using Hotelling’s T² test on combined dexterity:

* **Controls:**

  * Significant difference between hands
  * p = 0.0068, T² = 20.3, adj-p = 0.0136

* **Skilled:**

  * No significant difference
  * p = 0.68, T² = 0.92

👉 **Interpretation:**
Skilled individuals exhibit more **balanced (bilateral) motor performance**, consistent with training-induced adaptation.

---

## Figures

![Dexterity Results](https://github.com/user-attachments/assets/2365f4d6-bcf2-4916-930f-83690769d5cc)

* **(a)** Box and Blocks Test (gross dexterity)
* **(b)** 9-Hole Peg Test (fine dexterity)
* **(c)** Bidimensional dexterity distributions

---

## Code

* `AnalysisofDexterity.m`
  → Generates univariate comparisons and Figures (a, b)

* `bidimensionalDistributions.m`
  → Generates multivariate analysis and Figure (c)

---

## Key Takeaway

Motor training (piano expertise) is associated with:

* Improved overall dexterity (trend)
* **Reduced asymmetry between hands**
* More balanced integration of fine and gross motor control

This supports the idea that **long-term training enhances bilateral motor coordination**.

