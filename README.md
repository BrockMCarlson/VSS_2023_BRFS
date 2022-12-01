![Vanderbilt Logo](Dimensional_V_Black_Lockup.png)

# SfN_2022_IOT
SFN_2022_IOT is the public repository for gnerating the 2022 SfN poster titled:
"Interocular transfer of adaptation primarily modulates the infragranular layers of V1"
Brock M. Carlson, Blake A. Mitchell, Jacob A. Westerberg, & Alexander Maier.
Department of Psychology, College of Arts and Science, Vanderbilt Vision Research Center, 
Vanderbilt University, Nashville, TN 37235, USA

Corresponding author: brock.m.carlson@vanderbilt.edu

### Key Words: V1, binocular, interocular transfer of adaptations, laminar differences

## Abstract
Visual adaptation can have profound effects for a viewer’s perceptual state. Some of the main perceptual effects of visual adaptation include motion aftereffects, decreased contrast sensitivity, and the tilt illusion. Interestingly, all these forms of adaptation are phenomenologically effective even if an interocular transfer of adaptation (IOT) paradigm is used. IOT refers to visually adapting one eye with a monocular stimulus and then presenting the test stimulus monocularly to the other eye. Primary visual cortex (V1) has been identified as a locus for IOT effects, but the spatiotemporal mechanism mediating IOT in V1 remains unknown. We evaluated IOT in awake behaving macaques by having them passively view static sinusoidal gratings through a mirrored stereoscope. We performed electrophysiology recordings in V1 via acute laminar penetrations. Cortical depth was determined by profiling the multi-unit-activity, current source density, and power spectral density across the laminar electrode. Orthogonal penetrations were verified by observing overlapping receptive fields across the laminar profile of V1. We found that adapting a static grating to one eye for 800ms and then presenting an identical stimulus to the other eye resulted in a decrease of cortical activity. This decrease in activity was observed as compared to monocular stimulation. 77 multi-units were binned into their laminar compartments of upper, middle, and deep cortical layers. The laminar compartments were then evaluated with a repeated measures ANOVA to compare the effect of IOT on V1 multi-unit response rates. There was a statistically significant difference in response rates between at least two groups (F2,40 = 31.625, p < 0.001, ω2  = 0.386). A post-hoc Holm’s corrected test showed that the deep layers significantly differed from the middle layers (t = -7.676, pholm < 0.001, Cohen’s d = -1.906)) and upper layers (t = -5.641, pholm < 0.001, Cohen’s d = -1.401)), while the upper and middle layers did not significantly differ from each other. Bayesian repeated measures ANOVA produced identical results. Taken together, we observed the largest IOT effect in the infragranular layers, suggesting a laminar mechanism for IOT in macaque V1. We will discuss these results and their implications on a potential laminar mechanism for binocular rivalry.

# Instructions

## Setup
### Step 1. Download SfN_2022_IOT
Download the current release of SfN_2022_IOT from the [SfN_2022_IOT releases page](https://github.com/BrockMCarlson/SfN_2022_IOT/releases) 
```bash
git clone https://github.com/BrockMCarlson/SfN_2022_IOT/.git
```
### Step 2. Set up home directories
```matlab
setup_SfN_2022_IOT()
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
