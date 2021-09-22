name: inverse
layout: true
class: center, middle, inverse

---

# Tutorial 02: Anatomical and Diffusion MRI Pipelines

### Sinergia Brain Dynamics on the Connectome Summer School 2021

#### sebastien.tourbier@alumni.epfl.ch  |  CC-BY

.footer[<img src="https://sinergia-connectomics-summerschool-2021.github.io/img/logo_sponsors.png" height="150">]

---

layout: false

## Tutorial outline

- What is Connectome Mapper 3?

- CMP3 pipelines

- Generate the 5-scale Lausanne2018 brain parcellations and the brain structural connectivity matrices

---

## What is Connectome Mapper 3?

- Open-source Python3 image processing pipeline software

- Implement full anatomical, diffusion and resting-state MRI processing pipelines, from raw Diffusion / T1 / T2 / BOLD data, organized accordingly to the BIDS standard to multi-resolution connection matrices.

- Distributed as a BIDS App to promote reusability, reproducibility and replicatibility

- Come with a Graphical User Interface aka `cmpbidsappmanager`, designed to facilitate:

    - the configuration of all pipeline stages,

    - the configuration of the BIDS App run and its execution,

    - the inspection of the different stage outputs with appropriate viewers

---

## CMP3 pipelines

- **Anatomical pipeline** Compute the different cortical parcellations from anatomical MRI data

- **Diffusion pipeline** Compute the different structural brain connectivity matrices from diffusion MRI data

- **fMRI pipeline** Compute the different brain functional connectivity matrices based on the Pearson's correlation between time-series of the cortical parcels

![Image not found](https://connectome-mapper-3.readthedocs.io/en/latest/_images/flowchart_bidsapp.png)

Source: [https://connectome-mapper-3.readthedocs.io/en/latest/\_images/flowchart_bidsapp.png](https://connectome-mapper-3.readthedocs.io/en/latest/_images/flowchart_bidsapp.png)

---

## Setup

- In this live tutorial, we will be using the summerschool `VEPCON` sample dataset. The data comes
  preloaded in the virtual machine of the summer school.

- To ensure you can follow along, please check that you have the
  virtual machine (VM) of the summer school running.

---

## Generate the 5-scale Lausanne2018 brain parcellations and the brain structural connectivity matrices


---

## Exercise 1: Use `cmpbidsappmanager` to configure the anatomical and diffusion pipelines 

**Goal** Learn how to configure CMP3 pipelines and create their configuration files with `cmpbidsappmanager`

---

### Store dataset path

- Store dataset path in `BIDS_DIR` environment variable
```
export BIDS_DIR="$HOME/Data/ds003505-sample"
```

---

## Exercise 2: Use `cmpbidsappmanager` to run the BIDSApp

**Goal** Learn how to configure and execute the BIDS App with `cmpbidsappmanager`

---

## Exercise 3: Use `cmpbidsappmanager` to check pipeline outputs with external viewers

**Goal** Learn how to inspect the quality of the different stage outputs

---

## Exercise 4: Run directly the BIDSApp commandline interface

**Goal** Learn how to run directly the BIDSApp commandline interface of CMP3

---

# Questions?

If something is unclear, or you would like to contribute to this tutorial, please open an issue or pull request on our [Github repo](https://github.com/sinergia-connectomics-summerschool-2021/scss21-training)
