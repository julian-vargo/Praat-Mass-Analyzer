# Praat Mass Analyzer

**Praat Mass Analyzer** is a single, easy-to-use Praat script that automates the extraction of several acoustic measurements. This tool is designed for researchers and linguists who need to process large amounts of audio data efficiently. This Praat script is file batchable and operable on Windows, Mac, or any other operating system capable of running Praat. This script supports the use of multiple CPU cores.

## Instructions

Place your TextGrid and wav files into a single folder containing no other files. Make sure that your wav and TextGrid files have the same exact basename (eg., sound1.wav & sound1.TextGrid will be paired up together). Once you're ready, run the script in Praat and follow the pop-up menus for further instructions. For large file batches, the script can take a while, but it will play a ringtone when complete. Additionally, the Praat info menu will inform you when the script is complete running.

warning: The script will only read files from the folder directory that you supply it. If you add audio or TextGrids into the Praat objects manually, the script will not bother reading these.
warning: If you have wav files without TextGrids or vice-versa, the script may misprocess your analysis. Make sure that the input directory/folder contains only the files you wish for the script to read.

A CSV file, separated by regular commas "," will be generated as a single output file to the file-path of your choosing. The CSV generation will overwrite any previously existing files of the same name.

Please supply *full file paths* for all of your inputs.

Windows example: C:\Users\julian\Downloads\audio_and_textgrid_input_folder

Mac example: /Users/julian/Desktop/audio_and_textgrid_input_folder

## How to cite

Vargo, Julian (2025). Praat Mass Analyzer. [https://github.com/julian-vargo/Praat-Mass-Analyzer/]
Department of Spanish & Portuguese. University of California, Berkeley.

## Features

The script automatically collects the following parameters for each phone segment in a sound file.
By default, each measurement is gathered at 10% intervals throughout each phone:
- Formants (F1-F5), both lpc (standard) and ltas versions
- Pitch (F0), lpc and ltas
- Formant Bandwidths (F1-F5)
- Harmonicity
- Intensity
- Intensity Max (One measurement)
- Intensity Min (One measurement)
- Max intensity of the current phone minus the minimum intensity of the previous phone (header name is intensity_difference) Bongiovanni (2015).
- Preceding Phoneme
- Following Phoneme
- Phone Duration
- Jitter
- Shimmer
- Center of Gravity
- Center of Gravity Standard Deviation
- Skewness
- Kurtosis
### Voice features (beta)
- Several P0 and P1 nasal amplitude and nasal frequency measurements from various papers by Styler (2017), Chen (1997), Pruthi & Espy-Wilson(2004 & 2007)
- H1-through-H5 frequency & amplitude
- Amplitudes from 1k-through-5k
- RMS Energy
 
## Notes and additional features
- *All point measurements are taken at the 10%, 20%, 30%... 90% portions of the phone, unless otherwise specified*
- *All interval measurements are taken at the 0%->10%, 10%->20%, ... , 90%->100% portions of the phone*
- *The script supports exporting information for between 1 and 4 textgrid tiers (obligatorily phone, optionally word, and optionally notes/task-type/speaker)*
- Built-in Mac/Windows/Linux support
- Multiple CPU cores at once, see developer_tools/README.md

## Contact
Julian Vargo | Department of Spanish & Portuguese | University of California, Berkeley | julianvargo@berkeley.edu

*Written on Praat version 6.4.48, released 9 December 2025 on ARM64 Windows (Boersma & Weenink 2025)*

*Script last updated 22 December 2025*

*If you are having trouble getting this Praat script to work, please email me and I can arrange a time to assist you*

If you'd like to request a new feature for this Praat script, please let me know! Feedback is always appreciated.
