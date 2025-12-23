# COMMAND LINE USERS: CONFIGURE YOUR VARIABLES HERE

    # Main arguments, use forward slashes for Mac or Unix systems
    input_folder$ = "C:\Users\...\subfolder\input_folder"
    csv_file_path$ = "C:\Users\...\spreadsheets\output.csv"

    # Tiers: phone is mandatory. Use 0 to ignore for other tiers such as word, speaker, notes, task_type
    phone_tier_number = 2
    word_tier_number = 1
    miscellaneous_tier_number = 0
    miscellaneous_second_tier_number = 0

    # What features to extract
    i_want_formants = 1
    i_want_pitch=1
    i_want_harmonicity=1
    i_want_intensity=1
    i_want_jitter_and_shimmer=1
    i_want_fricative_measurements=1
    i_want_A1P0=1
    i_want_voice_quality=1

    # Feature configuration - more feature flexibility coming soon
    pitch_floor = 50
    pitch_ceiling = 800
    formant_ceiling = 5500
    formant_timestep = 0.025

    # 1 means true
    i_am_using_a_Windows_computer = 1

# START OF MAIN SCRIPT
#########################################
form: "Vargo 2025 - Praat Mass Analyzer User Interface"
    comment: "How to cite: Vargo, Julian (2025). Praat Mass Analyzer [Praat Script]."
    comment: "Department of Spanish & Portuguese. UC Berkeley."
    comment: ""
    comment: "Please proceed to next page to begin."
    comment: ""
    comment: "-----"
    comment: "Advanced settings: Do not use with user interface."
    boolean: "Developer mode", "0"
    integer: "Number of cpu cores", "0"
    integer: "Process index", "0"
endform

if developer_mode = 0
    number_of_cpu_cores = 1
    process_index = 1
endif

if developer_mode = 0
    beginPause: "Core Arguments"
        comment: "Please enter the file path where your TextGrids and Sounds are located."
        sentence: "Input folder", "C:\Users\julia\Downloads\Praat-Mass-Analyzer\developer_tools\test_dataset\input_folder"
        comment: "Please insert the desired file path and name of your output .csv file."
        comment: "This script writes the csv file for you, so you just need to supply a path."
        sentence: "Csv file path", "C:\Users\julia\Downloads\Praat-Mass-Analyzer\developer_tools\test_dataset\output.csv"
        comment: "Which tier number is the tier containing your phonemes/phones of interest?"
        integer: "Phone tier number", 2
        comment: "Which tier number is your word tier? Leave as 0 if none."
        integer: "Word tier number", 1
        comment: "If you'd like details from a third tier, which number is it? Leave as 0 if none."
        integer: "Miscellaneous tier number", 0
        integer: "Miscellaneous second tier number", 0
        boolean: "I am using a Windows computer", 1
    clicked = endPause: "Submit and Continue to Next Page", 1

    beginPause: "Enter in the variables you want to measure"
        boolean: "I want formants", 1
        boolean: "I want pitch", 1
        boolean: "I want harmonicity", 1
        boolean: "I want intensity", 1
        boolean: "I want jitter and shimmer", 1
        boolean: "I want fricative measurements", 1
        boolean: "I want A1P0", 1
        boolean: "I want voice quality", 1
    clicked = endPause: "Submit", 1

    beginPause: "Advanced settings"
        positive: "Pitch floor", 50
        positive: "Pitch ceiling", 800
        positive: "Formant ceiling", 5500
        positive: "Formant timestep", 0.025
    clicked = endPause: "Submit", 1
endif

# Initialize a clock for identifying bottlenecks
runtimer = clock()

if process_index = 1
    writeInfoLine: "Initializing Praat Mass Analyzer"
    appendInfoLine: newline$, "Vargo, Julian (2024). Praat Mass Analyzer [Computer Software]"
    appendInfoLine: "University of California, Berkeley. Department of Spanish & Portuguese"
    appendInfoLine: newline$, "This script will take a while to run while measurements are gathered."
    appendInfoLine: "Do not exit the program."
    appendInfoLine: newline$, "Your output file will appear at ", csv_file_path$
endif

