name: inverse
layout: true
class: center, middle, inverse

---

# Tutorial 01: Brain Imaging Data Structure

### sebastien.tourbier@alumni.epfl.ch  |  CC-BY

.footer[<img src="https://sinergia-connectomics-summerschool-2021.github.io/img/SummerSchool2021_website_logo.png" height="80"><img src="https://sinergia-connectomics-summerschool-2021.github.io/img/logo_sponsors.png" height="80">]

---

layout: false

## What is Brain Imaging Data Structure?

- Brain Imaging Data Structure (`BIDS`) is a file organization and naming scheme for neuroimaging data

- Originally developed for MRI data, extended to MEG and EEG

---

## Tutorial and Requirements

- In this live tutorial, we will be using a sample of the publicly
 available `VEPCON` dataset. The data comes
 preloaded in the virtual machine of the summer school.

- To ensure you can follow along, please check that you have the
 virtual machine (VM) of the summer school running.

---

## Exercise 1: Create a BIDS-compliant dataset

- The summer school sample dataset has been modified such that it does not comply anymore with the BIDS standard

- The goal of this exercise is to make this dataset compliant to the BIDS standard again

---

### Store dataset path

- Store dataset path in `BIDS_DIR` environment variable
```
export BIDS_DIR="$HOME/Data/ds003505-sample"
```

---

### Check the current file organization and naming

You can either use the command line
```
tree $BIDS_DIR
```

or use the graphical file manager.

---

### Create the BIDS folder structure

- Create the BIDS folder structure `sub-01/anat` and `sub-01/dwi` for anatomical and diffusion MRI data
```
mkdir -p $BIDS_DIR/sub-01/anat;
mkdir -p $BIDS_DIR/sub-01/dwi;
```

---

### Adopt BIDS file naming



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

### Validate dataset with the `bids-validator`

- Validate the dataset with the online [`bids-validator`](https://bids-standard.github.io/bids-validator/):

---

## Exercise 2: Manipulate the summerschool dataset in Python

- The goal of this exercise is to learn about how to interact with the summerschool BIDS dataset in Python using the `pybids` library

---

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

## Get the list of T1w images available for `sub-01`

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

## Get the list of the diffusion images available for `sub-01`

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

## Get the EEG task list of `sub-01`

- Use the `get_tasks()` method to get the list of available tasks:
```python
eeg_tasks = layout.get_tasks()
```

---

# Questions?

If something is unclear, or you would like to contribute to this tutorial, please open an issue or pull request on our [Github repo](https://github.com/sinergia-connectomics-summerschool-2021/scss21-training)
