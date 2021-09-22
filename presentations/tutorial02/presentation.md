name: inverse
layout: true
class: center, middle, inverse

---

# Tutorial 02: Anatomical and Diffusion <br>MRI Pipelines

### sebastien.tourbier@alumni.epfl.ch  |  CC-BY

.footer[<br><br><img src="https://sinergia-connectomics-summerschool-2021.github.io/img/SummerSchool2021_website_logo.png" height="80"><img src="https://sinergia-connectomics-summerschool-2021.github.io/img/logo_sponsors.png" height="80">]

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

---

## What is Connectome Mapper 3?

- Come with a Graphical User Interface aka `cmpbidsappmanager`, designed to facilitate:

    - the configuration of all pipeline stages,

    - the configuration of the BIDS App run and its execution,

    - the inspection of the different stage outputs with appropriate viewers

---

## CMP3 pipelines

<img src="https://connectome-mapper-3.readthedocs.io/en/latest/_images/flowchart_bidsapp.png" height="440" style="text-align: center">

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

Learn how to configure CMP3 pipelines and create their configuration files with `cmpbidsappmanager`

---

## Launch `cmpbidsappmanager`

- Open a terminal and launch `cmpbidsmanager`:
```
cmpbidsappmanger
```

---

## Load the summerschool dataset

- Load the summerschool dataset that in located in `$HOME/Data/ds003505`

---

## Open the configurator window

- Click on the left button of the main window of `cmpbidsappmanager` to open the configurator window

---

## Configure the pipelines

- Configure the pipelines as follows

---

## Save the pipeline configuration files

- Click on the button to save all pipeline configuration files

---

## Exercise 2: Use `cmpbidsappmanager` to run the BIDSApp

**Goal** Learn how to configure and execute the BIDS App with `cmpbidsappmanager`

---

## Open the BIDS App window

- Click on the middle button of the main window of `cmpbidsappmanager` to open the BIDS App window

---

## Configure the BIDS App execution

- Select to process `sub-01`

- Control that the configuration files are pointing to  `$HOME/Data/ds003505/code/ref_anatomical_config.json` and `$HOME/Data/ds003505/code/ref_diffusion_config.json`, created in Exercise 1

- Click on the `Check Settings` button to verify the configuration

---

## Execute the BIDS App

- Click on the `Run BIDS App` button to execute the BIDS App

- You can see the main output in the terminal

- An execution log is written to `derivatives/cmp/sub-01/sub-01_log.txt`

---

## Exercise 3: Use `cmpbidsappmanager` to check pipeline outputs with external viewers

Learn how to inspect the quality of the different stage outputs

---

## Open the quality inspector window

- Click on the right button of the main window of `cmpbidsappmanager` to open the quality inspector window

---

## Select to view outputs for `sub-01` 

- Select `sub-01` from the list

---

## Check the parcellations co-registered to the diffusion volume

- In `Diffusion Pipeline > Registration Stage`, you can check the parcellations co-registered to the resampled diffusion-free B0 volume

---

## Check the fiber orientation distribution function (ODF) image reconstructed by CSD

- In `Diffusion Pipeline > Diffusion Stage`, you can check the fiber orientation distribution function (ODF) image reconstructed by CSD

---

## Check the tractogram

- In `Diffusion Pipeline > Connectome Stage`, you can check the final tractogram (the reconstructed fibers used in the connectivity matrices)

---

## Visualize the connectivity matrices

- In `Diffusion Pipeline > Connectome Stage`, you can check the connectivity matrices for the different connectivity measures and the 5 scales of Lausanne 2018 parcellation scheme

---

## Exercise 4: Run directly the BIDSApp commandline interface

Learn how to run directly the BIDSApp commandline interface of CMP3

---

## Run the BIDSApp commandline interface of CMP3

- In a terminal, run the following command:
```bash
docker run -it --rm \
 -v /home/sinergiasummerschool/Data/ds003505:/bids_dir \
 -v /home/sinergiasummerschool/Data/ds003505/derivatives:/output_dir \
 -v /home/sinergiasummerschool/Softwares/freesurfer/license.txt:/bids_dir/code/license.txt \
 -v /home/sinergiasummerschool/Data/ds003505/code/ref_anatomical_config.json:/code/ref_anatomical_config.json \
 -v /home/sinergiasummerschool/Data/ds003505/code/ref_diffusion_config.json:/code/ref_diffusion_config.json \
 -u "$(id -u)":"$(id -g)" \
 sebastientourbier/connectomemapper-bidsapp:v3.0.0-RC4 \
 /bids_dir /output_dir participant --participant_label 01 \
 --anat_pipeline_config /code/ref_anatomical_config.json \
 --dwi_pipeline_config /code/ref_diffusion_config.json \
 --fs_license /bids_dir/code/license.txt
```
---

# Questions?

If something is unclear, or you would like to contribute to this tutorial, please open an issue or pull request on our [Github repo](https://github.com/sinergia-connectomics-summerschool-2021/scss21-training)
