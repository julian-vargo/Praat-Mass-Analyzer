# Praat Mass Analyzer

**Praat Mass Analyzer** is a Praat script that automates the extraction of several acoustic measurements. This tool is designed for researchers and linguists who need to process large amounts of audio data efficiently. This Praat script is file batchable and operable on Windows, Mac, or any other operating system capable of running Praat.

## How to cite

Vargo, Julian (2025). Praat Mass Analyzer. [https://github.com/julian-vargo/Praat-Mass-Analyzer/]
Department of Spanish & Portuguese. University of California, Berkeley.

## Features

The script automatically collects the following parameters for each phone segment in a sound file:
- Formants (F1-F5)
- Pitch (F0)
- Formant Bandwidths (F1-F5)
- Formant Slope
- Harmonicity
- Intensity
- Intensity Max (One measurement)
- Intensity Min (One measurement)
- Max intensity of the current phone minus the minimum intensity of the previous phone (header name is intensity_difference)
- Preceding Phoneme
- Following Phoneme
- Phone Duration
- Jitter
- Shimmer
- Center of Gravity (one measurement taken for the entire phoneme)
- Center of Gravity Standard Deviation (one measurement taken for the entire phoneme)
- Skewness (one measurement taken for the entire phoneme)
- Kurtosis (one measurement taken for the entire phoneme)
  
## Notes
- *All point measurements are taken at the 10%, 20%, 30%... 90% portions of the phone, unless otherwise specified*
- *All interval measurements are taken at the 0%->10%, 10%->20%, ... , 90%->100% portions of the phone*
- *Time-aligned annotations are to be on the **second** tier of a .Textgrid file. To change which tier number you want, alter the last number on line 18.*
- *Designed on Praat version 6.4.17 (8 August 2024)*

## Contact
Julian Vargo | Department of Spanish & Portuguese | University of California, Berkeley | julianvargo@berkeley.edu

*Written on Praat version 6.4.25 (Boersma & Weenink 2024)*
*If you are having trouble getting this Praat script to work, please email me and I can arrange a time to assist you*
