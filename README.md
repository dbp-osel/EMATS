# EMATS: EEG based Machine or Deep Learning Algorithms for TBI & Stroke Classification
Using the [Temple University EEG Corpus](https://isip.piconepress.com/projects/tuh_eeg/index.shtml) (TUEG) [1], we trained a series of classification models that can classify a 3-minute electroencephalogram (EEG) as either "Normal", "Stroke", or "TBI" as described in Vivaldi, Caiola, et al. 2021 [2] and Caiola and Ye 2023 [3].
> Michael Caiola (Michael.Caiola@fda.hhs.gov) and Meijun Ye (Meijun.Ye@fda.hhs.gov)

# Regulatory Science Tool (RST) Reference
•	RST Reference Number: RST24NO03.01  
•	Date of Publication: 02/07/2024  
•	Recommended Citation: U.S. Food and Drug Administration. (2024). EEG based Machine or Deep Learning Algorithms for TBI & Stroke Classification (EMATS) (RST24NO03.01). https://cdrh-rst.fda.gov/eeg-based-machine-or-deep-learning-algorithms-tbi-stroke-classification-emats  

# Disclaimer
**About the Catalog of Regulatory Science Tools**  
The enclosed tool is part of the Catalog of Regulatory Science Tools, which provides a peer- reviewed resource for stakeholders to use where standards and qualified Medical Device Development Tools (MDDTs) do not yet exist. These tools do not replace FDA-recognized standards or MDDTs. This catalog collates a variety of regulatory science tools that the FDA's Center for Devices and Radiological Health's (CDRH) Office of Science and Engineering Labs (OSEL) developed. These tools use the most innovative science to support medical device development and patient access to safe and effective medical devices. If you are considering using a tool from this catalog in your marketing submissions, note that these tools have not been qualified as Medical Device Development Tools and the FDA has not evaluated the suitability of these tools within any specific context of use. You may request feedback or meetings for medical device submissions as part of the Q-Submission Program.  
For more information about the Catalog of Regulatory Science Tools, email OSEL_CDRH@fda.hhs.gov.  


## Trained Models
- Short-time Fourier Transform [STFT] (AUC = 0.85)
- Topographic Map Network [TMN] (AUC = 0.76)
- Sensor Fusion (AUC = 0.81)
- Feature Network (AUC = 0.84)
- Support Vector Machine with Linear Discirminant Analysis selected features [LDA_SVM] (AUC = 0.81)
- Support Vector Machine with ReliefF selected features [ReliefF_SVM] (AUC = 0.85)

## Instructions For Use
Prediction of a 3-minute EEG as Normal/Stroke/TBI with the use of the RUN.mlx live script.

**Disclaimer: This code is not intended to make clinical diagnoses or to be used in any way to diagnose or treat subjects for whom the EEG is taken.**

The script consists of two parts:
  1) Preprocessing code. Transform an .edf file containing 4+ minutes of EEG on a standard 10-20 system with 19+ contacts into cleaned 3-minute EEG segments. (Note: The first minute is discarded). This code saves the preprocessed files as .m files, making this step only necessary once.
  2) Model Prediction. Select one of 6 trained models (see above) to classify a preprocessed EEG as Normal/Stroke/TBI. Note: the SVM models require an automatic calculation of features before classification.

*WARNING: EEG classification is set using default thresholding and should be further optimized for sensitivity/specificity/accuracy on additional training data prior to use.*

<details>
  <summary>EEG Channels Required</summary>
  The following EEG channels are needed (see chlocs2.mat for more info): "FP1",    "FP2",    "F3",    "F4",    "C3",    "C4",    "P3",    "P4",    "O1",    "O2",    "F7",    "F8",    "T3/T7",    "T4/T8",    "T5/P7",    "T6/P8",   "Fz",    "Cz",    "Pz"

</details>

