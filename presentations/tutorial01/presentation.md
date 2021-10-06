name: inverse
layout: true
class: center, middle, inverse

---

# Tutorial 01: Brain Imaging Data Structure

### sebastien.tourbier@alumni.epfl.ch  |  CC-BY

.footer[<br><br><img src="https://sinergia-connectomics-summerschool-2021.github.io/img/SummerSchool2021_website_logo.png" height="80"><img src="https://sinergia-connectomics-summerschool-2021.github.io/img/logo_sponsors.png" height="80">]

---

class: middle
layout: false

## Tutorial outline

- What is BIDS?

- Why BIDS?

- Getting familiar with BIDS and the summer school dataset

- How can I convert to BIDS?

---

class: middle

##  What is BIDS?

- BIDS ([Brain Imaging Data Structure](http://bids.neuroimaging.io)) is a standard for describing and organizing neuroimaging data and metadata, developed by a community of scientists working within the [International Neuroinformatics Coordinating Facility](http://incf.org) and in the neuroimaging field ([GitHub Repository](https://github.com/INCF/BIDS)).

<p style="text-align: center">
    <img src="https://bids.neuroimaging.io/assets/img/dicom-reorganization-transparent-white_1000x477.png" style="background-color: #000000; width: 60%;">
</p>

---

class: middle

##  Why BIDS?

1. Data Sharing and Reproducibility

    BIDS facilitates data sharing to a greater extent <a style="color:dodgerblue;">&rarr;</a> Allows us to better assess and reproduce others’ experimental findings

---

class: middle

##  Why BIDS?

2. Ecosystem of tools

    A number of tools have been developed around BIDS such as:

        - the [BIDS-validator](https://github.com/bids-standard/bids-validator), to automatically check datasets for adherence to the specification

        - [OpenNeuro](https://openneuro.org/), as a open database for sharing datasets structured following BIDS

        - [pybids](https://github.com/bids-standard/pybids) a Python library that centralizes interactions with BIDS formatted datasets

        - or the [“BIDS Apps”](https://bids-apps.neuroimaging.io/), a collection of portable neuroimaging analysis pipelines that take BIDS datasets as input

---

class: middle

##  Why BIDS?

3. Code sharing

    By developing a tool that can handle BIDS formatted datasets, you create at the same time a BIDS App that has the potential to be applicable to a large range of users as BIDS becomes increasingly popular.

---

class: middle

##  How BIDS is different from the existing solutions

- Existing solutions are more online databases that make (1) harder to manipulate with data and (2) data completely dependent on the database

- BIDS is just a collection of files structured in folders accordingly to the specifications. It is intentionally based on simple file formats and folder structures to reflect current lab practices and make it accessible to a wide range of scientists coming from different backgrounds.

- Focus on interoperability, simplicity, public data sharing, community, and extensibility. Originally developed for MRI data, already extended to MEG and EEG, and a number of [BIDS extension proposals](https://bids.neuroimaging.io/get_involved#extending-the-bids-specification) are ongoing.

---

class: middle

##  Getting familiar with BIDS and the summer school dataset

---

- Sample of the [VEPCON dataset](https://openneuro.org/datasets/ds003505/versions/1.0.2), a multimodal neuroimaging dataset created by our consortium.

```output
$HOME/Data/ds003505                         "Location in the virtual machine of the summer school"
├── dataset_description.json                "Describes briefly the dataset in JSON format"
├── participants.tsv                        "Table file that stores demographical information of the participants"
├── participants.json                       "Describes the columns of participants.tsv table file"
├── CHANGES                                 "Describes changes between dataset versions"
├── README                                  "Describes the dataset in more details in Markdown format"
└── sub-01
│   ├── anat
│   │   ├── sub-01_T1w.nii.gz               "Raw T1w MRI stored in Nifti format"
│   │   └── sub-01_T1w.json                 "Describes acquisition parameters related to the Nifti image"
│   ├── dwi
│   │   ├── sub-01_dwi.nii.gz               "Raw diffusion MRI stored in Nifti format"
│   │   ├── sub-01_dwi.json                 "Describes acquisition parameters related to the Nifti image"
│   │   ├── sub-01_dwi.bval                 "Describes the b-value for each diffusion gradient direction"
│   │   └── sub-01_dwi.bvec                 "Describes the diffusion gradient directions"
│   └── eeg
│       ├── sub-01_coordsystem.json         "Describes coordinate system, units, fiducials, anatomical landmarks location"
│       ├── sub-01_electrodes.tsv           "Location of electrodes expressed in the coordinate system and units described in _coordsystem.json file"
│       ├── sub-01_task-faces_channels.tsv  "List the channels"
│       ├── sub-01_task-faces_eeg.bdf       "Raw EEG data in .bdf format"
│       ├── sub-01_task-faces_eeg.json      "Describes acquisition parameters of the raw EEG data"
│       ├── sub-01_task-faces_events.tsv    "Table file that describes each event"
│       └── sub-01_task-faces_events.json   "Describes the columns of the _events.tsv table file"
└── derivatives                             "Stores the derivatives i.e. the data generated during the tutorials"

```

---

class: middle

## Tutorial and Requirements

- In this live tutorial, we will be using a sample of the publicly
 available `VEPCON` dataset. The data comes
 preloaded in the virtual machine of the summer school.

- To ensure you can follow along, please check that you have the
 virtual machine (VM) of the summer school running.

---

class: middle

## Exercise 1: Create a BIDS-compliant dataset

- The summer school sample dataset has been modified such that it does not comply anymore with the BIDS standard

- The goal of this exercise is to make this dataset compliant to the BIDS standard again

---

class: middle

## Store dataset path

- Store dataset path in `BIDS_DIR` environment variable
```
export BIDS_DIR="$HOME/Data/ds003505-sample"
```

---

class: middle

## Check the current file organization and naming

You can either use the command line
```
tree $BIDS_DIR
```

or use the graphical file manager.

---

class: middle

## Create the BIDS folder structure

- Create the BIDS folder structure `sub-01/anat` and `sub-01/dwi` for anatomical and diffusion MRI data
```
mkdir -p $BIDS_DIR/sub-01/anat;
mkdir -p $BIDS_DIR/sub-01/dwi;
```

---

class: middle

## Adopt BIDS file naming

- Rename demographical TSV and JSON table data accordingly to BIDS
```
mv $BIDS_DIR/subjects_demo.tsv $BIDS_DIR/participants.tsv
mv $BIDS_DIR/subjects_demo.tsv $BIDS_DIR/participants.json
```

- Rename and move anatomical and diffusion MRI data to `sub-01/anat` and `sub-01/dwi` accordingly to BIDS
```
mv $BIDS_DIR/T1w.nii.gz $BIDS_DIR/sub-01/anat/sub-01_T1w.nii.gz
mv $BIDS_DIR/T1w.json $BIDS_DIR/sub-01/anat/sub-01_T1w.json
mv $BIDS_DIR/diffusion.nii.gz $BIDS_DIR/sub-01/dwi/sub-01_dwi.nii.gz
mv $BIDS_DIR/diffusion.json $BIDS_DIR/sub-01/dwi/sub-01_dwi.json
mv $BIDS_DIR/diffusion.bval $BIDS_DIR/sub-01/dwi/sub-01_dwi.bval
mv $BIDS_DIR/diffusion.bvec $BIDS_DIR/sub-01/dwi/sub-01_dwi.bvec
```

---

class: middle

## Validate dataset with the bids-validator

- Validate the dataset with the online [`bids-validator`](https://bids-standard.github.io/bids-validator/):

---

class: middle

## Exercise 2: Manipulate the summerschool dataset in Python

class: middle

- The goal of this exercise is to learn about how to interact with the summerschool BIDS dataset in Python using the `pybids` library

---

class: middle

## Setup

- Open a terminal in the VM

- Launch ipython
```
ipython
```

- Import the BIDSLayout class from the pybids library
```python
from bids import BIDSLayout
```

---

class: middle

## Initialize a BIDSLayout object

- Initialize a BIDSLayout object with the path of summerschool sample dataset
```python
# Create the BIDSLayout object representing the summerschool sample dataset
layout = BIDSLayout("$HOME/Data/ds003505")
```

- You can print a general overview of the object using the `print()` method:
```
print(layout)
```

---

class: middle

## Get the list of T1w images available for sub-01

- Use the `get()` method to get the list of T1w images available for `sub-01`:
```python
# Get the list of T1w images available for sub-01
t1_files = layout.get(
  subject='01',
  extension='nii.gz',
  suffix='T1w',
  return_type='filename'
)
print(t1_files)
```

---

class: middle

## Get the list of the diffusion images available for sub-01

- Provide the argument of `get()` method in a python dictionary to get the list of the diffusion images available for `sub-01`:
```python
dwi_query = {
    "subject": "01",
    "extension": "nii.gz",
    "suffix": "dwi",
    "return_types": "filename"    
}
dwi_files = layout.get(**dwi_query)
print(dwi_files)
```

---

class: middle

## Get the EEG task list of sub-01

- Use the `get_tasks()` method to get the list of available tasks:
```python
eeg_tasks = layout.get_tasks()
```

---

class: middle

###  How can I convert to BIDS?

There exists a collection of different packages available for each neuroimaging modality:

- MRI: you will need to have access to raw data (e.g. dicoms) in order to perform the conversion and use a tool such as [dcm2bids](https://github.com/UNFmontreal/Dcm2Bids), [heudiconv](https://github.com/nipy/heudiconv)/[reproin](https://github.com/ReproNim/reproin), [bidscoin](https://github.com/Donders-Institute/bidscoin), [bidskit](https://github.com/jmtyszka/bidskit).

- EEG: you will need to have access to raw data in order to perform the conversion and use a tool such as [mne-bids](https://github.com/mne-tools/mne-bids), [Fieldtrip](https://github.com/fieldtrip/fieldtrip) [data2bids](https://www.fieldtriptoolbox.org/reference/data2bids/), [bids-matlab-tools EEGLab addon](https://github.com/sccn/bids-matlab-tools), [Brainstorm](https://neuroimage.usc.edu/brainstorm), [BrainVision bv2bids](https://pressrelease.brainproducts.com/bv2bids/).

- Physiological recordings: there exist [physio2bids](https://github.com/tarrlab/physio2bids) and [bidscoin](https://github.com/Donders-Institute/bidscoin) for data recorded with Siemens MRI scanner, and [phys2bids](https://github.com/physiopy/phys2bids) for data recorded by AcqKnowledge (BIOPAC) and Labchart (ADInstruments).

Admittingly, most BIDS converters require a bit of user input and work. A number of great tutorials are available online to help you getting started. Check the list of [selected tutorials](https://sinergia-connectomics-summerschool-2021.github.io/scss21-training/01-01-tuto1/#selected-external-tutorials) available online.

---

class: middle

# Questions?

If something is unclear, or you would like to contribute to this tutorial, please open an issue or pull request on our [Github repo](https://github.com/sinergia-connectomics-summerschool-2021/scss21-training)
