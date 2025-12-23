# Praat Mass Analyzer Tools for Command Line Users

## Multiprocessing
- Clone the repository to your computer
- In windows_threading.bat , enter the file path to Praat.exe and the number of logical processors that you want Praat to use.
- Windows_threading.bat currently uses relative file paths to locate praat_mass_analyzer in the directory above the batch script.
- To configure your acoustic extraction variables and file paths, open praat_mass_analyzer.praat and configure your variables at the top of the script.
- Run the batch file

## Corpus structure

```
developer_tools
│   windows_threading.bat
│
└───test_dataset
    │   output.csv
    │
    └───input_folder
            audio1.TextGrid
            audio1.wav
            audio2.TextGrid
            audio2.wav
            caught.TextGrid
            caught.wav
            caught2.TextGrid
            caught2.wav
```
