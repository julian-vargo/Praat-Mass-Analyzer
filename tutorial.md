# Praat Mass Analyzer Tutorial

## For Most Users (not command line users):

1) Download the Praat Mass Analyzer Script

{TODO: embed the link}

 https://raw.githubusercontent.com/julian-vargo/Praat-Mass-Analyzer/refs/heads/main/mass_analyzer.praat
 
 2) Place all of your .wav and .TextGrid files into a single single folder on your computer
 
 Make sure that the file names for the .wav and .TextGrid files match *exactly*
 
 Example: interview1.wav, interview1.TextGrid, interview2.wav, interview2.TextGrid
 
 3) Make sure that the structure of your TextGrids is correct.
 
 - To run the analyzer, all you need is a wav file with a phone-level-aligned TextGrid
 - The TextGrid and sound can be as long as you want, processing times just take longer
 - The script can optionally gather data on the words, or other tiers that simultaneously occur with your phone
 - Make sure that all files have your phone alignments on the *same tier*
	- This means that files such as interview1.TextGrid and interview2.TextGrid should have their phones at identical tier numbers. Whether you choose to make your phone-level-tier as the first, second, or nth tier is unimportant. They just need to share the same tier number
- Word level or other miscellaneous tiers that you choose to extract must have a consistent tier number across all TextGrids
 
 {Insert Picture Here, I'll need to make a folder like /developer_tools/images}
 
 4) Open up mass_analyzer.praat in the Praat application.
 - option 1: open Praat > Open > Read From File > select mass_analyzer.praat
 - option 2: open File Explorer (Windows/Linux) or Finder (Mac) > right click mass_analyzer.praat > open with Praat
 - You should see a script window pop up called *Script "path_to_script/mass_analzyer.praat"*
 
 5) Run mass_analyzer.praat
 - option 1: in the script window, click "Run"
 - option 2: Ctrl + r (windows/linux), Cmd + r (Mac)
 - The mass analyzer main page should open a page called "Run script:..."
 
 6) Skip past the main page
 = Do not select Developer mode
 - Do not change number of cpu cores or process index
 - These settings only work for command line users
 - Once you click Apply or OK, you'll move to the next page
 
 7) Core Arguments
 - Enter the file folder path where all of your audio and TextGrids are located
 Windows Example: "C:\Users\vargo\audio_textgrid_folder"
 Mac/Linux Example: "/Users/vargo/audio_textgrid_folder"
 
 - Enter in the desired file path where you want your csv file to appear
 - This will create a *new* csv file or overwrite a previous csv file of the same name.
  Windows Example: "C:\Users\vargo\output_dataset.csv"
 Mac/Linux Example: "/Users/vargo/output_dataset.csv"
 
 - Enter the phone-level tier that is shared by all of your TextGrid files
 
 - Optionally, enter in the word-level or miscellaneous tiers that are shared by all of your TextGrid files. If you don't care about gathering word or other tier information, or if it doesn't apply to your TextGrids, leave these lines as "0" so the script knows to skip them.
 
 - If you use a Windows computer, check the "I am using a Windows computer option". If not, uncheck this box.
 
 - Click *Submit and Continue to Next Page* to move on
 
 8) Select which acoustics you want to analyze
 - Select the check boxes for the acoustics you want to gather
 - See this page for information on what each box gathers
 - Click *Submit and Continue to Next Page* when you are ready
 
 9) Select which phonemes you want to analyze
 - Leave "Phonemes to be analyzed" blank if you want to analyze all phonemes in your TextGrid
 - I suggest that most people do not change these settings
 - If you only want to extract acoustics on a particular phoneme class, type in the list of phones that you want to analyze
 - This line performs a regex search on your phoneme tier
 - Comma or space separation is optional
, checking whether a phoneme in question is in the list
 Example 1: "aeiou" would extract phonemes a, e, i, o, u, ae, ei, etc.
 Example 2: "AE1AE2" would extract phonemes A, E, AE1, or AE2"
 
10) Advanced Settings
- If you selected that you wanted things like jitter, shimmer, voice analysis, pitch, formants, etc., the advanced settings window will appear.
- Enter your desired formant cielings, pitch floor and cieling, etc.
- Once you've adjusted settings to your liking, click *Submit and Continue to Next Page*

11) Voice Analysis Settings
- If you chose to do a voice analysis, enter your desired voice settings
= Continue to the next page

12) Wait while your data gathers
- A window called "Praat Info" should appear
- After the first file in your folder is done runnning, an estimate of the amount of processing time will appear
- long files (greater than 30 minutes) can take a while to run. Please be patient!
- Older computers or computers with little available RAM will benefit from breaking audio/textgrid pairs into chunks less than 30 minutes long.
- If Praat freezes or stops responding, don't worry!
- Corpora more than 100 hours can take between hours and days to finish
- Lots of small audio will run faster than a few big audio files
- Once the script is done, a message will appear in the info window

13) Open up your acoustics spreadsheet
- Go to the file path where you wanted your csv to write
- If the csv file is over 1GB, don't open the file!
- Big csv files can crash your computer
- I suggest using the arrow package in R, or the arrow library in Python to convert your csv file into a compressed parquet or feather file. Arrow, and compressed binary spreadsheets, are only necessary when dealing with very large datasets.

14) All done!
- Please cite the Praat Mass Analyzer!
- See the youtube tutorial for more help {link!}
- email julianvargo[æt]berkeley[dɑt]edu if you would like to arrange a time for me to assist you with your analysis
- Happy Praating