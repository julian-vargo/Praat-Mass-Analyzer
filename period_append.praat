writeInfoLine: "Initializing Praat Mass Analyzer"
appendInfoLine: newline$, "Vargo, Julian (2024). Praat Mass Analyzer [Computer Software]"
appendInfoLine: "University of California, Berkeley. Department of Spanish & Portuguese"

#####################################################################
#This section creates the form that pops up when you start the script.
#The syntax here is tricky, so I will break it down.
#"sentence" is the command to set a string variable. If my string is inputFolder, it will save to a variable called input_folder$ with a dollar sign.
    #There's no way to get around the dollar sign insertion.
#Be careful about underscores in your variable names in Praat. They can really mess things up.
#You'll notice when I write in Praat, I strictly use camel case. Never capitalize the first letter of a variable in Praat, never add spaces or underscores.
    #thisIsAnExampleOfCamelCase, variableName, julianVargo
#Strings take dollar signs and are non-numeric, integers and floats don't take dollar signs.
form Vargo 2025 - Praat Mass Analyzer
comment How to cite: Vargo, Julian (2025). Praat Mass Analyzer [Praat Script].
comment Department of Spanish & Portuguese. UC Berkeley.
comment -----
comment Please enter the file path where your TextGrids and Sounds are located.
	comment Enter all file paths like this:   C:\Users\...\folder
	sentence Input_folder C:\Users\julia\Downloads\misc\julian
	comment Please insert the desired file path and name of your output .csv file.
    comment This script writes the csv file for you, so you just need to supply a path.
	sentence Csv_file_path C:\Users\julia\Downloads\julian.csv
	comment Which tier number is the tier containing your phonemes/phones of interest?
	integer Phone_tier_number 2
    comment Which tier number is your word tier? Leave as 0 if none.
    integer Word_tier_number 1
    comment If you'd like details from a third tier, which number is it? Leave as 0 if none.
    integer Miscellaneous_tier_number 0
    comment Would you like to implement a Least Square Regression Formant Optimization?
    comment The LSRL Formant Optimization should only be used on small files
    boolean I_want_LSRL_formant_optimization 0
    boolean I_am_using_a_Windows_computer 1
endform

appendInfoLine: newline$, "This script will take a while to run while acoustic measurements are being gathered."
appendInfoLine: newline$, "Do not exit the program. Please stand by"