To use:
1.  [Download](https://docs.github.com/en/repositories/working-with-files/using-files/downloading-source-code-archives) or [clone](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) this repo.
2.  Select the repo as the current MATLAB Folder
3.  Open **RUN.mlx**
4.  Follow instructions to preprocess the selected .edf file
5.  Select the model from the dropdown list to classify the preprocessed file

### Prerequisites
- MATLAB recommendations
  - MATLAB 9.14
  - Optimization Toolbox 9.5
  - Signal Processing Toolbox 9.2
  - Deep Learning Toolbox 14.6
  - Statistics and Machine Learning Toolbox 12.5
  - Parallel Computing Toolbox 7.8
- [EEGLAB](https://sccn.ucsd.edu/eeglab/index.php) recommendations (used for training scripts, feature calculation, preprocessing, and TMN) [4]
  - EEGLAB 2023.0
  - BIOsig 3.8.1
  - ICLabel 1.4
  - clean_rawdata 2.8
  - dipfilt 5.0
  - firfilt 2.7.1
    
### Sample Code
For testing, the following sample code has been provided in the "Processed EEG" folder:

**testEEG.mat**: a 3-minute EEG sample that has been preprocessed for use in our models.

*This can be used directly in the Predict section of Run.mlx*


## Advanced Code
  For reproducibility and additional training, code has been provided for both preprocessing (Pre* scripts) of TUEG EEG and model training (Train* scripts).
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
    - N (default = 1000) is number of iterations of tSNE
  - names = PreDREEGd(F,p)
    - Selects and plots the tSNE points in F (dreegstruc) at percentage p (default = 0.5) away from the center of mass. Names output denotes selected points
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
    - 2993 selected files and if they were identified as “Abnormal” or “Normal” [5]
  - Pretextnet.mat
    - net: SeriesNetwork
      - Trained net used on the BERT embeddings
  - PredictionDatabase.mat
    - T: table
      - 19449 EEG Sessions and selected demographic fields extracted from the TUEG included .txt file. These have been predicted by net as either “Normal”, “TBI”, “Stroke”, or “Unknown”.
      - Fields include:
        - FileID
        - File Location
        - Subject #
        - Session #
        - Flag for TBI keywords: Empty if not TBI keywords, else the keywords are included here
        - Age
        - Sex
        - mTBIEvidence: Localized txt data for the TBI flag. Empty if flag is empty
        - Method: Extracted Method section of the .txt file.
        - Medication text: Extracted Medication section of the .txt file
        - Full Note: The entire extracted .txt data
        - Montage of EEG
        - Date of recording
        - EEG Type
        - EEG Subtype
        - LTM/Routine
        - Filenames
        - Category: Predicted categories from net
        - Score: Prediction score from net
    - net: SeriesNetwork
      - Trained net used on the BERT embeddings. This is imported from textnet.mat unless retrained in the script
    - PredictedFiles: CohortFiles
      - The table T, converted to a CohortFiles class. This allows some visualization functions such as wordclouds
  - CohortFiles: Class
    - A selection of files and functions to better use files associated with cohorts and to read the medical txt files associated with TUEG.


  ### Training code
  - MatchSubjects
    - Function to match normal and stroke subjects to the TBI cohort using gender and age. 
  - TrainFeatures
    - Live script used to train networks with feature data.
  - TrainTopo
    - Live script used to train topographic map network
  - TrainFusion
    - Live script used to train sensor fusion network
  - TrainSTFT
    - Live script used to train the Short Time Fourier Transform network
  - Sep22.mat
    - Generated list of file locations and categories. This can be extracted from the output structure given in PreDREEGexport2
  - ReliefF_SVM.mat
    - Trained SVM on top 100 features identified by ReliefF
  - LDA_SVM.mat
    - Trained SVM using LDA feature selection
  - F_DL.mat
    - Collection of deep learning networks trained on 100 ReliefF features
  - chlocs2.mat
    - EEG channel locations
  - Topo_BasicNet.mat
    - Trained TMN 
  - SFnet.mat
    - Trained sensor fusion network
  - AllFeatures.mat
    - Calculated features and LDA thresholds
  - ReliefFScore.mat
    - Ranked Features using ReliefF
  - MdlResults: class
    - Shared functions for ML/DL models
  - TopoDatastore: class
    - Custom datastore to read in data from file structure for TMN
  - ResampleDatastore: class
    - Custom datastore to read in data from file structure for other DL nets
  
  ### Onnx Files
  The four deep learning networks have been exported to ONNX file format for use outside of MATLAB. These networks have not been tested outside of MATLAB and may be missing MATLAB specific or custom layers. The following four networks can be found in the Exported Networks folder
  - FeatureNet.onnx
  - Fusion Net.onnx
  - STFTNet.onnx
  - TopoNet.onnx


## Disclaimer
This software and documentation (the "Software") were developed at the Food and Drug Administration (FDA) by employees of the Federal Government in the course of their official duties. Pursuant to Title 17, Section 105 of the United States Code, this work is not subject to copyright protection and is in the public domain. Permission is hereby granted, free of charge, to any person obtaining a copy of the Software, to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, or sell copies of the Software or derivatives, and to permit persons to whom the Software is furnished to do so. FDA assumes no responsibility whatsoever for use by other parties of the Software, its source code, documentation or compiled executables, and makes no guarantees, expressed or implied, about its quality, reliability, or any other characteristic. Further, use of this code in no way implies endorsement by the FDA or confers any advantage in regulatory decisions. Although this software can be redistributed and/or modified freely, we ask that any derivative works bear some notice that they are derived from it, and any modified versions bear some notice that they have been modified. 
The Software reflects the views of the authors and should not be construed to represent the FDA’s views or policies. The mention of commercial products, their sources, or their use in connection with material reported herein is not to be construed as either an actual or implied endorsement of such products by the Department of Health and Human Services.
The Software is not intended to make clinical diagnoses or to be used in any way to diagnose or treat subjects for whom the EEG is taken.

## References
[1] Obeid, I., & Picone, J. (2016). The Temple University Hospital EEG Data Corpus. Frontiers in Neuroscience, Section Neural Technology, 10, 196.

[2] N. Vivaldi, M. Caiola, K. Solarana and M. Ye, "Evaluating Performance of EEG Data-Driven Machine Learning for Traumatic Brain Injury Classification," in IEEE Transactions on Biomedical Engineering, vol. 68, no. 11, pp. 3205-3216, Nov. 2021, doi: 10.1109/TBME.2021.3062502.

[3] Caiola M, Babu A, Ye M (2023) EEG classification of traumatic brain injury and stroke from a nonspecific population using neural networks. PLOS Digital Health 2(7): e0000282. https://doi.org/10.1371/journal.pdig.0000282

[4] Delorme A & Makeig S (2004) EEGLAB: an open-source toolbox for analysis of single-trial EEG dynamics, Journal of Neuroscience Methods

[5] Lopez, S. (2017). Automated Identification of Abnormal EEGs. Temple University.
