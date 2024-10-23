# Praat Mass Analyzer

**Praat Mass Analyzer** is a Python script that automates the extraction of various acoustic measurements using Praat. This tool is designed for researchers and linguists who need to process large amounts of audio data efficiently. 

## Features

The script automatically collects the following parameters for each phone segment in a sound file:
- **Formants (F1-F5)**
- **Pitch (F0)**
- **Formant Bandwidths (F1-F5)**
- **Formant Slope**
- **Harmonicity**
- **Intensity**
- **Preceding Phoneme**
- **Following Phoneme**
- **Phone Duration**
- **Jitter**

- *All point measurements are taken at the 10%, 20%, 30%... 90% portions of the phone*
- *All interval measurements are taken at the 0%->10%, 10%->20%, ... , 90%->100% portions of the phone*
- *Time-aligned annotations are to be on the **second** tier of a .Textgrid file*

- *Designed on Praat version 6.4.17 (8 August 2024)*
