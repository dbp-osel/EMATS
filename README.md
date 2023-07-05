# RST-TBI
Using the Temple University EEG Corpus (TUEG) [1], we trained a series of classifcation models that can classify a 3-minute electroencephalogram (EEG) as either "Normal", "Stroke", or "TBI" as described in Vivaldi, Caiola, et al. 2021 [2] and Caiola and Ye 2023 [3].

## Trained Models
- Short-time Fourier Transform [STFT] (AUC = )
- Topographic Map Network [TMN] (AUC = )
- Sensor Fusion (AUC = )
- Support Vector Machine with Linear Discirminant Analysis selected features [LDA_SVM] (AUC = )
- Support Vector Machine with ReliefF selected features [ReliefF_SVM] (AUC = )

## Instructions For Use
Easily classify a 3-minute EEG as Normal/Stroke/TBI with the use of the RUN.mlx live script.
The script consists of two parts:
  1) Preprocessing code. Transform an .edf file containing 4+ minutes of EEG on a standard 10-20 system with 19+ contacts into cleaned 3-minute EEG segments. (Note: The first minute is disgarded). This code saves the preprocessed files as .m files, making this step only necessary once.
  2) Model Prediction. Select one of 5 trained models (see above) to classify a preprocessed EEG as Normal/Stroke/TBI. Note: the SVM models require a calculation of features before classification.

To use:
- Download/clone this repo.
- Open RUN.mlx
- Follow instructions to preprocess the selected .edf file
- Select the model from the dropdown list

### Prerequisites
- MATLAB recommendations
  - MATLAB 9.14
  - Optimizaton Toolbox 9.5
  - Signal Processing Toolbox 9.2
  - Deep Learning Toolbox 14.6
  - Statistics and Machine Learning Toolbox 12.5
  - Parallel Computing Toolbox 7.8
- EEGLAB recommendations (needed for some training scripts and TMN)
  - EEGLAB 2023.0
  - BIOsig 3.8.1
  - ICLabel 1.4
  - clean_rawdata 2.8
  - dipfilt 5.0
  - firfilt 2.7.1
    
### Sample Code
For usability, the following sample code has been provided
- PreData
- testEEG


## Additional Code
  For reproducibility and additonal training, code has been provided for both preprocessing of TUEG EEG and model training.
  ### Preprocessing code:
    - PreDREEG
    - PreDREEGd
  ### Training code:
    - TrainXX


## Disclaimer


## References
[1] Obeid, I., & Picone, J. (2016). The Temple University Hospital EEG Data Corpus. Frontiers in Neuroscience, Section Neural Technology, 10, 196.

[2] N. Vivaldi, M. Caiola, K. Solarana and M. Ye, "Evaluating Performance of EEG Data-Driven Machine Learning for Traumatic Brain Injury Classification," in IEEE Transactions on Biomedical Engineering, vol. 68, no. 11, pp. 3205-3216, Nov. 2021, doi: 10.1109/TBME.2021.3062502.

[3] M. Caiola and M. Ye, "XX" in PLOS Digital Health (in press) 2023.

[4] Delorme A & Makeig S (2004) EEGLAB: an open-source toolbox for analysis of single-trial EEG dynamics, Journal of Neuroscience Methods
