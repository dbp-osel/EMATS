# EMATS: EEG based Machine or Deep Learning Algorithms for TBI & Stroke Classification
Using the [Temple University EEG Corpus](https://isip.piconepress.com/projects/tuh_eeg/index.shtml) (TUEG) [1], we trained a series of classifcation models that can classify a 3-minute electroencephalogram (EEG) as either "Normal", "Stroke", or "TBI" as described in Vivaldi, Caiola, et al. 2021 [2] and Caiola and Ye 2023 [3].
> Michael Caiola (Michael.Caiola@fda.hhs.gov) and Meijun Ye (Meijun.Ye@fda.hhs.gov)

## Trained Models
- Short-time Fourier Transform [STFT] (AUC = 0.85)
- Topographic Map Network [TMN] (AUC = 0.76)
- Sensor Fusion (AUC = 0.81)
- Feature Network (AUC = 0.84)
- Support Vector Machine with Linear Discirminant Analysis selected features [LDA_SVM] (AUC = 0.81)
- Support Vector Machine with ReliefF selected features [ReliefF_SVM] (AUC = 0.85)

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
- [EEGLAB](https://sccn.ucsd.edu/eeglab/index.php) recommendations (needed for some training scripts and TMN) [4]
  - EEGLAB 2023.0
  - BIOsig 3.8.1
  - ICLabel 1.4
  - clean_rawdata 2.8
  - dipfilt 5.0
  - firfilt 2.7.1
    
### Sample Code
For usability, the following sample code has been provided
- testEEG.mat: a 3-minute EEG sample that has been preprocessed for use in our models. **Can be used directly in the Predict section of Run.mlx**


## Additional Code
  For reproducibility and additonal training, code has been provided for both preprocessing of TUEG EEG and model training.
  ### Preprocessing code:
  - PreGetData: Support function. Only needed if PreData2020122213119.xlsx is needed to be rerun.
    - Creates an excel spreadsheet from a local copy to the TUEG database v.1.1.0 and v.1.2.0
    - Output: PreData2020122213119.xlsx
  - PreRecordAnalysis
    - Compares RecordDatabase.mat vs Vivaldi (“Original”) Cohort, and Abnormal (“Lopez”) Cohort
    - Removes duplicates
    - Uses BERT for database predictions
    - Final Curation: Additional keywords & Age
    - Outputs: PredictionDatabase.mat
  - dreegstruc = PreDREEG(T,n,all_data)
    - Runs dimension reduction from table T with location field. This includes cleaning the data and running a subset of features
    - n denotes the amount of minutes the EEG is segmented into
    - All_data (default 0) can be set to 1 to run a larger collection of features
  - out = PreDREEGplot(dreegstruc,out,N)
    - Calculates 3D tSNE calculations and settings for the output of DREEG
    - Out can be blank or a previous generated out structure
    - N (default = 1000) is number of iterations of tSNE.
  - names = PreDREEGd(F,p)
    - Selects and plots the tSNE points in F (dreegstruc) at percentage p (default = 0.5) away from the center of mass. Names output denotes selected points.
  - PreDREEGexport2
    - Prepares and exports selected EEGs (saved as *_3F.mat in the workspace) from local TUEG database dump to usable EEG files. The files are all preprocessed (cleaned, segmented, filtered, reordered, resampled, etc.)
    - Estimated size: 88.7 GB
  - PreRecordDatabase.mat
    - 6688 EEG sessions and selected demographic fields extracted from the TUEG included .txt file. These have been manually marked as either “Normal”, “TBI”, “Stroke”, or “Unknown”.
    - Fields include:
      - Filename
      - Subject #
      - Session #
      - Category: Manually marked (see above)
      - Age
      - Sex
      - Medication #
      - “Plus other” flag: If the .txt indicated that there were other medications and they were not specified this flag was 1, else it was 0.
      - Full Note: The entire extracted .txt data
      - User Comments: Comments inputted by user conducting the Category manual marking.
  - PrePaper_Tables.mat
    - T_HEA: table
      - 121 Subject and Session #s
    - T_STR: table
      - 344 Subject and Session #s
    - T_TBI: table
      - 143 Subject and Session #s
  - PreData2020122213119.xlsx
    - Exported demographic spreadsheet of all TUEG EEG Sessions from v.1.1.0 and v.1.2.0. Output from PreGetData.m
  - PreLopezData.mat
    - EEGLAB (only necessary if using TMN)
  - Pretextnet.mat
  - PredictionDatabase.mat
  - CohortFiles


  ### Training code:
  - MatchSubjects
  - TrainFeatures
  - TrainTopo
  - TrainFusion
  - TrainSTFT
  - Sep22.mat
  - ReleifF_SVM.mat
  - LDA_SVM.mat
  - F_DL.mat
  - Chlocs2.mat
  - Topo_BasicNet.mat
  - TopoData2.mat
  - SFnet.mat
  - AllFeatures.mat
  - ReliefFScore.mat
  - MdlResults
  - TopoDatastore
  - ResampleDatastore
  ### Onnx Files:
  The four deep learning networks have been exported to ONNX file format for use outside of MATLAB. These networks have not been tested outside of MATLAB and may be missing MATLAB specific or custom layers. The following four networks can be found in the Exported Networks folder
  - FeatureNet.onnx
  - Fusion Net.onnx
  - STFTNet.onnx
  - TopoNet.onnx


## Disclaimer
This software and documentation (the "Software") were developed at the Food and Drug Administration (FDA) by employees of the Federal Government in the course of their official duties. Pursuant to Title 17, Section 105 of the United States Code, this work is not subject to copyright protection and is in the public domain. Permission is hereby granted, free of charge, to any person obtaining a copy of the Software, to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, or sell copies of the Software or derivatives, and to permit persons to whom the Software is furnished to do so. FDA assumes no responsibility whatsoever for use by other parties of the Software, its source code, documentation or compiled executables, and makes no guarantees, expressed or implied, about its quality, reliability, or any other characteristic. Further, use of this code in no way implies endorsement by the FDA or confers any advantage in regulatory decisions. Although this software can be redistributed and/or modified freely, we ask that any derivative works bear some notice that they are derived from it, and any modified versions bear some notice that they have been modified. 

## References
[1] Obeid, I., & Picone, J. (2016). The Temple University Hospital EEG Data Corpus. Frontiers in Neuroscience, Section Neural Technology, 10, 196.

[2] N. Vivaldi, M. Caiola, K. Solarana and M. Ye, "Evaluating Performance of EEG Data-Driven Machine Learning for Traumatic Brain Injury Classification," in IEEE Transactions on Biomedical Engineering, vol. 68, no. 11, pp. 3205-3216, Nov. 2021, doi: 10.1109/TBME.2021.3062502.

[3] M. Caiola and M. Ye, "EEG Classification of Traumatic Brain Injury and Stroke from a Nonspecific Population using Neural Networks" in PLOS Digital Health (in press) 2023.

[4] Delorme A & Makeig S (2004) EEGLAB: an open-source toolbox for analysis of single-trial EEG dynamics, Journal of Neuroscience Methods

