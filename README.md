![Vanderbilt Logo](Dimensional_V_Black_Lockup.png)

# VSS_2023_BRFS
VSS_2023_BRFS is the public repository for gnerating the 2023 VSS poster titled:
"Macaque V1 multi-unit-activity modulates with visual awareness during BRFS"
Brock M. Carlson, Blake A. Mitchell, Jacob A. Westerberg, & Alexander Maier.
Department of Psychology, College of Arts and Science, Vanderbilt Vision Research Center, 
Vanderbilt University, Nashville, TN 37235, USA

Corresponding author: brock.m.carlson@vanderbilt.edu

### Key Words: V1, binocular, interocular transfer of adaptations, laminar differences

## Abstract


# Instructions

## Setup
### Step 1. Download SfN_2022_IOT
Download the current release of SfN_2022_IOT from the [SfN_2022_IOT releases page](https://github.com/BrockMCarlson/SfN_2022_IOT/releases) 
```bash
git clone https://github.com/BrockMCarlson/VSS_2023_BRFS/.git
```
### Step 2. Set up home directories
```matlab
setup_VSS_2023_BRFS()
```
### Step 3. Load in data
For pre-processed data please contact brock.m.carlson@vanderbilt.edu
```matlab
cd(datadir)
load bmcBRFS_dataset.mat
```

## Data procesing
This repository is structrued in a model-viewer-controller framework. The idea is to create deep classes with minimal user interfaces. Functions in the "Model" folder interact with the database. Functions in the "Viewer" folder help generate visualization of the data. The "Controller" folder is where you will find the main scripts to run for this repository, handeling all data processing and visualization on the back-end.

Pre-processed data is available upon request. Once you have received the event-triggered MUA dataset, setupt your requiste home directoreis in setup_SfN_2022_IOT(). Then run visWithGramm_IOT.m to create all plots used on this year's SfN poster. The forJASP.txt output from this script can be used to run a repeated measures ANOVA in JASP. Between subject factors for individual multi-units and for laminar compartment hilight a significant affect of IOT across the laminar profile of V1.

This repository analyzes prelimnary data from 12 sessions in 1 monkey. Check back soon for updates with our 2nd monkey!

### Gramm toolbox
https://github.com/piermorel/gramm

### JASP toolbox
https://github.com/jasp-stats