# Strip quotation marks from file paths. Makes the script more flexible for the user.
quote$ = """"
input_folder$ = replace$(input_folder$, quote$, "", 0)
csv_file_path$ = replace$(csv_file_path$, quote$, "", 0)

csv_process_index$ = "_" + string$(process_index) + "."
if number_of_cpu_cores > 1
    csv_file_path$ = replace$(csv_file_path$, ".", csv_process_index$, 0)
endif

# This makes your script file-folder batchable. Backslashes only work on windows and forward slashes are for mac.
# Praat needs to know whether your operating system uses forward slashes or backslashes
# Otherwise it can't read the file from your computer
if i_am_using_a_Windows_computer = 1    
    fileList = Create Strings as file list: "fileList", input_folder$ + "\" +"*.TextGrid"
    numberOfFiles = Get number of strings
else
    fileList = Create Strings as file list: "fileList", input_folder$ + "/" +"*.TextGrid"
    numberOfFiles = Get number of strings
endif

# Construct headers for csv
header$ = ""
if numberOfFiles > 1
    header$ = "file_name,"
endif
header$ = header$ + "start_time,end_time,phoneme"

if word_tier_number <> 0
    header$ = header$ + ",word"
endif

if miscellaneous_tier_number <> 0
    header$ = header$ + ",misc_tier"
endif

if miscellaneous_second_tier_number <> 0
    header$ = header$ + ",misc_tier_b"
endif

header$ = header$ + ",preceding_phone,following_phone"

if i_want_pitch = 1
    header$ = header$ + ",f0_10,f0_20,f0_30,f0_40,f0_50,f0_60,f0_70,f0_80,f0_90"
endif
if i_want_formants = 1
    header$ = header$ + ",f1_10,f1_20,f1_30,f1_40,f1_50,f1_60,f1_70,f1_80,f1_90,f2_10,f2_20,f2_30,f2_40,f2_50,f2_60,f2_70,f2_80,f2_90,f3_10,f3_20,f3_30,f3_40,f3_50,f3_60,f3_70,f3_80,f3_90,f4_10,f4_20,f4_30,f4_40,f4_50,f4_60,f4_70,f4_80,f4_90,f5_10,f5_20,f5_30,f5_40,f5_50,f5_60,f5_70,f5_80,f5_90,bw1_10,bw1_20,bw1_30,bw1_40,bw1_50,bw1_60,bw1_70,bw1_80,bw1_90,bw2_10,bw2_20,bw2_30,bw2_40,bw2_50,bw2_60,bw2_70,bw2_80,bw2_90,bw3_10,bw3_20,bw3_30,bw3_40,bw3_50,bw3_60,bw3_70,bw3_80,bw3_90,bw4_10,bw4_20,bw4_30,bw4_40,bw4_50,bw4_60,bw4_70,bw4_80,bw4_90,bw5_10,bw5_20,bw5_30,bw5_40,bw5_50,bw5_60,bw5_70,bw5_80,bw5_90"
endif
if i_want_harmonicity = 1
    header$ = header$ + ",harmonicity_10,harmonicity_20,harmonicity_30,harmonicity_40,harmonicity_50,harmonicity_60,harmonicity_70,harmonicity_80,harmonicity_90"
endif
if i_want_intensity = 1
    header$ = header$ + ",intensity_10,intensity_20,intensity_30,intensity_40,intensity_50,intensity_60,intensity_70,intensity_80,intensity_90,intensity_100,intensity_max,intensity_min,intensity_difference"
endif
if i_want_jitter_and_shimmer = 1
    header$ = header$ + ",jitter_10,jitter_20,jitter_30,jitter_40,jitter_50,jitter_60,jitter_70,jitter_80,jitter_90,shimmer_10,shimmer_20,shimmer_30,shimmer_40,shimmer_50,shimmer_60,shimmer_70,shimmer_80,shimmer_90"
endif
if i_want_fricative_measurements = 1
    header$ = header$ + ",cog_10,cog_20,cog_30,cog_40,cog_50,cog_60,cog_70,cog_80,cog_90,cog_100,cogSD_10,cogSD_20,cogSD_30,cogSD_40,cogSD_50,cogSD_60,cogSD_70,cogSD_80,cogSD_90,cogSD_100,skewness_10,skewness_20,skewness_30,skewness_40,skewness_50,skewness_60,skewness_70,skewness_80,skewness_90,skewness_100,kurtosis_10,kurtosis_20,kurtosis_30,kurtosis_40,kurtosis_50,kurtosis_60,kurtosis_70,kurtosis_80,kurtosis_90,kurtosis_100"
endif
if i_want_voice_quality = 1
    i_want_formants = 1
    i_want_pitch = 1
    header$ = header$ + ",ltas_f0_10,ltas_f0_20,ltas_f0_30,ltas_f0_40,ltas_f0_50,ltas_f0_60,ltas_f0_70,ltas_f0_80,ltas_f0_90,ltas_f0_100,ltas_f1_10,ltas_f1_20,ltas_f1_30,ltas_f1_40,ltas_f1_50,ltas_f1_60,ltas_f1_70,ltas_f1_80,ltas_f1_90,ltas_f1_100,ltas_f2_10,ltas_f2_20,ltas_f2_30,ltas_f2_40,ltas_f2_50,ltas_f2_60,ltas_f2_70,ltas_f2_80,ltas_f2_90,ltas_f2_100,ltas_f3_10,ltas_f3_20,ltas_f3_30,ltas_f3_40,ltas_f3_50,ltas_f3_60,ltas_f3_70,ltas_f3_80,ltas_f3_90,ltas_f3_100,ltas_f4_10,ltas_f4_20,ltas_f4_30,ltas_f4_40,ltas_f4_50,ltas_f4_60,ltas_f4_70,ltas_f4_80,ltas_f4_90,ltas_f4_100,ltas_f5_10,ltas_f5_20,ltas_f5_30,ltas_f5_40,ltas_f5_50,ltas_f5_60,ltas_f5_70,ltas_f5_80,ltas_f5_90,ltas_f5_100,a1_10,a1_20,a1_30,a1_40,a1_50,a1_60,a1_70,a1_80,a1_90,a1_100,a2_10,a2_20,a2_30,a2_40,a2_50,a2_60,a2_70,a2_80,a2_90,a2_100,a3_10,a3_20,a3_30,a3_40,a3_50,a3_60,a3_70,a3_80,a3_90,a3_100,a4_10,a4_20,a4_30,a4_40,a4_50,a4_60,a4_70,a4_80,a4_90,a4_100,a5_10,a5_20,a5_30,a5_40,a5_50,a5_60,a5_70,a5_80,a5_90,a5_100,h2_10,h2_20,h2_30,h2_40,h2_50,h2_60,h2_70,h2_80,h2_90,h2_100,h3_10,h3_20,h3_30,h3_40,h3_50,h3_60,h3_70,h3_80,h3_90,h3_100,h4_10,h4_20,h4_30,h4_40,h4_50,h4_60,h4_70,h4_80,h4_90,h4_100,h5_10,h5_20,h5_30,h5_40,h5_50,h5_60,h5_70,h5_80,h5_90,h5_100,ha1_10,ha1_20,ha1_30,ha1_40,ha1_50,ha1_60,ha1_70,ha1_80,ha1_90,ha1_100,ha2_10,ha2_20,ha2_30,ha2_40,ha2_50,ha2_60,ha2_70,ha2_80,ha2_90,ha2_100,ha3_10,ha3_20,ha3_30,ha3_40,ha3_50,ha3_60,ha3_70,ha3_80,ha3_90,ha3_100,ha4_10,ha4_20,ha4_30,ha4_40,ha4_50,ha4_60,ha4_70,ha4_80,ha4_90,ha4_100,ha5_10,ha5_20,ha5_30,ha5_40,ha5_50,ha5_60,ha5_70,ha5_80,ha5_90,ha5_100,k1a_10,k1a_20,k1a_30,k1a_40,k1a_50,k1a_60,k1a_70,k1a_80,k1a_90,k1a_100,k2a_10,k2a_20,k2a_30,k2a_40,k2a_50,k2a_60,k2a_70,k2a_80,k2a_90,k2a_100,k3a_10,k3a_20,k3a_30,k3a_40,k3a_50,k3a_60,k3a_70,k3a_80,k3a_90,k3a_100,k4a_10,k4a_20,k4a_30,k4a_40,k4a_50,k4a_60,k4a_70,k4a_80,k4a_90,k4a_100,k5a_10,k5a_20,k5a_30,k5a_40,k5a_50,k5a_60,k5a_70,k5a_80,k5a_90,k5a_100,pa0_via_h1h2_10,pa0_via_h1h2_20,pa0_via_h1h2_30,pa0_via_h1h2_40,pa0_via_h1h2_50,pa0_via_h1h2_60,pa0_via_h1h2_70,pa0_via_h1h2_80,pa0_via_h1h2_90,pa0_via_h1h2_100,p0_via_250_450_10,p0_via_250_450_20,p0_via_250_450_30,p0_via_250_450_40,p0_via_250_450_50,p0_via_250_450_60,p0_via_250_450_70,p0_via_250_450_80,p0_via_250_450_90,p0_via_250_450_100,pa0_via_250_450_10,pa0_via_250_450_20,pa0_via_250_450_30,pa0_via_250_450_40,pa0_via_250_450_50,pa0_via_250_450_60,pa0_via_250_450_70,pa0_via_250_450_80,pa0_via_250_450_90,pa0_via_250_450_100,p0_via_below_f1_10,p0_via_below_f1_20,p0_via_below_f1_30,p0_via_below_f1_40,p0_via_below_f1_50,p0_via_below_f1_60,p0_via_below_f1_70,p0_via_below_f1_80,p0_via_below_f1_90,p0_via_below_f1_100,pa0_via_below_f1_10,pa0_via_below_f1_20,pa0_via_below_f1_30,pa0_via_below_f1_40,pa0_via_below_f1_50,pa0_via_below_f1_60,pa0_via_below_f1_70,pa0_via_below_f1_80,pa0_via_below_f1_90,pa0_via_below_f1_100,p1_via_850_1050_10,p1_via_850_1050_20,p1_via_850_1050_30,p1_via_850_1050_40,p1_via_850_1050_50,p1_via_850_1050_60,p1_via_850_1050_70,p1_via_850_1050_80,p1_via_850_1050_90,p1_via_850_1050_100,pa1_via_850_1050_10,pa1_via_850_1050_20,pa1_via_850_1050_30,pa1_via_850_1050_40,pa1_via_850_1050_50,pa1_via_850_1050_60,pa1_via_850_1050_70,pa1_via_850_1050_80,pa1_via_850_1050_90,pa1_via_850_1050_100,p1_via_above_f1_10,p1_via_above_f1_20,p1_via_above_f1_30,p1_via_above_f1_40,p1_via_above_f1_50,p1_via_above_f1_60,p1_via_above_f1_70,p1_via_above_f1_80,p1_via_above_f1_90,p1_via_above_f1_100,pa1_via_above_f1_10,pa1_via_above_f1_20,pa1_via_above_f1_30,pa1_via_above_f1_40,pa1_via_above_f1_50,pa1_via_above_f1_60,pa1_via_above_f1_70,pa1_via_above_f1_80,pa1_via_above_f1_90,pa1_via_above_f1_100,rms_10,rms_20,rms_30,rms_40,rms_50,rms_60,rms_70,rms_80,rms_90,rms_100"
endif

writeFileLine: csv_file_path$, header$

currentResults$ = ""
results$ = ""
soundChunkExists = 0

for file to numberOfFiles
    if ((file - 1) mod number_of_cpu_cores) = (process_index - 1)
        selectObject: fileList
        currentFile$ = Get string: file
        if i_am_using_a_Windows_computer = 1
            currentTextGrid = Read from file: input_folder$ + "\"+ currentFile$
        else
            currentTextGrid = Read from file: input_folder$ + "/"+ currentFile$
        endif
        currentTextGrid$ = selected$("TextGrid")
        if i_am_using_a_Windows_computer = 1
            currentSound = Read from file: input_folder$ + "\"+ ( replace$(currentFile$,  ".TextGrid", ".wav", 4))
        else
            currentSound = Read from file: input_folder$ + "/"+ ( replace$(currentFile$,  ".TextGrid", ".wav", 4))
        endif
        currentFile$ = replace$(currentFile$, ".TextGrid", "", 0)
        currentSound$ = selected$("Sound")
        selectObject: currentTextGrid

        #Gather the number of intervals on your phoneme/phone tier. Stores this value to a variable called numberOfIntervals
        numberOfIntervals = Get number of intervals: phone_tier_number
        Convert to Unicode

        # Eventually I'll make radio buttons in a form so that you can choose which encoding you want
        Text writing settings: "UTF-8"
        
        # Create Objects
        if i_want_pitch = 1
            #Creates a Pitch Object. 
            select Sound 'currentSound$'
            currentPitch = noprogress To Pitch... 0 pitch_floor pitch_ceiling
        endif
        if i_want_formants = 1
            #Creates a Formant Object. With the formant object, we can gather formant values and formant bandwidths. Change '5500' to '5000' if your data has mostly male speakers (or use formant optimization to be added later!).
            select Sound 'currentSound$'
            currentFormant = noprogress To Formant (burg)... 0 5 formant_ceiling formant_timestep 50
        endif
        if i_want_harmonicity = 1
            #Creates a Harmonicity Object, useful for both obstruent analysis and voice quality analysis.
            select Sound 'currentSound$'
            currentHarmonicity = noprogress To Harmonicity (cc)... 0.01 75 0.1 4.5
        endif
        if i_want_intensity = 1
            #Creates an Intensity Object
            select Sound 'currentSound$'
            currentIntensity = noprogress To Intensity... 50 0 yes
            intensity_min_exists = 0 
        endif
        if i_want_jitter_and_shimmer = 1
            #Creates a Point Process object, which is the object type used to gather jitter and shimmer.
            select Sound 'currentSound$'
            currentPointProcess = noprogress To PointProcess (periodic, cc)... pitch_floor pitch_ceiling
        endif

        #Executes a command starting at the first interval and goes all the way up to the final interval on the phonemes/phones tier.
        #The current interval being scanned for is called 'currentInter'
        for currentInterval from 1 to numberOfIntervals
            select TextGrid 'currentTextGrid$'
            thisPhoneme$ = Get label of interval: phone_tier_number, currentInterval
            if not thisPhoneme$ = ""
                if not thisPhoneme$ = "sil"
                    if not thisPhoneme$ = "<unk>"
                        thisPhonemeStartTime = Get start point: phone_tier_number, currentInterval
                        thisPhonemeEndTime = Get end point: phone_tier_number, currentInterval
                        duration = thisPhonemeEndTime - thisPhonemeStartTime
                        precederNumber = currentInterval - 1
                        precedingPhoneme$ = "boundary"
                        followerNumber = currentInterval + 1
                        followingPhoneme$ = "boundary"

                        if currentInterval > 1
                            precedingPhoneme$ = Get label of interval: phone_tier_number, precederNumber
                            if precedingPhoneme$ = ""
                                precedingPhoneme$ = "boundary"
                            endif
                        endif
                   
                        if currentInterval < numberOfIntervals
                            followingPhoneme$ = Get label of interval: phone_tier_number, followerNumber
                            if followingPhoneme$ = ""
                                followingPhoneme$ = "boundary"
                            endif
                        endif

                        for t from 0 to 10
                            timePercentile[t] = thisPhonemeStartTime + (0.1 * duration * t)
                        endfor

                        if word_tier_number <> 0
                            currentWord$ = "--undefined--"
                            nocheck currentWordInterval = Get interval at time: word_tier_number, timePercentile[5]
                            nocheck currentWord$ = Get label of interval: word_tier_number, currentWordInterval
                        endif

                        if miscellaneous_tier_number <> 0
                            currentMisc$ = "--undefined--"
                            nocheck currentMiscInterval = Get interval at time: miscellaneous_tier_number, timePercentile[5]
                            nocheck currentMisc$ = Get label of interval: miscellaneous_tier_number, currentMiscInterval
                        endif

                        if miscellaneous_second_tier_number <> 0
                            currentMisc_b$ = "--undefined--"
                            nocheck currentMiscInterval = Get interval at time: miscellaneous_second_tier_number, timePercentile[5]
                            nocheck currentMisc_b$ = Get label of interval: miscellaneous_second_tier_number, currentMiscInterval
                        endif

                        # Convert our starting variables into strings, which can come in handy (but is not strictly necessary) when appending files
                        thisPhonemeStartTime$ = fixed$(round(thisPhonemeStartTime * 10000)/10000, 10)
                        thisPhonemeEndTime$ = fixed$(round(thisPhonemeEndTime * 10000)/10000, 10)
                        duration$ = fixed$(round(duration * 10000)/10000, 10)
                        
                        if numberOfFiles > 1
                            results$ = results$ + currentFile$ + ","
                        endif
                        results$ = results$ + thisPhonemeStartTime$ + "," + thisPhonemeEndTime$ + "," + thisPhoneme$

                        if word_tier_number <> 0
                            results$ = results$ + "," + currentWord$
                        endif

                        if miscellaneous_tier_number <> 0
                            results$ = results$ + "," + currentMisc$
                        endif

                        if miscellaneous_second_tier_number <> 0
                            results$ = results$ + "," + currentMisc_b$
                        endif
                        
                        results$ = results$ + "," + precedingPhoneme$ + "," + followingPhoneme$

                        if i_want_pitch = 1
                            #We're going to first select our Pitch object and then gather pitch at the 10% through 90% points
                            selectObject: currentPitch
                            for t from 0 to 10
                                f0[t] = Get value at time... timePercentile[t] Hertz Linear
                                # if string$(f0[t]) = "--undefined--"
                                #     f0[t] = 99999
                                # endif
                            endfor
                            results$=results$+","+fixed$(f0[1],4)+","+fixed$(f0[2],4)+","+fixed$(f0[3],4)+","+fixed$(f0[4],4)+","+fixed$(f0[5],4)+","+fixed$(f0[6],4)+","+fixed$(f0[7],4)+","+fixed$(f0[8],4)+","+fixed$(f0[9],4)
                        endif

                        # Gather formant bandwidths and slopes
                        if i_want_formants = 1
                            selectObject: currentFormant
                            for t from 0 to 10
                                f1[t] = Get value at time... 1 timePercentile[t] Hertz Linear
                                f2[t] = Get value at time... 2 timePercentile[t] Hertz Linear
                                f3[t] = Get value at time... 3 timePercentile[t] Hertz Linear
                                f4[t] = Get value at time... 4 timePercentile[t] Hertz Linear
                                f5[t] = Get value at time... 5 timePercentile[t] Hertz Linear
                                bw1[t] = Get bandwidth at time... 1 timePercentile[t] Hertz Linear
                                bw2[t] = Get bandwidth at time... 2 timePercentile[t] Hertz Linear
                                bw3[t] = Get bandwidth at time... 3 timePercentile[t] Hertz Linear
                                bw4[t] = Get bandwidth at time... 4 timePercentile[t] Hertz Linear
                                bw5[t] = Get bandwidth at time... 5 timePercentile[t] Hertz Linear
                            endfor

                            results$=results$+","+fixed$(f1[1],4)+","+fixed$(f1[2],4)+","+fixed$(f1[3],4)+","+fixed$(f1[4],4)+","+fixed$(f1[5],4)+","+fixed$(f1[6],4)+","+fixed$(f1[7],4)+","+fixed$(f1[8],4)+","+fixed$(f1[9],4)+","+fixed$(f2[1],4)+","+fixed$(f2[2],4)+","+fixed$(f2[3],4)+","+fixed$(f2[4],4)+","+fixed$(f2[5],4)+","+fixed$(f2[6],4)+","+fixed$(f2[7],4)+","+fixed$(f2[8],4)+","+fixed$(f2[9],4)+","+fixed$(f3[1],4)+","+fixed$(f3[2],4)+","+fixed$(f3[3],4)+","+fixed$(f3[4],4)+","+fixed$(f3[5],4)+","+fixed$(f3[6],4)+","+fixed$(f3[7],4)+","+fixed$(f3[8],4)+","+fixed$(f3[9],4)+","+fixed$(f4[1],4)+","+fixed$(f4[2],4)+","+fixed$(f4[3],4)+","+fixed$(f4[4],4)+","+fixed$(f4[5],4)+","+fixed$(f4[6],4)+","+fixed$(f4[7],4)+","+fixed$(f4[8],4)+","+fixed$(f4[9],4)+","+fixed$(f5[1],4)+","+fixed$(f5[2],4)+","+fixed$(f5[3],4)+","+fixed$(f5[4],4)+","+fixed$(f5[5],4)+","+fixed$(f5[6],4)+","+fixed$(f5[7],4)+","+fixed$(f5[8],4)+","+fixed$(f5[9],4)+","+fixed$(bw1[1],4)+","+fixed$(bw1[2],4)+","+fixed$(bw1[3],4)+","+fixed$(bw1[4],4)+","+fixed$(bw1[5],4)+","+fixed$(bw1[6],4)+","+fixed$(bw1[7],4)+","+fixed$(bw1[8],4)+","+fixed$(bw1[9],4)+","+fixed$(bw2[1],4)+","+fixed$(bw2[2],4)+","+fixed$(bw2[3],4)+","+fixed$(bw2[4],4)+","+fixed$(bw2[5],4)+","+fixed$(bw2[6],4)+","+fixed$(bw2[7],4)+","+fixed$(bw2[8],4)+","+fixed$(bw2[9],4)+","+fixed$(bw3[1],4)+","+fixed$(bw3[2],4)+","+fixed$(bw3[3],4)+","+fixed$(bw3[4],4)+","+fixed$(bw3[5],4)+","+fixed$(bw3[6],4)+","+fixed$(bw3[7],4)+","+fixed$(bw3[8],4)+","+fixed$(bw3[9],4)+","+fixed$(bw4[1],4)+","+fixed$(bw4[2],4)+","+fixed$(bw4[3],4)+","+fixed$(bw4[4],4)+","+fixed$(bw4[5],4)+","+fixed$(bw4[6],4)+","+fixed$(bw4[7],4)+","+fixed$(bw4[8],4)+","+fixed$(bw4[9],4)+","+fixed$(bw5[1],4)+","+fixed$(bw5[2],4)+","+fixed$(bw5[3],4)+","+fixed$(bw5[4],4)+","+fixed$(bw5[5],4)+","+fixed$(bw5[6],4)+","+fixed$(bw5[7],4)+","+fixed$(bw5[8],4)+","+fixed$(bw5[9],4)
                        endif

                        # Gather harmonicity
                        if i_want_harmonicity = 1
                            selectObject: currentHarmonicity
                            for t from 1 to 9
                                hnr[t] = Get value at time... timePercentile[t] cubic
                                if hnr[t] = -200
                                    hnr[t] = 99999
                                endif
                            endfor

                            results$=results$+","+string$(hnr[1])+","+string$(hnr[2])+","+string$(hnr[3])+","+string$(hnr[4])+","+string$(hnr[5])+","+string$(hnr[6])+","+string$(hnr[7])+","+string$(hnr[8])+","+string$(hnr[9])
                        endif

                        #This is the intensity section. We're going to gather mean intensities throughout the sound.
                        #We're also going to gather min, and max intensity.
                        #Lastly, we're going to include an intensity difference measure, which comes from Bongiovanni 2015 and is used for analysis of nasal stops.
                        if i_want_intensity = 1
                            selectObject: currentIntensity
                            for t from 1 to 10
                                intensity[t] = Get mean... timePercentile[t-1] timePercentile[t] dB
                            endfor
                            intensity_max = Get maximum... thisPhonemeStartTime thisPhonemeEndTime Parabolic
                            intensity_difference = 99999

                            if currentInterval > 1 and intensity_min_exists = 1
                                intensity_difference = intensity_max - intensity_min
                            endif
                            intensity_min = Get minimum... thisPhonemeStartTime thisPhonemeEndTime Parabolic
                            intensity_min_exists = 1
                            results$=results$+","+string$(intensity[1])+","+string$(intensity[2])+","+string$(intensity[3])+","+string$(intensity[4])+","+string$(intensity[5])+","+string$(intensity[6])+","+string$(intensity[7])+","+string$(intensity[8])+","+string$(intensity[9])+","+string$(intensity[10])+","+string$(intensity_max)+","+string$(intensity_min)+","+string$(intensity_difference)
                        endif

                        # Jitter and Shimmer. Shimmer documentation is really sparse.
                        # Arguments of the Jitter and Shimmer functions are startTime endTime periodFloor periodCeiling and maximumPeriodFactor which Boersma calls "the largest possible difference between consecutive intervals that will be used in the computation".
                        # Jitter documentation is fine, and shimmer commands follow the same structure as jitter. Note that there's an extra comma in the shimmer functions as late as December 2025
                        if i_want_jitter_and_shimmer = 1
                            for t from 1 to 9
                                selectObject: currentPointProcess
                                jitter[t] = Get jitter (local, absolute)... timePercentile[t-1] timePercentile[t+1] 0.0001 0.02 1.3
                                selectObject: currentSound, currentPointProcess
                                shimmer[t] = Get shimmer (local): timePercentile[t-1], timePercentile[t+1], 0.0001, 0.02, 1.3, 1.6

                            endfor
                            results$=results$+","+string$(jitter[1])+","+string$(jitter[2])+","+string$(jitter[3])+","+string$(jitter[4])+","+string$(jitter[5])+","+string$(jitter[6])+","+string$(jitter[7])+","+string$(jitter[8])+","+string$(jitter[9])+","+string$(shimmer[1])+","+string$(shimmer[2])+","+string$(shimmer[3])+","+string$(shimmer[4])+","+string$(shimmer[5])+","+string$(shimmer[6])+","+string$(shimmer[7])+","+string$(shimmer[8])+","+string$(shimmer[9])
                        endif
                        
                        # Creates spectrum objects. Praat's spectrum creation is **super** slow, so it's a requirement to extract sound chunks to make tiny spectral objects first.
                        if i_want_fricative_measurements = 1
                                nocheck removeObject:currentSoundChunk
                            for t from 1 to 10
                                selectObject: currentSound
                                currentSoundChunk = Extract part... timePercentile[t-1] timePercentile[t] Gaussian1 1 on
                                selectObject: currentSoundChunk
                                currentSpectrum = noprogress To Spectrum... yes
                                selectObject: currentSpectrum
                                cog[t] = Get centre of gravity... 2
                                cogSD[t] = Get standard deviation... 2
                                skewness[t] = Get skewness... 2
                                kurtosis[t] = Get kurtosis... 2
                                removeObject: currentSpectrum
                                removeObject: currentSoundChunk
                            endfor
                            results$=results$+","+fixed$(cog[1],4)+","+fixed$(cog[2],4)+","+fixed$(cog[3],4)+","+fixed$(cog[4],4)+","+fixed$(cog[5],4)+","+fixed$(cog[6],4)+","+fixed$(cog[7],4)+","+fixed$(cog[8],4)+","+fixed$(cog[9],4)+","+fixed$(cog[10],4)+","+fixed$(cogSD[1],4)+","+fixed$(cogSD[2],4)+","+fixed$(cogSD[3],4)+","+fixed$(cogSD[4],4)+","+fixed$(cogSD[5],4)+","+fixed$(cogSD[6],4)+","+fixed$(cogSD[7],4)+","+fixed$(cogSD[8],4)+","+fixed$(cogSD[9],4)+","+fixed$(cogSD[10],4)+","+fixed$(skewness[1],4)+","+fixed$(skewness[2],4)+","+fixed$(skewness[3],4)+","+fixed$(skewness[4],4)+","+fixed$(skewness[5],4)+","+fixed$(skewness[6],4)+","+fixed$(skewness[7],4)+","+fixed$(skewness[8],4)+","+fixed$(skewness[9],4)+","+fixed$(skewness[10],4)+","+fixed$(kurtosis[1],4)+","+fixed$(kurtosis[2],4)+","+fixed$(kurtosis[3],4)+","+fixed$(kurtosis[4],4)+","+fixed$(kurtosis[5],4)+","+fixed$(kurtosis[6],4)+","+fixed$(kurtosis[7],4)+","+fixed$(kurtosis[8],4)+","+fixed$(kurtosis[9],4)+","+fixed$(kurtosis[10],4)
                        endif
                        
                        # Voice Metrics on the To-Do list
                        # CPP, MFCC, smoothing, looking into cepstrum tables like PraatSauce
                        # Subharmonic to harmonic ratio
                        # Strength of Excitation
                        # Number of peaks below a certain Hz cutoff
                        if i_want_voice_quality = 1
                            selectObject: currentSound
                            for t from 1 to 10
                                currentSoundChunk = noprogress Extract part... timePercentile[t-1] timePercentile[t] Gaussian1 1 on
                                selectObject: currentSoundChunk
                                currentSpectrum = noprogress To Spectrum... yes 
                                removeObject: currentSoundChunk
                                selectObject: currentSpectrum
                                currentLtas = noprogress To Ltas (1-to-1)
                                removeObject: currentSpectrum
                                selectObject: currentLtas

                                # If variables never get assigned, they'll be 99999 for printing purposes to avoid errors
                                ltas_f0[t] = 99999
                                ltas_f1[t] = 99999
                                ltas_f2[t] = 99999
                                ltas_f3[t] = 99999
                                ltas_f4[t] = 99999
                                ltas_f5[t] = 99999
                                a1[t] = 99999
                                a2[t] = 99999
                                a3[t] = 99999
                                a4[t] = 99999
                                a5[t] = 99999
                                h2[t] = 99999
                                h3[t] = 99999
                                h4[t] = 99999
                                h5[t] = 99999
                                ha1[t] = 99999
                                ha2[t] = 99999
                                ha3[t] = 99999
                                ha4[t] = 99999
                                ha5[t] = 99999
                                p0_via_below_f1[t] = 99999
                                pa0_via_below_f1[t] = 99999
                                p1_via_above_f1[t] = 99999
                                pa1_via_above_f1[t] = 99999

                                # Setting window frequency size relative to f0 is an idea taken from Will Styler's nasality script
                                if string$(f0[t]) <> "--undefined--" 
                                    ltas_f0[t] = Get frequency of maximum... (f0[t]-(f0[t]/2)) (f0[t]+(f0[t]/2)) None
                                    # The Hz of H1 is conceptually the same as F0, so we'll use ltas_f0
                                    h2[t] = Get frequency of maximum... ((2*f0[t])-(f0[t]/2)) ((2*f0[t])+(f0[t]/2)) None
                                    h3[t] = Get frequency of maximum... ((3*f0[t])-(f0[t]/2)) ((3*f0[t])+(f0[t]/2)) None
                                    h4[t] = Get frequency of maximum... ((4*f0[t])-(f0[t]/2)) ((4*f0[t])+(f0[t]/2)) None
                                    h5[t] = Get frequency of maximum... ((5*f0[t])-(f0[t]/2)) ((5*f0[t])+(f0[t]/2)) None
                                    ha1[t] = Get value at frequency... ltas_f0[t] Nearest
                                    ha2[t] = Get value at frequency... h2[t] Nearest
                                    ha3[t] = Get value at frequency... h3[t] Nearest
                                    ha4[t] = Get value at frequency... h4[t] Nearest
                                    ha5[t] = Get value at frequency... h5[t] Nearest

                                    if string$(f1[t]) <> "--undefined--"
                                        ltas_f1[t] = Get frequency of maximum... (f1[t]-(f0[t]/2)) (f1[t]+(f0[t]/2)) None
                                        a1[t] = Get value at frequency... ltas_f1[t] Nearest

                                        # p0 defined as amplitude of peak below F1 (Tarun Pruthi & Carol Espy Wilson 2004)
                                        # no 'sg' method, no cepstral smoothing or group delay spectra
                                        p0_via_below_f1[t] = Get frequency of maximum... (ltas_f1[t]-(1.5*ltas_f0[t])) (ltas_f1[t]-(0.5*ltas_f0[t])) None
                                        pa0_via_below_f1[t] = Get value at frequency... p0_via_below_f1[t] Nearest

                                        # p1 defined as amplitude of peak above F1 (Tarun Pruthi & Carol Espy Wilson 2004)
                                        # no 'sg' method, no cepstral smoothing or group delay spectra
                                        p1_via_above_f1[t] = Get frequency of maximum... (ltas_f1[t]-(1.5*ltas_f0[t])) (ltas_f1[t]-(0.5*ltas_f0[t])) None
                                        pa1_via_above_f1[t] = Get value at frequency... p1_via_above_f1[t] Nearest
                                    endif
                                    if string$(f2[t]) <> "--undefined--"
                                        ltas_f2[t] = Get frequency of maximum... (f2[t]-(f0[t]/2)) (f2[t]+(f0[t]/2)) None
                                        a2[t] = Get value at frequency... ltas_f2[t] Nearest
                                    endif
                                    if string$(f3[t]) <> "--undefined--"
                                        ltas_f3[t] = Get frequency of maximum... (f3[t]-(f0[t]/2)) (f3[t]+(f0[t]/2)) None
                                        a3[t] = Get value at frequency... ltas_f3[t] Nearest
                                    endif
                                    if string$(f4[t]) <> "--undefined--"
                                        ltas_f4[t] = Get frequency of maximum... (f4[t]-(f0[t]/2)) (f4[t]+(f0[t]/2)) None
                                        a4[t] = Get value at frequency... ltas_f4[t] Nearest
                                    endif
                                    if string$(f5[t]) <> "--undefined--"
                                        ltas_f5[t] = Get frequency of maximum... (f5[t]-(f0[t]/2)) (f5[t]+(f0[t]/2)) None
                                        a5[t] = Get value at frequency... ltas_f5[t] Nearest
                                    endif
                                endif

                                k1a[t] = Get value at frequency... 1000 Nearest
                                k2a[t] = Get value at frequency... 2000 Nearest
                                k3a[t] = Get value at frequency... 3000 Nearest
                                k4a[t] = Get value at frequency... 4000 Nearest
                                k5a[t] = Get value at frequency... 5000 Nearest

                                # There are many kinds of P0 measurements
                                # p0 defined by the greater of first two harmonics (Will Styler 2017)
                                if ha2[t] <> 99999
                                    if ha1[t] <> 99999
                                        if ha1[t] > ha2[t]
                                            pa0_via_h1h2[t] = ha1[t]
                                        else
                                            pa0_via_h1h2[t] = ha2[t]
                                        endif
                                    else
                                        pa0_via_h1h2[t] = ha2[t]
                                    endif
                                elif ha1[t] <> 99999
                                    pa0_via_h1h2[t] = ha1[t]
                                else
                                    pa0_via_h1h2[t] = 99999
                                endif

                                # p0 defined as Greatest harmonic between 250 and 450 Hz (Marilyn Chen 1997) - precorrection
                                p0_via_250_450[t] = Get frequency of maximum... 250 450 None
                                pa0_via_250_450[t] = Get value at frequency... p0_via_250_450[t] Nearest

                                # p1 defined as amplitude of peak between 850 and 1050 Hz (Marilyn Chen 1997) - precorrection
                                p1_via_850_1050[t] = Get frequency of maximum... 850 1050 None
                                pa1_via_850_1050[t] = Get value at frequency... p1_via_850_1050[t] Nearest

                                nocheck removeObject: currentLtas

                                # get root mean squared
                                selectObject: currentSound
                                rms[t] = Get root-mean-square... timePercentile[t-1] timePercentile[t]
                            endfor

                            results$=results$+","+fixed$(ltas_f0[1],4)+","+fixed$(ltas_f0[2],4)+","+fixed$(ltas_f0[3],4)+","+fixed$(ltas_f0[4],4)+","+fixed$(ltas_f0[5],4)+","+fixed$(ltas_f0[6],4)+","+fixed$(ltas_f0[7],4)+","+fixed$(ltas_f0[8],4)+","+fixed$(ltas_f0[9],4)+","+fixed$(ltas_f0[10],4)+","+fixed$(ltas_f1[1],4)+","+fixed$(ltas_f1[2],4)+","+fixed$(ltas_f1[3],4)+","+fixed$(ltas_f1[4],4)+","+fixed$(ltas_f1[5],4)+","+fixed$(ltas_f1[6],4)+","+fixed$(ltas_f1[7],4)+","+fixed$(ltas_f1[8],4)+","+fixed$(ltas_f1[9],4)+","+fixed$(ltas_f1[10],4)+","+fixed$(ltas_f2[1],4)+","+fixed$(ltas_f2[2],4)+","+fixed$(ltas_f2[3],4)+","+fixed$(ltas_f2[4],4)+","+fixed$(ltas_f2[5],4)+","+fixed$(ltas_f2[6],4)+","+fixed$(ltas_f2[7],4)+","+fixed$(ltas_f2[8],4)+","+fixed$(ltas_f2[9],4)+","+fixed$(ltas_f2[10],4)+","+fixed$(ltas_f3[1],4)+","+fixed$(ltas_f3[2],4)+","+fixed$(ltas_f3[3],4)+","+fixed$(ltas_f3[4],4)+","+fixed$(ltas_f3[5],4)+","+fixed$(ltas_f3[6],4)+","+fixed$(ltas_f3[7],4)+","+fixed$(ltas_f3[8],4)+","+fixed$(ltas_f3[9],4)+","+fixed$(ltas_f3[10],4)+","+fixed$(ltas_f4[1],4)+","+fixed$(ltas_f4[2],4)+","+fixed$(ltas_f4[3],4)+","+fixed$(ltas_f4[4],4)+","+fixed$(ltas_f4[5],4)+","+fixed$(ltas_f4[6],4)+","+fixed$(ltas_f4[7],4)+","+fixed$(ltas_f4[8],4)+","+fixed$(ltas_f4[9],4)+","+fixed$(ltas_f4[10],4)+","+fixed$(ltas_f5[1],4)+","+fixed$(ltas_f5[2],4)+","+fixed$(ltas_f5[3],4)+","+fixed$(ltas_f5[4],4)+","+fixed$(ltas_f5[5],4)+","+fixed$(ltas_f5[6],4)+","+fixed$(ltas_f5[7],4)+","+fixed$(ltas_f5[8],4)+","+fixed$(ltas_f5[9],4)+","+fixed$(ltas_f5[10],4)
                            
                            results$=results$+","+fixed$(a1[1],4)+","+fixed$(a1[2],4)+","+fixed$(a1[3],4)+","+fixed$(a1[4],4)+","+fixed$(a1[5],4)+","+fixed$(a1[6],4)+","+fixed$(a1[7],4)+","+fixed$(a1[8],4)+","+fixed$(a1[9],4)+","+fixed$(a1[10],4)+","+fixed$(a2[1],4)+","+fixed$(a2[2],4)+","+fixed$(a2[3],4)+","+fixed$(a2[4],4)+","+fixed$(a2[5],4)+","+fixed$(a2[6],4)+","+fixed$(a2[7],4)+","+fixed$(a2[8],4)+","+fixed$(a2[9],4)+","+fixed$(a2[10],4)+","+fixed$(a3[1],4)+","+fixed$(a3[2],4)+","+fixed$(a3[3],4)+","+fixed$(a3[4],4)+","+fixed$(a3[5],4)+","+fixed$(a3[6],4)+","+fixed$(a3[7],4)+","+fixed$(a3[8],4)+","+fixed$(a3[9],4)+","+fixed$(a3[10],4)+","+fixed$(a4[1],4)+","+fixed$(a4[2],4)+","+fixed$(a4[3],4)+","+fixed$(a4[4],4)+","+fixed$(a4[5],4)+","+fixed$(a4[6],4)+","+fixed$(a4[7],4)+","+fixed$(a4[8],4)+","+fixed$(a4[9],4)+","+fixed$(a4[10],4)+","+fixed$(a5[1],4)+","+fixed$(a5[2],4)+","+fixed$(a5[3],4)+","+fixed$(a5[4],4)+","+fixed$(a5[5],4)+","+fixed$(a5[6],4)+","+fixed$(a5[7],4)+","+fixed$(a5[8],4)+","+fixed$(a5[9],4)+","+fixed$(a5[10],4)
                            
                            results$=results$+","+fixed$(h2[1],4)+","+fixed$(h2[2],4)+","+fixed$(h2[3],4)+","+fixed$(h2[4],4)+","+fixed$(h2[5],4)+","+fixed$(h2[6],4)+","+fixed$(h2[7],4)+","+fixed$(h2[8],4)+","+fixed$(h2[9],4)+","+fixed$(h2[10],4)+","+fixed$(h3[1],4)+","+fixed$(h3[2],4)+","+fixed$(h3[3],4)+","+fixed$(h3[4],4)+","+fixed$(h3[5],4)+","+fixed$(h3[6],4)+","+fixed$(h3[7],4)+","+fixed$(h3[8],4)+","+fixed$(h3[9],4)+","+fixed$(h3[10],4)+","+fixed$(h4[1],4)+","+fixed$(h4[2],4)+","+fixed$(h4[3],4)+","+fixed$(h4[4],4)+","+fixed$(h4[5],4)+","+fixed$(h4[6],4)+","+fixed$(h4[7],4)+","+fixed$(h4[8],4)+","+fixed$(h4[9],4)+","+fixed$(h4[10],4)+","+fixed$(h5[1],4)+","+fixed$(h5[2],4)+","+fixed$(h5[3],4)+","+fixed$(h5[4],4)+","+fixed$(h5[5],4)+","+fixed$(h5[6],4)+","+fixed$(h5[7],4)+","+fixed$(h5[8],4)+","+fixed$(h5[9],4)+","+fixed$(h5[10],4)
                            
                            results$=results$+","+fixed$(ha1[1],4)+","+fixed$(ha1[2],4)+","+fixed$(ha1[3],4)+","+fixed$(ha1[4],4)+","+fixed$(ha1[5],4)+","+fixed$(ha1[6],4)+","+fixed$(ha1[7],4)+","+fixed$(ha1[8],4)+","+fixed$(ha1[9],4)+","+fixed$(ha1[10],4)+","+fixed$(ha2[1],4)+","+fixed$(ha2[2],4)+","+fixed$(ha2[3],4)+","+fixed$(ha2[4],4)+","+fixed$(ha2[5],4)+","+fixed$(ha2[6],4)+","+fixed$(ha2[7],4)+","+fixed$(ha2[8],4)+","+fixed$(ha2[9],4)+","+fixed$(ha2[10],4)+","+fixed$(ha3[1],4)+","+fixed$(ha3[2],4)+","+fixed$(ha3[3],4)+","+fixed$(ha3[4],4)+","+fixed$(ha3[5],4)+","+fixed$(ha3[6],4)+","+fixed$(ha3[7],4)+","+fixed$(ha3[8],4)+","+fixed$(ha3[9],4)+","+fixed$(ha3[10],4)+","+fixed$(ha4[1],4)+","+fixed$(ha4[2],4)+","+fixed$(ha4[3],4)+","+fixed$(ha4[4],4)+","+fixed$(ha4[5],4)+","+fixed$(ha4[6],4)+","+fixed$(ha4[7],4)+","+fixed$(ha4[8],4)+","+fixed$(ha4[9],4)+","+fixed$(ha4[10],4)+","+fixed$(ha5[1],4)+","+fixed$(ha5[2],4)+","+fixed$(ha5[3],4)+","+fixed$(ha5[4],4)+","+fixed$(ha5[5],4)+","+fixed$(ha5[6],4)+","+fixed$(ha5[7],4)+","+fixed$(ha5[8],4)+","+fixed$(ha5[9],4)+","+fixed$(ha5[10],4)+","+fixed$(k1a[1],4)+","+fixed$(k1a[2],4)+","+fixed$(k1a[3],4)+","+fixed$(k1a[4],4)+","+fixed$(k1a[5],4)+","+fixed$(k1a[6],4)+","+fixed$(k1a[7],4)+","+fixed$(k1a[8],4)+","+fixed$(k1a[9],4)+","+fixed$(k1a[10],4)+","+fixed$(k2a[1],4)+","+fixed$(k2a[2],4)+","+fixed$(k2a[3],4)+","+fixed$(k2a[4],4)+","+fixed$(k2a[5],4)+","+fixed$(k2a[6],4)+","+fixed$(k2a[7],4)+","+fixed$(k2a[8],4)+","+fixed$(k2a[9],4)+","+fixed$(k2a[10],4)+","+fixed$(k3a[1],4)+","+fixed$(k3a[2],4)+","+fixed$(k3a[3],4)+","+fixed$(k3a[4],4)+","+fixed$(k3a[5],4)+","+fixed$(k3a[6],4)+","+fixed$(k3a[7],4)+","+fixed$(k3a[8],4)+","+fixed$(k3a[9],4)+","+fixed$(k3a[10],4)+","+fixed$(k4a[1],4)+","+fixed$(k4a[2],4)+","+fixed$(k4a[3],4)+","+fixed$(k4a[4],4)+","+fixed$(k4a[5],4)+","+fixed$(k4a[6],4)+","+fixed$(k4a[7],4)+","+fixed$(k4a[8],4)+","+fixed$(k4a[9],4)+","+fixed$(k4a[10],4)+","+fixed$(k5a[1],4)+","+fixed$(k5a[2],4)+","+fixed$(k5a[3],4)+","+fixed$(k5a[4],4)+","+fixed$(k5a[5],4)+","+fixed$(k5a[6],4)+","+fixed$(k5a[7],4)+","+fixed$(k5a[8],4)+","+fixed$(k5a[9],4)+","+fixed$(k5a[10],4)+","+fixed$(pa0_via_h1h2[1],4)+","+fixed$(pa0_via_h1h2[2],4)+","+fixed$(pa0_via_h1h2[3],4)+","+fixed$(pa0_via_h1h2[4],4)+","+fixed$(pa0_via_h1h2[5],4)+","+fixed$(pa0_via_h1h2[6],4)+","+fixed$(pa0_via_h1h2[7],4)+","+fixed$(pa0_via_h1h2[8],4)+","+fixed$(pa0_via_h1h2[9],4)+","+fixed$(pa0_via_h1h2[10],4)+","+fixed$(p0_via_250_450[1],4)+","+fixed$(p0_via_250_450[2],4)+","+fixed$(p0_via_250_450[3],4)+","+fixed$(p0_via_250_450[4],4)+","+fixed$(p0_via_250_450[5],4)+","+fixed$(p0_via_250_450[6],4)+","+fixed$(p0_via_250_450[7],4)+","+fixed$(p0_via_250_450[8],4)+","+fixed$(p0_via_250_450[9],4)+","+fixed$(p0_via_250_450[10],4)+","+fixed$(pa0_via_250_450[1],4)+","+fixed$(pa0_via_250_450[2],4)+","+fixed$(pa0_via_250_450[3],4)+","+fixed$(pa0_via_250_450[4],4)+","+fixed$(pa0_via_250_450[5],4)+","+fixed$(pa0_via_250_450[6],4)+","+fixed$(pa0_via_250_450[7],4)+","+fixed$(pa0_via_250_450[8],4)+","+fixed$(pa0_via_250_450[9],4)+","+fixed$(pa0_via_250_450[10],4)+","+fixed$(p0_via_below_f1[1],4)+","+fixed$(p0_via_below_f1[2],4)+","+fixed$(p0_via_below_f1[3],4)+","+fixed$(p0_via_below_f1[4],4)+","+fixed$(p0_via_below_f1[5],4)+","+fixed$(p0_via_below_f1[6],4)+","+fixed$(p0_via_below_f1[7],4)+","+fixed$(p0_via_below_f1[8],4)+","+fixed$(p0_via_below_f1[9],4)+","+fixed$(p0_via_below_f1[10],4)+","+fixed$(pa0_via_below_f1[1],4)+","+fixed$(pa0_via_below_f1[2],4)+","+fixed$(pa0_via_below_f1[3],4)+","+fixed$(pa0_via_below_f1[4],4)+","+fixed$(pa0_via_below_f1[5],4)+","+fixed$(pa0_via_below_f1[6],4)+","+fixed$(pa0_via_below_f1[7],4)+","+fixed$(pa0_via_below_f1[8],4)+","+fixed$(pa0_via_below_f1[9],4)+","+fixed$(pa0_via_below_f1[10],4)+","+fixed$(p1_via_850_1050[1],4)+","+fixed$(p1_via_850_1050[2],4)+","+fixed$(p1_via_850_1050[3],4)+","+fixed$(p1_via_850_1050[4],4)+","+fixed$(p1_via_850_1050[5],4)+","+fixed$(p1_via_850_1050[6],4)+","+fixed$(p1_via_850_1050[7],4)+","+fixed$(p1_via_850_1050[8],4)+","+fixed$(p1_via_850_1050[9],4)+","+fixed$(p1_via_850_1050[10],4)+","+fixed$(pa1_via_850_1050[1],4)+","+fixed$(pa1_via_850_1050[2],4)+","+fixed$(pa1_via_850_1050[3],4)+","+fixed$(pa1_via_850_1050[4],4)+","+fixed$(pa1_via_850_1050[5],4)+","+fixed$(pa1_via_850_1050[6],4)+","+fixed$(pa1_via_850_1050[7],4)+","+fixed$(pa1_via_850_1050[8],4)+","+fixed$(pa1_via_850_1050[9],4)+","+fixed$(pa1_via_850_1050[10],4)+","+fixed$(p1_via_above_f1[1],4)+","+fixed$(p1_via_above_f1[2],4)+","+fixed$(p1_via_above_f1[3],4)+","+fixed$(p1_via_above_f1[4],4)+","+fixed$(p1_via_above_f1[5],4)+","+fixed$(p1_via_above_f1[6],4)+","+fixed$(p1_via_above_f1[7],4)+","+fixed$(p1_via_above_f1[8],4)+","+fixed$(p1_via_above_f1[9],4)+","+fixed$(p1_via_above_f1[10],4)+","+fixed$(pa1_via_above_f1[1],4)+","+fixed$(pa1_via_above_f1[2],4)+","+fixed$(pa1_via_above_f1[3],4)+","+fixed$(pa1_via_above_f1[4],4)+","+fixed$(pa1_via_above_f1[5],4)+","+fixed$(pa1_via_above_f1[6],4)+","+fixed$(pa1_via_above_f1[7],4)+","+fixed$(pa1_via_above_f1[8],4)+","+fixed$(pa1_via_above_f1[9],4)+","+fixed$(pa1_via_above_f1[10],4)
                            
                            results$=results$+","+string$(rms[1])+","+string$(rms[2])+","+string$(rms[3])+","+string$(rms[4])+","+string$(rms[5])+","+string$(rms[6])+","+string$(rms[7])+","+string$(rms[8])+","+string$(rms[9])+","+string$(rms[10])
                        endif

                        # We save our results to a single variable which gets appended once the entire TextGrid has processed.
                        # By balancing offloading data every single TextGrid file to save on memory,
                        # and only opening the csv to append the file rarely, we improve speed for massive
                        results$ = results$ + newline$
                    endif
                endif
            endif
            results$ = replace$(results$, "--undefined--", "", 0)
            results$ = replace$(results$, "-99999", "", 0)
            results$ = replace$(results$, "99999", "", 0)
            appendFile: csv_file_path$, results$
            results$ = ""
        endfor

        nocheck removeObject: currentPitch
        nocheck removeObject: currentHarmonicity
        nocheck removeObject: currentIntensity
        nocheck removeObject: currentPointProcess
        nocheck removeObject: currentFormant
        nocheck removeObject: currentTextGrid
        nocheck removeObject: currentSound
    endif
endfor
nocheck removeObject: fileList

# Calculate the runtime
timeElapsed = clock() - runtimer
timerMessage$ = newline$ + "Process " + string$(process_index) + " of " + string$(number_of_cpu_cores) + " completed in "
if timeElapsed < 10
    appendInfoLine: timerMessage$, fixed$ (1000 * timeElapsed, 3), " milliseconds"
elsif timeElapsed < 60
    appendInfoLine: timerMessage$, fixed$ (timeElapsed, 3), " seconds"
elsif timeElapsed < 3600
    appendInfoLine: timerMessage$, fixed$ (timeElapsed / 60, 3), " minutes"
else
    appendInfoLine: timerMessage$, fixed$ (timeElapsed / 3600, 3), " hours"
endif