# Fancy schmancy way to strip quotation marks from file paths. Makes the script more flexible for the user.
quote$ = """"
input_folder$ = replace$(input_folder$, quote$, "", 0)
csv_file_path$ = replace$(csv_file_path$, quote$, "", 0)

header$ = "file_name,start_time,end_time,phoneme,word,misc_tier,duration,preceding_phone,following_phone,formant_ceiling,f0_10,f0_20,f0_30,f0_40,f0_50,f0_60,f0_70,f0_80,f0_90,f1_10,f1_20,f1_30,f1_40,f1_50,f1_60,f1_70,f1_80,f1_90,f2_10,f2_20,f2_30,f2_40,f2_50,f2_60,f2_70,f2_80,f2_90,f3_10,f3_20,f3_30,f3_40,f3_50,f3_60,f3_70,f3_80,f3_90,f4_10,f4_20,f4_30,f4_40,f4_50,f4_60,f4_70,f4_80,f4_90,f5_10,f5_20,f5_30,f5_40,f5_50,f5_60,f5_70,f5_80,f5_90,bandwidth1_10,bandwidth1_20,bandwidth1_30,bandwidth1_40,bandwidth1_50,bandwidth1_60,bandwidth1_70,bandwidth1_80,bandwidth1_90,bandwidth2_10,bandwidth2_20,bandwidth2_30,bandwidth2_40,bandwidth2_50,bandwidth2_60,bandwidth2_70,bandwidth2_80,bandwidth2_90,bandwidth3_10,bandwidth3_20,bandwidth3_30,bandwidth3_40,bandwidth3_50,bandwidth3_60,bandwidth3_70,bandwidth3_80,bandwidth3_90,bandwidth4_10,bandwidth4_20,bandwidth4_30,bandwidth4_40,bandwidth4_50,bandwidth4_60,bandwidth4_70,bandwidth4_80,bandwidth4_90,bandwidth5_10,bandwidth5_20,bandwidth5_30,bandwidth5_40,bandwidth5_50,bandwidth5_60,bandwidth5_70,bandwidth5_80,bandwidth5_90,f1_slope_20,f1_slope_30,f1_slope_40,f1_slope_50,f1_slope_60,f1_slope_70,f1_slope_80,f2_slope_20,f2_slope_30,f2_slope_40,f2_slope_50,f2_slope_60,f2_slope_70,f2_slope_80,f3_slope_20,f3_slope_30,f3_slope_40,f3_slope_50,f3_slope_60,f3_slope_70,f3_slope_80,f4_slope_20,f4_slope_30,f4_slope_40,f4_slope_50,f4_slope_60,f4_slope_70,f4_slope_80,f5_slope_20,f5_slope_30,f5_slope_40,f5_slope_50,f5_slope_60,f5_slope_70,f5_slope_80,articulatory_maximum,harmonicity_10,harmonicity_20,harmonicity_30,harmonicity_40,harmonicity_50,harmonicity_60,harmonicity_70,harmonicity_80,harmonicity_90,intensity_10,intensity_20,intensity_30,intensity_40,intensity_50,intensity_60,intensity_70,intensity_80,intensity_90,intensity_100,intensity_max,intensity_min,intensity_difference,jitter,shimmer,cog,cogSD,skewness,kurtosis,a1p0_10,a1p0_20,a1p0_30,a1p0_40,a1p0_50,a1p0_60,a1p0_70,a1p0_80,a1p0_90"

if i_want_LSRL_formant_optimization = 0
    header$ = replace$(header$, "formant_ceiling,", "", 1)
endif
if miscellaneous_tier_number = 0
    header$ = replace$(header$, "misc_tier,", "", 1)
endif

writeFileLine: csv_file_path$, header$
header$ = ""

formant_ceiling = 5500
currentResults$ = ""
results$ = ""

#This makes your script file-folder batchable. Backslashes only work on windows and forward slashes are for mac.
#You'll notice a lot of incoming if statements related to this. Basically, Praat needs to know whether your operating system uses forward slashes or backslashes
#Otherwise it can't read the file from your computer :(
if i_am_using_a_Windows_computer = 1
    fileList = Create Strings as file list: "fileList", input_folder$ + "\\" +"*.TextGrid"
    numberOfFiles = Get number of strings
else
    fileList = Create Strings as file list: "fileList", input_folder$ + "/" +"*.TextGrid"
    numberOfFiles = Get number of strings
endif
for file to numberOfFiles
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
    currentSound$ = selected$("Sound")
    selectObject: currentTextGrid

    #Gather the number of intervals on your phoneme/phone tier. Stores this value to a variable called numberOfIntervals
    numberOfIntervals = Get number of intervals: phone_tier_number
    Convert to Unicode
    
    #This section creates objects in your Praat Objects menu. These are really important, they're basically temporary files will all of the pitch, harmonicity, intensity, periodicity, formant data that you'll need for any acoustic analysis.
    #If you ever want to extract data such as a formant, you've got to make a formant object, then select the formant object then run the command "Get value at time".
    #You'll notice a bunch of numbers that go into the creation of the objects. I suggest reading the Praat manual on these numbers.
    #Google "Sound: To Pitch Praat" and then go to the Praat website. You'll see that this command takes time_step, pitch_floor, and pitch_ceiling
    #That's what the 0, 50, and 800 mean in the line that sets current pitch. Google is your friend for understanding what all of these numbers mean.
    #I carefully selected these numbers so the script can be used for a wide range of data as-is, but you can change them to match your needs.

    #Creates a Pitch Object. 
    select Sound 'currentSound$'
    currentPitch = To Pitch... 0 50 800
    #Creates a Harmonicity Object, useful for both obstruent analysis and voice quality analysis.
    select Sound 'currentSound$'
    currentHarmonicity = To Harmonicity (cc)... 0.01 75 0.1 4.5
    #Creates an Intensity Object
    select Sound 'currentSound$'
    currentIntensity = To Intensity... 50 0 yes
    #Creates a Point Process object, which is the object type used to gather jitter and shimmer.
    select Sound 'currentSound$'
    currentPointProcess = To PointProcess (periodic, cc)... 50 800
    if i_want_LSRL_formant_optimization = 0
        #Creates a Formant Object. With the formant object, we can gather formant values and formant bandwidths. Change '5500' to '5000' if your data has mostly male speakers.
        formantCeiling = 5500
        select Sound 'currentSound$'
        currentFormant = To Formant (burg)... 0 5 formantCeiling 0.025 50
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

                    duration = thisPhonemeEndTime - thisPhonemeStartTime
                    tenpercent = thisPhonemeStartTime + duration/10
                    twentypercent = thisPhonemeStartTime + duration/5
                    thirtypercent = thisPhonemeStartTime + (duration*3)/10
                    fortypercent = thisPhonemeStartTime + (duration*2)/5
                    fiftypercent = thisPhonemeStartTime + duration/2
                    sixtypercent = thisPhonemeStartTime + (duration*3)/5
                    seventypercent = thisPhonemeStartTime + (duration*7)/10
                    eightypercent = thisPhonemeStartTime + (duration*4)/5
                    ninetypercent = thisPhonemeStartTime + (duration*9)/10

                    currentWord$ = "--undefined--"
                    if word_tier_number <> 0
                        currentWordInterval = Get interval at time: word_tier_number, fiftypercent
                        currentWord$ = Get label of interval: word_tier_number, currentWordInterval
                    endif
                    currentTask$ = "--undefined--"
                    if miscellaneous_tier_number <> 0
                        currentTaskInterval = Get interval at time: miscellaneous_tier_number, fiftypercent
                        currentTask$ = Get label of interval: miscellaneous_tier_number, currentTaskInterval
                    endif

                    #We're going to first select our Pitch object and then gather pitch at the 10% through 90% points
                    selectObject: currentPitch
                    f0_10 = Get value at time... tenpercent Hertz Linear
                    f0_20 = Get value at time... twentypercent Hertz Linear
                    f0_30 = Get value at time... thirtypercent Hertz Linear
                    f0_40 = Get value at time... fortypercent Hertz Linear
                    f0_50 = Get value at time... fiftypercent Hertz Linear
                    f0_60 = Get value at time... sixtypercent Hertz Linear
                    f0_70 = Get value at time... seventypercent Hertz Linear
                    f0_80 = Get value at time... eightypercent Hertz Linear
                    f0_90 = Get value at time... ninetypercent Hertz Linear
                    if i_want_LSRL_formant_optimization = 1
                        selectObject: currentSound
                        miniSound = Extract part... thisPhonemeStartTime thisPhonemeEndTime hamming 1 on
                        selectObject: miniSound
                        miniStart = Get start time
                        miniEnd = Get end time
                        miniDuration = miniEnd - miniStart
                        calcStart = miniStart + (miniDuration * 0.25)
                        calcEnd = miniEnd - (miniDuration * 0.25)
                        maxRSquared = -99999
                        formantCeiling = 5500
                        for k from 1 to 41
                            currentCeiling = (50 * (k)) + 4450
                            procedure lsrlFormant: currentCeiling
                                windowLength = 0.025
                                if windowLength <  miniDuration
                                    selectObject: miniSound
                                    miniFormant = To Formant (burg)... 0 5 currentCeiling windowLength 50
                                    miniTotal1 = 0
                                    miniTotal2 = 0
                                    miniTotal3 = 0
                                    for m from 1 to 11
                                        miniTime [m] = calcStart + (m * (calcEnd - calcStart)) / 11
                                        t = miniTime [m]
                                        miniValue1 [m] = Get value at time... 1 t Hertz Linear
                                        miniTotal1 = miniTotal1 + miniValue1[m]
                                        miniValue2 [m] = Get value at time... 2 t Hertz Linear
                                        miniTotal2 = miniTotal2 + miniValue2[m]
                                        miniValue3 [m] = Get value at time... 3 t Hertz Linear
                                        miniTotal3 = miniTotal3 + miniValue3[m]
                                    endfor
                                    removeObject: miniFormant
                                    miniAvg1 = miniTotal1 / 11
                                    miniAvg2 = miniTotal2 / 11
                                    miniAvg3 = miniTotal3 / 11
                                    sumMiniNumerator1 = 0
                                    sumMiniNumerator2 = 0
                                    sumMiniNumerator3 = 0
                                    sumMiniDenominator = 0
                                    for m from 1 to 11
                                        sumMiniNumerator1 = sumMiniNumerator1 + (miniTime[m] - miniTime[5])*(miniValue1[m]-miniAvg1)
                                        sumMiniNumerator2 = sumMiniNumerator2 + (miniTime[m] - miniTime[5])*(miniValue2[m]-miniAvg2)
                                        sumMiniNumerator3 = sumMiniNumerator3 + (miniTime[m] - miniTime[5])*(miniValue3[m]-miniAvg3)
                                        sumMiniDenominator = sumMiniDenominator + ((miniTime[m] - miniTime[5])*(miniTime[m] - miniTime[5]))
                                    endfor
                                    miniSlope1 = sumMiniNumerator1/sumMiniDenominator
                                    miniSlope2 = sumMiniNumerator2/sumMiniDenominator
                                    miniSlope3 = sumMiniNumerator3/sumMiniDenominator
                                    miniIntercept1 = miniAvg1 - (miniTime[5])*miniSlope1
                                    miniIntercept2 = miniAvg2 - (miniTime[5])*miniSlope2
                                    miniIntercept3 = miniAvg3 - (miniTime[5])*miniSlope3
                                    sSE1 = 0
                                    sST1 = 0
                                    sSE2 = 0
                                    sST2 = 0
                                    sSE3 = 0
                                    sST3 = 0
                                    for m from 1 to 11
                                        yhat1 = miniSlope1 * miniTime[m] + miniIntercept1
                                        yhat2 = miniSlope2 * miniTime[m] + miniIntercept2
                                        yhat3 = miniSlope3 * miniTime[m] + miniIntercept3
                                        err1  = miniValue1[m] - yhat1
                                        err2  = miniValue2[m] - yhat2
                                        err3  = miniValue3[m] - yhat3
                                        sSE1 = sSE1 + err1 * err1
                                        sSE2 = sSE2 + err2 * err2
                                        sSE3 = sSE3 + err3 * err3
                                        sST1 = sST1 + (miniValue1[m] - miniAvg1) * (miniValue1[m] - miniAvg1)
                                        sST2 = sST2 + (miniValue2[m] - miniAvg2) * (miniValue2[m] - miniAvg2)
                                        sST3 = sST3 + (miniValue3[m] - miniAvg3) * (miniValue3[m] - miniAvg3)
                                    endfor
                                    rSquaredTotal = -99999
                                    if sST1 <> 0
                                        if sST2 <> 0
                                            if sST3 <> 0
                                                rSquared1 = 1 - (sSE1 / sST1)
                                                rSquared2 = 1 - (sSE2 / sST2)
                                                rSquared3 = 1 - (sSE3 / sST3)
                                                rSquaredTotal = (rSquared1 + rSquared2 + rSquared3) / 3
                                            endif
                                        endif
                                    endif
                                endif
                            endproc
                            @lsrlFormant: currentCeiling
                            if rSquaredTotal > maxRSquared
                                maxRSquared = rSquaredTotal
                                formantCeiling = currentCeiling
                                firstOptimizationCeiling = formantCeiling
                            endif
                        endfor
                        runSecondOptimization = 1
                        if maxRSquared = -99999
                            formantCeiling = 5500
                            runSecondOptimization = 0
                        endif
                        
                        maxRSquared = -99999
                        runFinalOptimization = 0
                        if runSecondOptimization = 1
                            for k from 1 to 19
                                currentCeiling = (10 * (k)) + formantCeiling - 100
                                @lsrlFormant: currentCeiling
                                if rSquaredTotal > maxRSquared
                                    maxRSquared = rSquaredTotal
                                    formantCeiling = currentCeiling
                                    secondOptimizationCeiling = formantCeiling
                                endif
                            endfor
                            runFinalOptimization = 1
                            if maxRSquared = -99999
                                formantCeiling = firstOptimizationCeiling
                                runFinalOptimization = 0
                            endif
                        endif
                        
                        maxRSquared = -99999
                        if runFinalOptimization = 1
                            for k from 1 to 19
                                currentCeiling = k + formantCeiling - 10
                                @lsrlFormant: currentCeiling
                                if rSquaredTotal > maxRSquared
                                    maxRSquared = rSquaredTotal
                                    formantCeiling = currentCeiling
                                    secondOptimizationCeiling = formantCeiling
                                endif
                            endfor
                            if maxRSquared = -99999
                                formantCeiling = secondOptimizationCeiling
                            endif
                        endif
                        selectObject: miniSound
                        currentFormant = To Formant (burg)... 0 5 formantCeiling 0.025 50
                        mini10 = miniDuration * 0.1
                        mini20 = miniDuration * 0.2
                        mini30 = miniDuration * 0.3
                        mini40 = miniDuration * 0.4
                        mini50 = miniDuration * 0.5
                        mini60 = miniDuration * 0.6
                        mini70 = miniDuration * 0.7
                        mini80 = miniDuration * 0.8
                        mini90 = miniDuration * 0.9
                        f1_10 = Get value at time... 1 mini10 Hertz Linear
                        f1_20 = Get value at time... 1 mini20 Hertz Linear
                        f1_30 = Get value at time... 1 mini30 Hertz Linear
                        f1_40 = Get value at time... 1 mini40 Hertz Linear
                        f1_50 = Get value at time... 1 mini50 Hertz Linear
                        f1_60 = Get value at time... 1 mini60 Hertz Linear
                        f1_70 = Get value at time... 1 mini70 Hertz Linear
                        f1_80 = Get value at time... 1 mini80 Hertz Linear
                        f1_90 = Get value at time... 1 mini90 Hertz Linear
                        f2_10 = Get value at time... 2 mini10 Hertz Linear
                        f2_20 = Get value at time... 2 mini20 Hertz Linear
                        f2_30 = Get value at time... 2 mini30 Hertz Linear
                        f2_40 = Get value at time... 2 mini40 Hertz Linear
                        f2_50 = Get value at time... 2 mini50 Hertz Linear
                        f2_60 = Get value at time... 2 mini60 Hertz Linear
                        f2_70 = Get value at time... 2 mini70 Hertz Linear
                        f2_80 = Get value at time... 2 mini80 Hertz Linear
                        f2_90 = Get value at time... 2 mini90 Hertz Linear
                        f3_10 = Get value at time... 3 mini10 Hertz Linear
                        f3_20 = Get value at time... 3 mini20 Hertz Linear
                        f3_30 = Get value at time... 3 mini30 Hertz Linear
                        f3_40 = Get value at time... 3 mini40 Hertz Linear
                        f3_50 = Get value at time... 3 mini50 Hertz Linear
                        f3_60 = Get value at time... 3 mini60 Hertz Linear
                        f3_70 = Get value at time... 3 mini70 Hertz Linear
                        f3_80 = Get value at time... 3 mini80 Hertz Linear
                        f3_90 = Get value at time... 3 mini90 Hertz Linear
                        f4_10 = Get value at time... 4 mini10 Hertz Linear
                        f4_20 = Get value at time... 4 mini20 Hertz Linear
                        f4_30 = Get value at time... 4 mini30 Hertz Linear
                        f4_40 = Get value at time... 4 mini40 Hertz Linear
                        f4_50 = Get value at time... 4 mini50 Hertz Linear
                        f4_60 = Get value at time... 4 mini60 Hertz Linear
                        f4_70 = Get value at time... 4 mini70 Hertz Linear
                        f4_80 = Get value at time... 4 mini80 Hertz Linear
                        f4_90 = Get value at time... 4 mini90 Hertz Linear
                        f5_10 = Get value at time... 5 mini10 Hertz Linear
                        f5_20 = Get value at time... 5 mini20 Hertz Linear
                        f5_30 = Get value at time... 5 mini30 Hertz Linear
                        f5_40 = Get value at time... 5 mini40 Hertz Linear
                        f5_50 = Get value at time... 5 mini50 Hertz Linear
                        f5_60 = Get value at time... 5 mini60 Hertz Linear
                        f5_70 = Get value at time... 5 mini70 Hertz Linear
                        f5_80 = Get value at time... 5 mini80 Hertz Linear
                        f5_90 = Get value at time... 5 mini90 Hertz Linear
                        bandwidth1_10 = Get bandwidth at time... 1 mini10 Hertz Linear
                        bandwidth1_20 = Get bandwidth at time... 1 mini20 Hertz Linear
                        bandwidth1_30 = Get bandwidth at time... 1 mini30 Hertz Linear
                        bandwidth1_40 = Get bandwidth at time... 1 mini40 Hertz Linear
                        bandwidth1_50 = Get bandwidth at time... 1 mini50 Hertz Linear
                        bandwidth1_60 = Get bandwidth at time... 1 mini60 Hertz Linear
                        bandwidth1_70 = Get bandwidth at time... 1 mini70 Hertz Linear
                        bandwidth1_80 = Get bandwidth at time... 1 mini80 Hertz Linear
                        bandwidth1_90 = Get bandwidth at time... 1 mini90 Hertz Linear
                        bandwidth2_10 = Get bandwidth at time... 2 mini10 Hertz Linear
                        bandwidth2_20 = Get bandwidth at time... 2 mini20 Hertz Linear
                        bandwidth2_30 = Get bandwidth at time... 2 mini30 Hertz Linear
                        bandwidth2_40 = Get bandwidth at time... 2 mini40 Hertz Linear
                        bandwidth2_50 = Get bandwidth at time... 2 mini50 Hertz Linear
                        bandwidth2_60 = Get bandwidth at time... 2 mini60 Hertz Linear
                        bandwidth2_70 = Get bandwidth at time... 2 mini70 Hertz Linear
                        bandwidth2_80 = Get bandwidth at time... 2 mini80 Hertz Linear
                        bandwidth2_90 = Get bandwidth at time... 2 mini90 Hertz Linear
                        bandwidth3_10 = Get bandwidth at time... 3 mini10 Hertz Linear
                        bandwidth3_20 = Get bandwidth at time... 3 mini20 Hertz Linear
                        bandwidth3_30 = Get bandwidth at time... 3 mini30 Hertz Linear
                        bandwidth3_40 = Get bandwidth at time... 3 mini40 Hertz Linear
                        bandwidth3_50 = Get bandwidth at time... 3 mini50 Hertz Linear
                        bandwidth3_60 = Get bandwidth at time... 3 mini60 Hertz Linear
                        bandwidth3_70 = Get bandwidth at time... 3 mini70 Hertz Linear
                        bandwidth3_80 = Get bandwidth at time... 3 mini80 Hertz Linear
                        bandwidth3_90 = Get bandwidth at time... 3 mini90 Hertz Linear
                        bandwidth4_10 = Get bandwidth at time... 4 mini10 Hertz Linear
                        bandwidth4_20 = Get bandwidth at time... 4 mini20 Hertz Linear
                        bandwidth4_30 = Get bandwidth at time... 4 mini30 Hertz Linear
                        bandwidth4_40 = Get bandwidth at time... 4 mini40 Hertz Linear
                        bandwidth4_50 = Get bandwidth at time... 4 mini50 Hertz Linear
                        bandwidth4_60 = Get bandwidth at time... 4 mini60 Hertz Linear
                        bandwidth4_70 = Get bandwidth at time... 4 mini70 Hertz Linear
                        bandwidth4_80 = Get bandwidth at time... 4 mini80 Hertz Linear
                        bandwidth4_90 = Get bandwidth at time... 4 mini90 Hertz Linear
                        bandwidth5_10 = Get bandwidth at time... 5 mini10 Hertz Linear
                        bandwidth5_20 = Get bandwidth at time... 5 mini20 Hertz Linear
                        bandwidth5_30 = Get bandwidth at time... 5 mini30 Hertz Linear
                        bandwidth5_40 = Get bandwidth at time... 5 mini40 Hertz Linear
                        bandwidth5_50 = Get bandwidth at time... 5 mini50 Hertz Linear
                        bandwidth5_60 = Get bandwidth at time... 5 mini60 Hertz Linear
                        bandwidth5_70 = Get bandwidth at time... 5 mini70 Hertz Linear
                        bandwidth5_80 = Get bandwidth at time... 5 mini80 Hertz Linear
                        bandwidth5_90 = Get bandwidth at time... 5 mini90 Hertz Linear
                        f1_slope_20 = ((f1_30 - f1_10) / (mini30 - mini10))
                        f1_slope_30 = ((f1_40 - f1_20) / (mini40 - mini20))
                        f1_slope_40 = ((f1_50 - f1_30) / (mini50 - mini30))
                        f1_slope_50 = ((f1_60 - f1_40) / (mini60 - mini40))
                        f1_slope_60 = ((f1_70 - f1_50) / (mini70 - mini50))
                        f1_slope_70 = ((f1_80 - f1_60) / (mini80 - mini60))
                        f1_slope_80 = ((f1_90 - f1_70) / (mini90 - mini70))
                        f2_slope_20 = ((f2_30 - f2_10) / (mini30 - mini10))
                        f2_slope_30 = ((f2_40 - f2_20) / (mini40 - mini20))
                        f2_slope_40 = ((f2_50 - f2_30) / (mini50 - mini30))
                        f2_slope_50 = ((f2_60 - f2_40) / (mini60 - mini40))
                        f2_slope_60 = ((f2_70 - f2_50) / (mini70 - mini50))
                        f2_slope_70 = ((f2_80 - f2_60) / (mini80 - mini60))
                        f2_slope_80 = ((f2_90 - f2_70) / (mini90 - mini70))
                        f3_slope_20 = ((f3_30 - f3_10) / (mini30 - mini10))
                        f3_slope_30 = ((f3_40 - f3_20) / (mini40 - mini20))
                        f3_slope_40 = ((f3_50 - f3_30) / (mini50 - mini30))
                        f3_slope_50 = ((f3_60 - f3_40) / (mini60 - mini40))
                        f3_slope_60 = ((f3_70 - f3_50) / (mini70 - mini50))
                        f3_slope_70 = ((f3_80 - f3_60) / (mini80 - mini60))
                        f3_slope_80 = ((f3_90 - f3_70) / (mini90 - mini70))
                        f4_slope_20 = ((f4_30 - f4_10) / (mini30 - mini10))
                        f4_slope_30 = ((f4_40 - f4_20) / (mini40 - mini20))
                        f4_slope_40 = ((f4_50 - f4_30) / (mini50 - mini30))
                        f4_slope_50 = ((f4_60 - f4_40) / (mini60 - mini40))
                        f4_slope_60 = ((f4_70 - f4_50) / (mini70 - mini50))
                        f4_slope_70 = ((f4_80 - f4_60) / (mini80 - mini60))
                        f4_slope_80 = ((f4_90 - f4_70) / (mini90 - mini70))
                        f5_slope_20 = ((f5_30 - f5_10) / (mini30 - mini10))
                        f5_slope_30 = ((f5_40 - f5_20) / (mini40 - mini20))
                        f5_slope_40 = ((f5_50 - f5_30) / (mini50 - mini30))
                        f5_slope_50 = ((f5_60 - f5_40) / (mini60 - mini40))
                        f5_slope_60 = ((f5_70 - f5_50) / (mini70 - mini50))
                        f5_slope_70 = ((f5_80 - f5_60) / (mini80 - mini60))
                        f5_slope_80 = ((f5_90 - f5_70) / (mini90 - mini70))
                        removeObject: currentFormant
                        removeObject: miniSound
                    endif

                    if i_want_LSRL_formant_optimization = 0
                        #Next we're going to select our formant object. With the formant object we can calculate formant frequencies, bandwidths, and slopes
                        selectObject: currentFormant
                        f1_10 = Get value at time... 1 tenpercent Hertz Linear
                        f1_20 = Get value at time... 1 twentypercent Hertz Linear
                        f1_30 = Get value at time... 1 thirtypercent Hertz Linear
                        f1_40 = Get value at time... 1 fortypercent Hertz Linear
                        f1_50 = Get value at time... 1 fiftypercent Hertz Linear
                        f1_60 = Get value at time... 1 sixtypercent Hertz Linear
                        f1_70 = Get value at time... 1 seventypercent Hertz Linear
                        f1_80 = Get value at time... 1 eightypercent Hertz Linear
                        f1_90 = Get value at time... 1 ninetypercent Hertz Linear
                        f2_10 = Get value at time... 2 tenpercent Hertz Linear
                        f2_20 = Get value at time... 2 twentypercent Hertz Linear
                        f2_30 = Get value at time... 2 thirtypercent Hertz Linear
                        f2_40 = Get value at time... 2 fortypercent Hertz Linear
                        f2_50 = Get value at time... 2 fiftypercent Hertz Linear
                        f2_60 = Get value at time... 2 sixtypercent Hertz Linear
                        f2_70 = Get value at time... 2 seventypercent Hertz Linear
                        f2_80 = Get value at time... 2 eightypercent Hertz Linear
                        f2_90 = Get value at time... 2 ninetypercent Hertz Linear
                        f3_10 = Get value at time... 3 tenpercent Hertz Linear
                        f3_20 = Get value at time... 3 twentypercent Hertz Linear
                        f3_30 = Get value at time... 3 thirtypercent Hertz Linear
                        f3_40 = Get value at time... 3 fortypercent Hertz Linear
                        f3_50 = Get value at time... 3 fiftypercent Hertz Linear
                        f3_60 = Get value at time... 3 sixtypercent Hertz Linear
                        f3_70 = Get value at time... 3 seventypercent Hertz Linear
                        f3_80 = Get value at time... 3 eightypercent Hertz Linear
                        f3_90 = Get value at time... 3 ninetypercent Hertz Linear
                        f4_10 = Get value at time... 4 tenpercent Hertz Linear
                        f4_20 = Get value at time... 4 twentypercent Hertz Linear
                        f4_30 = Get value at time... 4 thirtypercent Hertz Linear
                        f4_40 = Get value at time... 4 fortypercent Hertz Linear
                        f4_50 = Get value at time... 4 fiftypercent Hertz Linear
                        f4_60 = Get value at time... 4 sixtypercent Hertz Linear
                        f4_70 = Get value at time... 4 seventypercent Hertz Linear
                        f4_80 = Get value at time... 4 eightypercent Hertz Linear
                        f4_90 = Get value at time... 4 ninetypercent Hertz Linear
                        f5_10 = Get value at time... 5 tenpercent Hertz Linear
                        f5_20 = Get value at time... 5 twentypercent Hertz Linear
                        f5_30 = Get value at time... 5 thirtypercent Hertz Linear
                        f5_40 = Get value at time... 5 fortypercent Hertz Linear
                        f5_50 = Get value at time... 5 fiftypercent Hertz Linear
                        f5_60 = Get value at time... 5 sixtypercent Hertz Linear
                        f5_70 = Get value at time... 5 seventypercent Hertz Linear
                        f5_80 = Get value at time... 5 eightypercent Hertz Linear
                        f5_90 = Get value at time... 5 ninetypercent Hertz Linear
                        bandwidth1_10 = Get bandwidth at time... 1 tenpercent Hertz Linear
                        bandwidth1_20 = Get bandwidth at time... 1 twentypercent Hertz Linear
                        bandwidth1_30 = Get bandwidth at time... 1 thirtypercent Hertz Linear
                        bandwidth1_40 = Get bandwidth at time... 1 fortypercent Hertz Linear
                        bandwidth1_50 = Get bandwidth at time... 1 fiftypercent Hertz Linear
                        bandwidth1_60 = Get bandwidth at time... 1 sixtypercent Hertz Linear
                        bandwidth1_70 = Get bandwidth at time... 1 seventypercent Hertz Linear
                        bandwidth1_80 = Get bandwidth at time... 1 eightypercent Hertz Linear
                        bandwidth1_90 = Get bandwidth at time... 1 ninetypercent Hertz Linear
                        bandwidth2_10 = Get bandwidth at time... 2 tenpercent Hertz Linear
                        bandwidth2_20 = Get bandwidth at time... 2 twentypercent Hertz Linear
                        bandwidth2_30 = Get bandwidth at time... 2 thirtypercent Hertz Linear
                        bandwidth2_40 = Get bandwidth at time... 2 fortypercent Hertz Linear
                        bandwidth2_50 = Get bandwidth at time... 2 fiftypercent Hertz Linear
                        bandwidth2_60 = Get bandwidth at time... 2 sixtypercent Hertz Linear
                        bandwidth2_70 = Get bandwidth at time... 2 seventypercent Hertz Linear
                        bandwidth2_80 = Get bandwidth at time... 2 eightypercent Hertz Linear
                        bandwidth2_90 = Get bandwidth at time... 2 ninetypercent Hertz Linear
                        bandwidth3_10 = Get bandwidth at time... 3 tenpercent Hertz Linear
                        bandwidth3_20 = Get bandwidth at time... 3 twentypercent Hertz Linear
                        bandwidth3_30 = Get bandwidth at time... 3 thirtypercent Hertz Linear
                        bandwidth3_40 = Get bandwidth at time... 3 fortypercent Hertz Linear
                        bandwidth3_50 = Get bandwidth at time... 3 fiftypercent Hertz Linear
                        bandwidth3_60 = Get bandwidth at time... 3 sixtypercent Hertz Linear
                        bandwidth3_70 = Get bandwidth at time... 3 seventypercent Hertz Linear
                        bandwidth3_80 = Get bandwidth at time... 3 eightypercent Hertz Linear
                        bandwidth3_90 = Get bandwidth at time... 3 ninetypercent Hertz Linear
                        bandwidth4_10 = Get bandwidth at time... 4 tenpercent Hertz Linear
                        bandwidth4_20 = Get bandwidth at time... 4 twentypercent Hertz Linear
                        bandwidth4_30 = Get bandwidth at time... 4 thirtypercent Hertz Linear
                        bandwidth4_40 = Get bandwidth at time... 4 fortypercent Hertz Linear
                        bandwidth4_50 = Get bandwidth at time... 4 fiftypercent Hertz Linear
                        bandwidth4_60 = Get bandwidth at time... 4 sixtypercent Hertz Linear
                        bandwidth4_70 = Get bandwidth at time... 4 seventypercent Hertz Linear
                        bandwidth4_80 = Get bandwidth at time... 4 eightypercent Hertz Linear
                        bandwidth4_90 = Get bandwidth at time... 4 ninetypercent Hertz Linear
                        bandwidth5_10 = Get bandwidth at time... 5 tenpercent Hertz Linear
                        bandwidth5_20 = Get bandwidth at time... 5 twentypercent Hertz Linear
                        bandwidth5_30 = Get bandwidth at time... 5 thirtypercent Hertz Linear
                        bandwidth5_40 = Get bandwidth at time... 5 fortypercent Hertz Linear
                        bandwidth5_50 = Get bandwidth at time... 5 fiftypercent Hertz Linear
                        bandwidth5_60 = Get bandwidth at time... 5 sixtypercent Hertz Linear
                        bandwidth5_70 = Get bandwidth at time... 5 seventypercent Hertz Linear
                        bandwidth5_80 = Get bandwidth at time... 5 eightypercent Hertz Linear
                        bandwidth5_90 = Get bandwidth at time... 5 ninetypercent Hertz Linear
                        f1_slope_20 = ((f1_30 - f1_10) / (thirtypercent - tenpercent))
                        f1_slope_30 = ((f1_40 - f1_20) / (fortypercent - twentypercent))
                        f1_slope_40 = ((f1_50 - f1_30) / (fiftypercent - thirtypercent))
                        f1_slope_50 = ((f1_60 - f1_40) / (sixtypercent - fortypercent))
                        f1_slope_60 = ((f1_70 - f1_50) / (seventypercent - fiftypercent))
                        f1_slope_70 = ((f1_80 - f1_60) / (eightypercent - sixtypercent))
                        f1_slope_80 = ((f1_90 - f1_70) / (ninetypercent - seventypercent))
                        f2_slope_20 = ((f2_30 - f2_10) / (thirtypercent - tenpercent))
                        f2_slope_30 = ((f2_40 - f2_20) / (fortypercent - twentypercent))
                        f2_slope_40 = ((f2_50 - f2_30) / (fiftypercent - thirtypercent))
                        f2_slope_50 = ((f2_60 - f2_40) / (sixtypercent - fortypercent))
                        f2_slope_60 = ((f2_70 - f2_50) / (seventypercent - fiftypercent))
                        f2_slope_70 = ((f2_80 - f2_60) / (eightypercent - sixtypercent))
                        f2_slope_80 = ((f2_90 - f2_70) / (ninetypercent - seventypercent))
                        f3_slope_20 = ((f3_30 - f3_10) / (thirtypercent - tenpercent))
                        f3_slope_30 = ((f3_40 - f3_20) / (fortypercent - twentypercent))
                        f3_slope_40 = ((f3_50 - f3_30) / (fiftypercent - thirtypercent))
                        f3_slope_50 = ((f3_60 - f3_40) / (sixtypercent - fortypercent))
                        f3_slope_60 = ((f3_70 - f3_50) / (seventypercent - fiftypercent))
                        f3_slope_70 = ((f3_80 - f3_60) / (eightypercent - sixtypercent))
                        f3_slope_80 = ((f3_90 - f3_70) / (ninetypercent - seventypercent))
                        f4_slope_20 = ((f4_30 - f4_10) / (thirtypercent - tenpercent))
                        f4_slope_30 = ((f4_40 - f4_20) / (fortypercent - twentypercent))
                        f4_slope_40 = ((f4_50 - f4_30) / (fiftypercent - thirtypercent))
                        f4_slope_50 = ((f4_60 - f4_40) / (sixtypercent - fortypercent))
                        f4_slope_60 = ((f4_70 - f4_50) / (seventypercent - fiftypercent))
                        f4_slope_70 = ((f4_80 - f4_60) / (eightypercent - sixtypercent))
                        f4_slope_80 = ((f4_90 - f4_70) / (ninetypercent - seventypercent))
                        f5_slope_20 = ((f5_30 - f5_10) / (thirtypercent - tenpercent))
                        f5_slope_30 = ((f5_40 - f5_20) / (fortypercent - twentypercent))
                        f5_slope_40 = ((f5_50 - f5_30) / (fiftypercent - thirtypercent))
                        f5_slope_50 = ((f5_60 - f5_40) / (sixtypercent - fortypercent))
                        f5_slope_60 = ((f5_70 - f5_50) / (seventypercent - fiftypercent))
                        f5_slope_70 = ((f5_80 - f5_60) / (eightypercent - sixtypercent))
                        f5_slope_80 = ((f5_90 - f5_70) / (ninetypercent - seventypercent))
                    endif

                    velo_20 = sqrt((f2_slope_20)^2 + (f1_slope_20)^2)
                    velo_30 = sqrt((f2_slope_30)^2 + (f1_slope_30)^2)
                    velo_40 = sqrt((f2_slope_40)^2 + (f1_slope_40)^2)
                    velo_50 = sqrt((f2_slope_50)^2 + (f1_slope_50)^2)
                    velo_60 = sqrt((f2_slope_60)^2 + (f1_slope_60)^2)
                    velo_70 = sqrt((f2_slope_70)^2 + (f1_slope_70)^2)
                    velo_80 = sqrt((f2_slope_80)^2 + (f1_slope_80)^2)

            minVelo = velo_20
            art_max_percentile = 20
            
            if minVelo > velo_20
                minVelo = velo_20
                art_max_percentile = 20
            endif
            if minVelo > velo_30
                minVelo = velo_30
                art_max_percentile = 30
            endif
            if minVelo > velo_40
                minVelo = velo_40
                art_max_percentile = 40
            endif
            if minVelo > velo_50
                minVelo = velo_50
                art_max_percentile = 50
            endif
            if minVelo > velo_60
                minVelo = velo_60
                art_max_percentile = 60
            endif
            if minVelo > velo_70
                minVelo = velo_70
                art_max_percentile = 70
            endif
            if minVelo > velo_80
                minVelo = velo_80
                art_max_percentile = 80
            endif

                    #Gather harmonicity.
                    selectObject: currentHarmonicity
                    harmonicity_10 = Get value at time... tenpercent cubic
                    harmonicity_20 = Get value at time... twentypercent cubic
                    harmonicity_30 = Get value at time... thirtypercent cubic
                    harmonicity_40 = Get value at time... fortypercent cubic
                    harmonicity_50 = Get value at time... fiftypercent cubic
                    harmonicity_60 = Get value at time... sixtypercent cubic
                    harmonicity_70 = Get value at time... seventypercent cubic
                    harmonicity_80 = Get value at time... eightypercent cubic
                    harmonicity_90 = Get value at time... ninetypercent cubic

                    #This is the intensity section. We're going to gather mean intensities throughout the sound.
                    #We're also going to gather min, and max intensity.
                    #Lastly, we're going to include an intensity difference measure, which comes from Bongiovanni 2015 and is used for analysis of nasal stops.
                    selectObject: currentIntensity
                    intensity_10 = Get mean... thisPhonemeStartTime tenpercent dB
                    intensity_20 = Get mean... tenpercent twentypercent dB
                    intensity_30 = Get mean... twentypercent thirtypercent dB
                    intensity_40 = Get mean... thirtypercent fortypercent dB
                    intensity_50 = Get mean... fortypercent fiftypercent dB
                    intensity_60 = Get mean... fiftypercent sixtypercent dB
                    intensity_70 = Get mean... sixtypercent seventypercent dB
                    intensity_80 = Get mean... seventypercent eightypercent dB
                    intensity_90 = Get mean... eightypercent ninetypercent dB
                    intensity_100 = Get mean... ninetypercent thisPhonemeEndTime dB
                    intensity_max = Get maximum... thisPhonemeStartTime thisPhonemeEndTime Parabolic
                    intensity_min = Get minimum... thisPhonemeStartTime thisPhonemeEndTime Parabolic
                    if currentInterval > 1
                        selectObject: currentTextGrid
                        previous_initial_time = Get start point: phone_tier_number, precederNumber
                        selectObject: currentIntensity
                        previous_intensity_minimum = Get minimum... previous_initial_time thisPhonemeStartTime Parabolic
                        intensity_difference = intensity_max - previous_intensity_minimum
                    endif

                    ############# A1-P0 ###
                    p0_approx_10 = f1_10 - f0_10
                    p0_filterLowerBound_10 = p0_approx_10 - f0_10 / 4
                    p0_filterUpperBound_10 = p0_approx_10 + f0_10 / 4
                    a1_filterLowerBound_10 = f1_10 - f0_10 / 4
                    a1_filterUpperBound_10 = f1_10 + f0_10 / 4
                    segmentDuration_10 = duration * 0.1
                    mockLowerBound_10 = 6.45 / segmentDuration_10
                    p0_filterLowerBound_10$ = fixed$(p0_filterLowerBound_10, 10)

                    p0_approx_20 = f1_20 - f0_20
                    p0_filterLowerBound_20 = p0_approx_20 - f0_20 / 4
                    p0_filterUpperBound_20 = p0_approx_20 + f0_20 / 4
                    a1_filterLowerBound_20 = f1_20 - f0_20 / 4
                    a1_filterUpperBound_20 = f1_20 + f0_20 / 4
                    segmentDuration_20 = duration * 0.1
                    mockLowerBound_20 = 6.45 / segmentDuration_20
                    p0_filterLowerBound_20$ = fixed$(p0_filterLowerBound_20, 10)

                    p0_approx_30 = f1_30 - f0_30
                    p0_filterLowerBound_30 = p0_approx_30 - f0_30 / 4
                    p0_filterUpperBound_30 = p0_approx_30 + f0_30 / 4
                    a1_filterLowerBound_30 = f1_30 - f0_30 / 4
                    a1_filterUpperBound_30 = f1_30 + f0_30 / 4
                    segmentDuration_30 = duration * 0.1
                    mockLowerBound_30 = 6.45 / segmentDuration_30
                    p0_filterLowerBound_30$ = fixed$(p0_filterLowerBound_30, 10)

                    p0_approx_40 = f1_40 - f0_40
                    p0_filterLowerBound_40 = p0_approx_40 - f0_40 / 4
                    p0_filterUpperBound_40 = p0_approx_40 + f0_40 / 4
                    a1_filterLowerBound_40 = f1_40 - f0_40 / 4
                    a1_filterUpperBound_40 = f1_40 + f0_40 / 4
                    segmentDuration_40 = duration * 0.1
                    mockLowerBound_40 = 6.45 / segmentDuration_40
                    p0_filterLowerBound_40$ = fixed$(p0_filterLowerBound_40, 10)

                    p0_approx_50 = f1_50 - f0_50
                    p0_filterLowerBound_50 = p0_approx_50 - f0_50 / 4
                    p0_filterUpperBound_50 = p0_approx_50 + f0_50 / 4
                    a1_filterLowerBound_50 = f1_50 - f0_50 / 4
                    a1_filterUpperBound_50 = f1_50 + f0_50 / 4
                    segmentDuration_50 = duration * 0.1
                    mockLowerBound_50 = 6.45 / segmentDuration_50
                    p0_filterLowerBound_50$ = fixed$(p0_filterLowerBound_50, 10)

                    p0_approx_60 = f1_60 - f0_60
                    p0_filterLowerBound_60 = p0_approx_60 - f0_60 / 4
                    p0_filterUpperBound_60 = p0_approx_60 + f0_60 / 4
                    a1_filterLowerBound_60 = f1_60 - f0_60 / 4
                    a1_filterUpperBound_60 = f1_60 + f0_60 / 4
                    segmentDuration_60 = duration * 0.1
                    mockLowerBound_60 = 6.45 / segmentDuration_60
                    p0_filterLowerBound_60$ = fixed$(p0_filterLowerBound_60, 10)

                    p0_approx_70 = f1_70 - f0_70
                    p0_filterLowerBound_70 = p0_approx_70 - f0_70 / 4
                    p0_filterUpperBound_70 = p0_approx_70 + f0_70 / 4
                    a1_filterLowerBound_70 = f1_70 - f0_70 / 4
                    a1_filterUpperBound_70 = f1_70 + f0_70 / 4
                    segmentDuration_70 = duration * 0.1
                    mockLowerBound_70 = 6.45 / segmentDuration_70
                    p0_filterLowerBound_70$ = fixed$(p0_filterLowerBound_70, 10)

                    p0_approx_80 = f1_80 - f0_80
                    p0_filterLowerBound_80 = p0_approx_80 - f0_80 / 4
                    p0_filterUpperBound_80 = p0_approx_80 + f0_80 / 4
                    a1_filterLowerBound_80 = f1_80 - f0_80 / 4
                    a1_filterUpperBound_80 = f1_80 + f0_80 / 4
                    segmentDuration_80 = duration * 0.1
                    mockLowerBound_80 = 6.45 / segmentDuration_80
                    p0_filterLowerBound_80$ = fixed$(p0_filterLowerBound_80, 10)

                    p0_approx_90 = f1_90 - f0_90
                    p0_filterLowerBound_90 = p0_approx_90 - f0_90 / 4
                    p0_filterUpperBound_90 = p0_approx_90 + f0_90 / 4
                    a1_filterLowerBound_90 = f1_90 - f0_90 / 4
                    a1_filterUpperBound_90 = f1_90 + f0_90 / 4
                    segmentDuration_90 = duration * 0.1
                    mockLowerBound_90 = 6.45 / segmentDuration_90
                    p0_filterLowerBound_90$ = fixed$(p0_filterLowerBound_90, 10)

                    # The a1p0 code doesn't work right now - this is on the to-do list for me to finish.
                    # Email me if you need to do a study that extracts a1p0 and want to use this script.
                    a1p0_00 = 99999
                    a1p0_10 = 99999
                    a1p0_20 = 99999
                    a1p0_30 = 99999
                    a1p0_40 = 99999
                    a1p0_50 = 99999
                    a1p0_60 = 99999
                    a1p0_70 = 99999
                    a1p0_80 = 99999
                    a1p0_90 = 99999
                    a1 = 99999
                    p0 = 0
                    selectObject: currentSound
                    currentSoundChunk = Extract part... thisPhonemeStartTime thisPhonemeEndTime rectangular 1 on
                    selectObject: currentSoundChunk
                    miniStart = Get start time
                    miniEnd = Get end time
                    miniDuration = miniStart - miniEnd
                    mini10 = miniDuration * 0.1
                    mini20 = miniDuration * 0.2
                    mini30 = miniDuration * 0.3
                    mini40 = miniDuration * 0.4
                    mini50 = miniDuration * 0.5
                    mini60 = miniDuration * 0.6
                    mini70 = miniDuration * 0.7
                    mini80 = miniDuration * 0.8
                    mini90 = miniDuration * 0.9
                    #This section measures a1
                    procedure a1p0_proc: timea timeb a1_filterLowerBound a1_filterUpperBound p0_filterLowerBound p0_filterUpperBound mockLowerBound p0_filterLowerBound$
                        if p0_filterLowerBound$ <> "--undefined--"
                            selectObject: currentSoundChunk
                            currentSoundChunk2 = Filter (pass Hann band)... a1_filterLowerBound a1_filterUpperBound 1
                            currentIntensityChunk = To Intensity... mockLowerBound 0 yes
                            selectObject: currentSound
                            currentSoundChunk3 = Extract part... thisPhonemeStartTime thisPhonemeEndTime rectangular 1 on
                            selectObject: currentSoundChunk3
                            currentSoundChunk4 = Filter (pass Hann band)... p0_filterLowerBound p0_filterUpperBound 1
                            selectObject: currentSoundChunk4
                            currentIntensityChunk2 = To Intensity... mockLowerBound 0 yes
                            selectObject: currentIntensityChunk
                            a1 = Get maximum... timea timeb sinc70
                            selectObject: currentIntensityChunk2
                            p0 = Get maximum... timea timeb sinc70
                            removeObject: currentSoundChunk2
                            removeObject: currentIntensityChunk
                            removeObject: currentSoundChunk3
                            removeObject: currentSoundChunk4
                            removeObject: currentIntensityChunk2
                        endif
                    endproc
                    @a1p0_proc: mini10, mini20, a1_filterLowerBound_10, a1_filterUpperBound_10, p0_filterLowerBound_10, p0_filterUpperBound_10, mockLowerBound_10, p0_filterLowerBound_10$
                    a1p0_10 = a1 - p0
                    @a1p0_proc: mini20, mini30, a1_filterLowerBound_20, a1_filterUpperBound_20, p0_filterLowerBound_20, p0_filterUpperBound_20, mockLowerBound_20, p0_filterLowerBound_20$
                    a1p0_20 = a1 - p0
                    @a1p0_proc: mini30, mini40, a1_filterLowerBound_30, a1_filterUpperBound_30, p0_filterLowerBound_30, p0_filterUpperBound_30, mockLowerBound_30, p0_filterLowerBound_30$
                    a1p0_30 = a1 - p0
                    @a1p0_proc: mini40, mini50, a1_filterLowerBound_40, a1_filterUpperBound_40, p0_filterLowerBound_40, p0_filterUpperBound_40, mockLowerBound_40, p0_filterLowerBound_40$
                    a1p0_40 = a1 - p0
                    @a1p0_proc: mini50, mini60, a1_filterLowerBound_50, a1_filterUpperBound_50, p0_filterLowerBound_50, p0_filterUpperBound_50, mockLowerBound_50, p0_filterLowerBound_50$
                    a1p0_50 = a1 - p0
                    @a1p0_proc: mini60, mini70, a1_filterLowerBound_60, a1_filterUpperBound_60, p0_filterLowerBound_60, p0_filterUpperBound_60, mockLowerBound_60, p0_filterLowerBound_60$
                    a1p0_60 = a1 - p0
                    @a1p0_proc: mini70, mini80, a1_filterLowerBound_70, a1_filterUpperBound_70, p0_filterLowerBound_70, p0_filterUpperBound_70, mockLowerBound_70, p0_filterLowerBound_70$
                    a1p0_70 = a1 - p0
                    @a1p0_proc: mini80, mini90, a1_filterLowerBound_80, a1_filterUpperBound_80, p0_filterLowerBound_80, p0_filterUpperBound_80, mockLowerBound_80, p0_filterLowerBound_80$
                    a1p0_80 = a1 - p0
                    @a1p0_proc: mini90, thisPhonemeEndTime, a1_filterLowerBound_90, a1_filterUpperBound_90, p0_filterLowerBound_90, p0_filterUpperBound_90, mockLowerBound_90, p0_filterLowerBound_90$
                    a1p0_90 = a1 - p0
                    removeObject: currentSoundChunk

                    # Now we select the Point Process object to collect Jitter and Shimmer data. For some reason, the shimmer documentation is really sparse.
                    # The values arguments of the Jitter and Shimmer functions are startTime endTime periodFloor periodCeiling and maximumPeriodFactor which Boersma calls "the largest possible difference between consecutive intervals that will be used in the computation". Jitter documentation is fine, and shimmer commands follow the same structure as jitter.
                    selectObject: currentPointProcess
                    jitter = Get jitter (local, absolute)... thisPhonemeStartTime thisPhonemeEndTime 0.0001 0.02 1.3

                    selectObject: currentSound, currentPointProcess
                    shimmer = Get shimmer (local): thisPhonemeStartTime, thisPhonemeEndTime, 0.0001, 0.02, 1.3, 1.6
                    
                    # This is the final acoustical extraction, which creates spectrum objects.
                    # Praat's spectrum creation is **super** slow, so it's a requirement to extract sound chunks to make tiny spectral objects first.
                    selectObject: currentSound
                    currentSoundChunk = Extract part... thisPhonemeStartTime thisPhonemeEndTime rectangular 1 on
                    selectObject: currentSoundChunk
                    currentSpectrum = To Spectrum... yes
                    selectObject: currentSpectrum
                    cog = Get centre of gravity... 2
                    cogSD = Get standard deviation... 2
                    skewness = Get skewness... 2
                    kurtosis = Get kurtosis... 2
                    removeObject: currentSpectrum
                    removeObject: currentSoundChunk

                    thisPhonemeStartTime$ = fixed$(round(thisPhonemeStartTime * 10000)/10000, 10)
                    thisPhonemeEndTime$ = fixed$(round(thisPhonemeEndTime * 10000)/10000, 10)
                    duration$ = fixed$(round(duration * 10000)/10000, 10)
                    f0_10$ = fixed$(round(f0_10 * 10000)/10000, 10)
                    f0_20$ = fixed$(round(f0_20 * 10000)/10000, 10)
                    f0_30$ = fixed$(round(f0_30 * 10000)/10000, 10)
                    f0_40$ = fixed$(round(f0_40 * 10000)/10000, 10)
                    f0_50$ = fixed$(round(f0_50 * 10000)/10000, 10)
                    f0_60$ = fixed$(round(f0_60 * 10000)/10000, 10)
                    f0_70$ = fixed$(round(f0_70 * 10000)/10000, 10)
                    f0_80$ = fixed$(round(f0_80 * 10000)/10000, 10)
                    f0_90$ = fixed$(round(f0_90 * 10000)/10000, 10)

                    f1_10$ = fixed$(round(f1_10 * 10000)/10000, 10)
                    f1_20$ = fixed$(round(f1_20 * 10000)/10000, 10)
                    f1_30$ = fixed$(round(f1_30 * 10000)/10000, 10)
                    f1_40$ = fixed$(round(f1_40 * 10000)/10000, 10)
                    f1_50$ = fixed$(round(f1_50 * 10000)/10000, 10)
                    f1_60$ = fixed$(round(f1_60 * 10000)/10000, 10)
                    f1_70$ = fixed$(round(f1_70 * 10000)/10000, 10)
                    f1_80$ = fixed$(round(f1_80 * 10000)/10000, 10)
                    f1_90$ = fixed$(round(f1_90 * 10000)/10000, 10)

                    f2_10$ = fixed$(round(f2_10 * 10000)/10000, 10)
                    f2_20$ = fixed$(round(f2_20 * 10000)/10000, 10)
                    f2_30$ = fixed$(round(f2_30 * 10000)/10000, 10)
                    f2_40$ = fixed$(round(f2_40 * 10000)/10000, 10)
                    f2_50$ = fixed$(round(f2_50 * 10000)/10000, 10)
                    f2_60$ = fixed$(round(f2_60 * 10000)/10000, 10)
                    f2_70$ = fixed$(round(f2_70 * 10000)/10000, 10)
                    f2_80$ = fixed$(round(f2_80 * 10000)/10000, 10)
                    f2_90$ = fixed$(round(f2_90 * 10000)/10000, 10)

                    f3_10$ = fixed$(round(f3_10 * 10000)/10000, 10)
                    f3_20$ = fixed$(round(f3_20 * 10000)/10000, 10)
                    f3_30$ = fixed$(round(f3_30 * 10000)/10000, 10)
                    f3_40$ = fixed$(round(f3_40 * 10000)/10000, 10)
                    f3_50$ = fixed$(round(f3_50 * 10000)/10000, 10)
                    f3_60$ = fixed$(round(f3_60 * 10000)/10000, 10)
                    f3_70$ = fixed$(round(f3_70 * 10000)/10000, 10)
                    f3_80$ = fixed$(round(f3_80 * 10000)/10000, 10)
                    f3_90$ = fixed$(round(f3_90 * 10000)/10000, 10)

                    f4_10$ = fixed$(round(f4_10 * 10000)/10000, 10)
                    f4_20$ = fixed$(round(f4_20 * 10000)/10000, 10)
                    f4_30$ = fixed$(round(f4_30 * 10000)/10000, 10)
                    f4_40$ = fixed$(round(f4_40 * 10000)/10000, 10)
                    f4_50$ = fixed$(round(f4_50 * 10000)/10000, 10)
                    f4_60$ = fixed$(round(f4_60 * 10000)/10000, 10)
                    f4_70$ = fixed$(round(f4_70 * 10000)/10000, 10)
                    f4_80$ = fixed$(round(f4_80 * 10000)/10000, 10)
                    f4_90$ = fixed$(round(f4_90 * 10000)/10000, 10)

                    f5_10$ = fixed$(round(f5_10 * 10000)/10000, 10)
                    f5_20$ = fixed$(round(f5_20 * 10000)/10000, 10)
                    f5_30$ = fixed$(round(f5_30 * 10000)/10000, 10)
                    f5_40$ = fixed$(round(f5_40 * 10000)/10000, 10)
                    f5_50$ = fixed$(round(f5_50 * 10000)/10000, 10)
                    f5_60$ = fixed$(round(f5_60 * 10000)/10000, 10)
                    f5_70$ = fixed$(round(f5_70 * 10000)/10000, 10)
                    f5_80$ = fixed$(round(f5_80 * 10000)/10000, 10)
                    f5_90$ = fixed$(round(f5_90 * 10000)/10000, 10)

                    bandwidth1_10$ = fixed$(round(bandwidth1_10 * 10000)/10000, 10)
                    bandwidth1_20$ = fixed$(round(bandwidth1_20 * 10000)/10000, 10)
                    bandwidth1_30$ = fixed$(round(bandwidth1_30 * 10000)/10000, 10)
                    bandwidth1_40$ = fixed$(round(bandwidth1_40 * 10000)/10000, 10)
                    bandwidth1_50$ = fixed$(round(bandwidth1_50 * 10000)/10000, 10)
                    bandwidth1_60$ = fixed$(round(bandwidth1_60 * 10000)/10000, 10)
                    bandwidth1_70$ = fixed$(round(bandwidth1_70 * 10000)/10000, 10)
                    bandwidth1_80$ = fixed$(round(bandwidth1_80 * 10000)/10000, 10)
                    bandwidth1_90$ = fixed$(round(bandwidth1_90 * 10000)/10000, 10)

                    bandwidth2_10$ = fixed$(round(bandwidth2_10 * 10000)/10000, 10)
                    bandwidth2_20$ = fixed$(round(bandwidth2_20 * 10000)/10000, 10)
                    bandwidth2_30$ = fixed$(round(bandwidth2_30 * 10000)/10000, 10)
                    bandwidth2_40$ = fixed$(round(bandwidth2_40 * 10000)/10000, 10)
                    bandwidth2_50$ = fixed$(round(bandwidth2_50 * 10000)/10000, 10)
                    bandwidth2_60$ = fixed$(round(bandwidth2_60 * 10000)/10000, 10)
                    bandwidth2_70$ = fixed$(round(bandwidth2_70 * 10000)/10000, 10)
                    bandwidth2_80$ = fixed$(round(bandwidth2_80 * 10000)/10000, 10)
                    bandwidth2_90$ = fixed$(round(bandwidth2_90 * 10000)/10000, 10)

                    bandwidth3_10$ = fixed$(round(bandwidth3_10 * 10000)/10000, 10)
                    bandwidth3_20$ = fixed$(round(bandwidth3_20 * 10000)/10000, 10)
                    bandwidth3_30$ = fixed$(round(bandwidth3_30 * 10000)/10000, 10)
                    bandwidth3_40$ = fixed$(round(bandwidth3_40 * 10000)/10000, 10)
                    bandwidth3_50$ = fixed$(round(bandwidth3_50 * 10000)/10000, 10)
                    bandwidth3_60$ = fixed$(round(bandwidth3_60 * 10000)/10000, 10)
                    bandwidth3_70$ = fixed$(round(bandwidth3_70 * 10000)/10000, 10)
                    bandwidth3_80$ = fixed$(round(bandwidth3_80 * 10000)/10000, 10)
                    bandwidth3_90$ = fixed$(round(bandwidth3_90 * 10000)/10000, 10)

                    bandwidth4_10$ = fixed$(round(bandwidth4_10 * 10000)/10000, 10)
                    bandwidth4_20$ = fixed$(round(bandwidth4_20 * 10000)/10000, 10)
                    bandwidth4_30$ = fixed$(round(bandwidth4_30 * 10000)/10000, 10)
                    bandwidth4_40$ = fixed$(round(bandwidth4_40 * 10000)/10000, 10)
                    bandwidth4_50$ = fixed$(round(bandwidth4_50 * 10000)/10000, 10)
                    bandwidth4_60$ = fixed$(round(bandwidth4_60 * 10000)/10000, 10)
                    bandwidth4_70$ = fixed$(round(bandwidth4_70 * 10000)/10000, 10)
                    bandwidth4_80$ = fixed$(round(bandwidth4_80 * 10000)/10000, 10)
                    bandwidth4_90$ = fixed$(round(bandwidth4_90 * 10000)/10000, 10)

                    bandwidth5_10$ = fixed$(round(bandwidth5_10 * 10000)/10000, 10)
                    bandwidth5_20$ = fixed$(round(bandwidth5_20 * 10000)/10000, 10)
                    bandwidth5_30$ = fixed$(round(bandwidth5_30 * 10000)/10000, 10)
                    bandwidth5_40$ = fixed$(round(bandwidth5_40 * 10000)/10000, 10)
                    bandwidth5_50$ = fixed$(round(bandwidth5_50 * 10000)/10000, 10)
                    bandwidth5_60$ = fixed$(round(bandwidth5_60 * 10000)/10000, 10)
                    bandwidth5_70$ = fixed$(round(bandwidth5_70 * 10000)/10000, 10)
                    bandwidth5_80$ = fixed$(round(bandwidth5_80 * 10000)/10000, 10)
                    bandwidth5_90$ = fixed$(round(bandwidth5_90 * 10000)/10000, 10)

                    f1_slope_20$ = fixed$(round(f1_slope_20 * 10000)/10000, 10)
                    f1_slope_30$ = fixed$(round(f1_slope_30 * 10000)/10000, 10)
                    f1_slope_40$ = fixed$(round(f1_slope_40 * 10000)/10000, 10)
                    f1_slope_50$ = fixed$(round(f1_slope_50 * 10000)/10000, 10)
                    f1_slope_60$ = fixed$(round(f1_slope_60 * 10000)/10000, 10)
                    f1_slope_70$ = fixed$(round(f1_slope_70 * 10000)/10000, 10)
                    f1_slope_80$ = fixed$(round(f1_slope_80 * 10000)/10000, 10)

                    f2_slope_20$ = fixed$(round(f2_slope_20 * 10000)/10000, 10)
                    f2_slope_30$ = fixed$(round(f2_slope_30 * 10000)/10000, 10)
                    f2_slope_40$ = fixed$(round(f2_slope_40 * 10000)/10000, 10)
                    f2_slope_50$ = fixed$(round(f2_slope_50 * 10000)/10000, 10)
                    f2_slope_60$ = fixed$(round(f2_slope_60 * 10000)/10000, 10)
                    f2_slope_70$ = fixed$(round(f2_slope_70 * 10000)/10000, 10)
                    f2_slope_80$ = fixed$(round(f2_slope_80 * 10000)/10000, 10)

                    f3_slope_20$ = fixed$(round(f3_slope_20 * 10000)/10000, 10)
                    f3_slope_30$ = fixed$(round(f3_slope_30 * 10000)/10000, 10)
                    f3_slope_40$ = fixed$(round(f3_slope_40 * 10000)/10000, 10)
                    f3_slope_50$ = fixed$(round(f3_slope_50 * 10000)/10000, 10)
                    f3_slope_60$ = fixed$(round(f3_slope_60 * 10000)/10000, 10)
                    f3_slope_70$ = fixed$(round(f3_slope_70 * 10000)/10000, 10)
                    f3_slope_80$ = fixed$(round(f3_slope_80 * 10000)/10000, 10)

                    f4_slope_20$ = fixed$(round(f4_slope_20 * 10000)/10000, 10)
                    f4_slope_30$ = fixed$(round(f4_slope_30 * 10000)/10000, 10)
                    f4_slope_40$ = fixed$(round(f4_slope_40 * 10000)/10000, 10)
                    f4_slope_50$ = fixed$(round(f4_slope_50 * 10000)/10000, 10)
                    f4_slope_60$ = fixed$(round(f4_slope_60 * 10000)/10000, 10)
                    f4_slope_70$ = fixed$(round(f4_slope_70 * 10000)/10000, 10)
                    f4_slope_80$ = fixed$(round(f4_slope_80 * 10000)/10000, 10)

                    f5_slope_20$ = fixed$(round(f5_slope_20 * 10000)/10000, 10)
                    f5_slope_30$ = fixed$(round(f5_slope_30 * 10000)/10000, 10)
                    f5_slope_40$ = fixed$(round(f5_slope_40 * 10000)/10000, 10)
                    f5_slope_50$ = fixed$(round(f5_slope_50 * 10000)/10000, 10)
                    f5_slope_60$ = fixed$(round(f5_slope_60 * 10000)/10000, 10)
                    f5_slope_70$ = fixed$(round(f5_slope_70 * 10000)/10000, 10)
                    f5_slope_80$ = fixed$(round(f5_slope_80 * 10000)/10000, 10)

                    art_max_percentile$ = fixed$(round(art_max_percentile * 10000)/10000, 10)

                    harmonicity_10$ = fixed$(round(harmonicity_10 * 10000)/10000, 10)
                    harmonicity_20$ = fixed$(round(harmonicity_20 * 10000)/10000, 10)
                    harmonicity_30$ = fixed$(round(harmonicity_30 * 10000)/10000, 10)
                    harmonicity_40$ = fixed$(round(harmonicity_40 * 10000)/10000, 10)
                    harmonicity_50$ = fixed$(round(harmonicity_50 * 10000)/10000, 10)
                    harmonicity_60$ = fixed$(round(harmonicity_60 * 10000)/10000, 10)
                    harmonicity_70$ = fixed$(round(harmonicity_70 * 10000)/10000, 10)
                    harmonicity_80$ = fixed$(round(harmonicity_80 * 10000)/10000, 10)
                    harmonicity_90$ = fixed$(round(harmonicity_90 * 10000)/10000, 10)

                    intensity_10$ = fixed$(round(intensity_10 * 10000)/10000, 10)
                    intensity_20$ = fixed$(round(intensity_20 * 10000)/10000, 10)
                    intensity_30$ = fixed$(round(intensity_30 * 10000)/10000, 10)
                    intensity_40$ = fixed$(round(intensity_40 * 10000)/10000, 10)
                    intensity_50$ = fixed$(round(intensity_50 * 10000)/10000, 10)
                    intensity_60$ = fixed$(round(intensity_60 * 10000)/10000, 10)
                    intensity_70$ = fixed$(round(intensity_70 * 10000)/10000, 10)
                    intensity_80$ = fixed$(round(intensity_80 * 10000)/10000, 10)
                    intensity_90$ = fixed$(round(intensity_90 * 10000)/10000, 10)
                    intensity_100$ = fixed$(round(intensity_100 * 10000)/10000, 10)
                    intensity_max$ = fixed$(round(intensity_max * 10000)/10000, 10)
                    intensity_min$ = fixed$(round(intensity_min * 10000)/10000, 10)
                    intensity_difference$ = fixed$(round(intensity_difference * 10000)/10000, 10)

                    cog$ = fixed$(round(cog * 10000)/10000, 10)
                    cogSD$ = fixed$(round(cogSD * 10000)/10000, 10)
                    skewness$ = fixed$(round(skewness * 10000)/10000, 10)
                    kurtosis$ = fixed$(round(kurtosis * 10000)/10000, 10)

                    a1p0_10$ = fixed$(round(a1p0_10 * 10000)/10000, 10)
                    a1p0_20$ = fixed$(round(a1p0_20 * 10000)/10000, 10)
                    a1p0_30$ = fixed$(round(a1p0_30 * 10000)/10000, 10)
                    a1p0_40$ = fixed$(round(a1p0_40 * 10000)/10000, 10)
                    a1p0_50$ = fixed$(round(a1p0_50 * 10000)/10000, 10)
                    a1p0_60$ = fixed$(round(a1p0_60 * 10000)/10000, 10)
                    a1p0_70$ = fixed$(round(a1p0_70 * 10000)/10000, 10)
                    a1p0_80$ = fixed$(round(a1p0_80 * 10000)/10000, 10)
                    a1p0_90$ = fixed$(round(a1p0_90 * 10000)/10000, 10)

                    jitter$ = fixed$(jitter, 10)
                    shimmer$ = fixed$(shimmer, 10)
                    formantCeiling$ = fixed$(formantCeiling, 10)
                    currentFile$ = replace$(currentFile$, ".TextGrid", "", 0)
                    
                    if miscellaneous_tier_number = 0
                        currentTask$ = "#$"
                    endif

                    currentResults$ = currentFile$ + "," + thisPhonemeStartTime$ + "," + thisPhonemeEndTime$ + "," + thisPhoneme$ + "," + currentWord$ + "," + currentTask$ + "," + duration$ + "," + precedingPhoneme$ + "," + followingPhoneme$ + "," + formantCeiling$ + "," + f0_10$ + "," + f0_20$ + "," + f0_30$ + "," + f0_40$ + "," + f0_50$ + "," + f0_60$ + "," + f0_70$ + "," + f0_80$ + "," + f0_90$ + "," + f1_10$ + "," + f1_20$ + "," + f1_30$ + "," + f1_40$ + "," + f1_50$ + "," + f1_60$ + "," + f1_70$ + "," + f1_80$ + "," + f1_90$ + "," + f2_10$ + "," + f2_20$ + "," + f2_30$ + "," + f2_40$ + "," + f2_50$ + "," + f2_60$ + "," + f2_70$ + "," + f2_80$ + "," + f2_90$ + "," + f3_10$ + "," + f3_20$ + "," + f3_30$ + "," + f3_40$ + "," + f3_50$ + "," + f3_60$ + "," + f3_70$ + "," + f3_80$ + "," + f3_90$ + "," + f4_10$ + "," + f4_20$ + "," + f4_30$ + "," + f4_40$ + "," + f4_50$ + "," + f4_60$ + "," + f4_70$ + "," + f4_80$ + "," + f4_90$ + "," + f5_10$ + "," + f5_20$ + "," + f5_30$ + "," + f5_40$ + "," + f5_50$ + "," + f5_60$ + "," + f5_70$ + "," + f5_80$ + "," + f5_90$ + "," + bandwidth1_10$ + "," + bandwidth1_20$ + "," + bandwidth1_30$ + "," + bandwidth1_40$ + "," + bandwidth1_50$ + "," + bandwidth1_60$ + "," + bandwidth1_70$ + "," + bandwidth1_80$ + "," + bandwidth1_90$ + "," + bandwidth2_10$ + "," + bandwidth2_20$ + "," + bandwidth2_30$ + "," + bandwidth2_40$ + "," + bandwidth2_50$ + "," + bandwidth2_60$ + "," + bandwidth2_70$ + "," + bandwidth2_80$ + "," + bandwidth2_90$ + "," + bandwidth3_10$ + "," + bandwidth3_20$ + "," + bandwidth3_30$ + "," + bandwidth3_40$ + "," + bandwidth3_50$ + "," + bandwidth3_60$ + "," + bandwidth3_70$ + "," + bandwidth3_80$ + "," + bandwidth3_90$ + "," + bandwidth4_10$ + "," + bandwidth4_20$ + "," + bandwidth4_30$ + "," + bandwidth4_40$ + "," + bandwidth4_50$ + "," + bandwidth4_60$ + "," + bandwidth4_70$ + "," + bandwidth4_80$ + "," + bandwidth4_90$ + "," + bandwidth5_10$ + "," + bandwidth5_20$ + "," + bandwidth5_30$ + "," + bandwidth5_40$ + "," + bandwidth5_50$ + "," + bandwidth5_60$ + "," + bandwidth5_70$ + "," + bandwidth5_80$ + "," + bandwidth5_90$ + "," + f1_slope_20$ + "," + f1_slope_30$ + "," + f1_slope_40$ + "," + f1_slope_50$ + "," + f1_slope_60$ + "," + f1_slope_70$ + "," + f1_slope_80$ + "," + f2_slope_20$ + "," + f2_slope_30$ + "," + f2_slope_40$ + "," + f2_slope_50$ + "," + f2_slope_60$ + "," + f2_slope_70$ + "," + f2_slope_80$ + "," + f3_slope_20$ + "," + f3_slope_30$ + "," + f3_slope_40$ + "," + f3_slope_50$ + "," + f3_slope_60$ + "," + f3_slope_70$ + "," + f3_slope_80$ + "," + f4_slope_20$ + "," + f4_slope_30$ + "," + f4_slope_40$ + "," + f4_slope_50$ + "," + f4_slope_60$ + "," + f4_slope_70$ + "," + f4_slope_80$ + "," + f5_slope_20$ + "," + f5_slope_30$ + "," + f5_slope_40$ + "," + f5_slope_50$ + "," + f5_slope_60$ + "," + f5_slope_70$ + "," + f5_slope_80$ + "," + art_max_percentile$ + "," + harmonicity_10$ + "," + harmonicity_20$ + "," + harmonicity_30$ + "," + harmonicity_40$ + "," + harmonicity_50$ + "," + harmonicity_60$ + "," + harmonicity_70$ + "," + harmonicity_80$ + "," + harmonicity_90$ + "," + intensity_10$ + "," + intensity_20$ + "," + intensity_30$ + "," + intensity_40$ + "," + intensity_50$ + "," + intensity_60$ + "," + intensity_70$ + "," + intensity_80$ + "," + intensity_90$ + "," + intensity_100$ + "," + intensity_max$ + "," + intensity_min$ + "," + intensity_difference$ + "," + jitter$ + "," + shimmer$ + "," + cog$ + "," + cogSD$ + "," + skewness$ + "," + kurtosis$ + "," + a1p0_10$ + "," + a1p0_20$ + "," + a1p0_30$ + "," + a1p0_40$ + "," + a1p0_50$ + "," + a1p0_60$ + "," + a1p0_70$ + "," + a1p0_80$ + "," + a1p0_90$ + newline$
                    
                    currentResults$ = replace$(currentResults$, "--undefined--", "", 0)
                    currentResults$ = replace$(currentResults$, "-99999", "", 0)
                    currentResults$ = replace$(currentResults$, "99999", "", 0)
                    if i_want_LSRL_formant_optimization = 0
                        currentResults$ = replace$(currentResults$, formantCeiling$ + ",", "", 1)
                    endif
                    if miscellaneous_tier_number = 0
                        currentResults$ = replace$(currentResults$, "#$,", "", 1)
                    endif

                    results$ = results$ + currentResults$

                endif
            endif
        endif
        if currentInterval = numberOfIntervals
            appendFileLine: csv_file_path$, results$
            results$ = ""
            currentResults$ = ""
        endif
    endfor
    removeObject: currentPitch
    removeObject: currentHarmonicity
    removeObject: currentIntensity
    removeObject: currentPointProcess
    removeObject: currentSound
    if i_want_LSRL_formant_optimization = 0
        removeObject: currentFormant
    endif
    removeObject: currentTextGrid
endfor
removeObject: fileList

appendInfoLine: newline$, "SCRIPT COMPLETED SUCCESSFULLY! WOOHOO!"
for i from 1 to 3
freq = 2*(i*200)
Create Sound as pure tone: "sine",1, 0, 0.05, 44100, freq, 1, 0.01, 0.01
Play
Remove
endfor
