# Praat Mass Analyzer

**Praat Mass Analyzer** is a single, easy-to-use Praat script that automates the extraction of several acoustic measurements. This tool is designed for researchers and linguists who need to process large amounts of audio data efficiently. This Praat script is file batchable and operable on Windows, Mac, or any other operating system capable of running Praat.

## How to cite

Vargo, Julian (2025). Praat Mass Analyzer. [https://github.com/julian-vargo/Praat-Mass-Analyzer/]
Department of Spanish & Portuguese. University of California, Berkeley.

## Features

The script automatically collects the following parameters for each phone segment in a sound file.
By default, each measurement is gathered at 10% intervals throughout each phone:
- Formants (F1-F5)
    - You can optionally gather formants using a Least Squares Linear Regression-based algorithm of the first three formants to optimize the smoothness of the LPC formant tracking.
    - This idea was based on Santiago Barreda's very elaborate FastTrack plugin for Praat, but I wanted to integrate a regression that could work within a single Praat script that also extracted non-formant measurements.  
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
- A1P0 (Difference of Amplitude of first formant minus the amplitude of the harmonic under the first formant)
  
## Notes
- *All point measurements are taken at the 10%, 20%, 30%... 90% portions of the phone, unless otherwise specified*
- *All interval measurements are taken at the 0%->10%, 10%->20%, ... , 90%->100% portions of the phone*
- *The script supports exporting information for between 1 and 3 textgrid tiers (obligatorily phone, optionally word, and optionally notes/task-type/speaker)*
- The optional LSRL formant tracking algorithm uses three formant-ceiling sweeps to narrow down on the perfect formant ceiling for a given sound. The formant tracking is pretty good, but it is at the expense of speed. I don't recommend using this algorithm for more than an hour of data at a time. Additionally, there are some issues with formant tracking at the 10% and 90% phoneme edges when using the regression optimization. 
- *Designed on Praat version 6.4.25*

## Contact
Julian Vargo | Department of Spanish & Portuguese | University of California, Berkeley | julianvargo@berkeley.edu

*Written on Praat version 6.4.25 (Boersma & Weenink 2024)*
*If you are having trouble getting this Praat script to work, please email me and I can arrange a time to assist you*
