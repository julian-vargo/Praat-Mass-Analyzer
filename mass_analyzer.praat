writeInfoLine: "Initializing Praat Mass Analyzer"
appendInfoLine: newline$, "Vargo, Julian (2024). Praat Mass Analyzer [Computer Software]"
appendInfoLine: "University of California, Berkeley. Department of Spanish & Portuguese"

#####################################################################
#This section creates the form that pops up when you start the script.
#The syntax here is tricky, so I will break it down.
#"sentence" is the command to set a string variable. If my string is inputFolder, it will save to a variable called inputFolder$ with a dollar sign.
    #There's no way to get around the dollar sign insertion.
#Be careful about underscores in your variable names in Praat. They can really mess things up.
#You'll notice when I write in Praat, I strictly use camel case. Never capitalize the first letter of a variable in Praat, never add spaces or underscores.
    #thisIsAnExampleOfCamelCase, variableName, julianVargo
#Strings take dollar signs and are non-numeric, integers and floats don't take dollar signs.
form Vargo 2025 - Praat Mass Analyzer
	comment Please enter the file path where your TextGridsand Sounds are located
    comment If you have textgrids in the folder that don't have any sound files,
    comment then the script will break
	comment Enter all file paths without quotation marks:   C:\Users\...\folder
	sentence inputFolder C:\Users\julia\Downloads\research\muhsic\textgrid_aligned
	comment Please insert the desired file path and name of your output .csv file
	sentence csvName C:\Users\julia\Downloads\research\muhsic\textgrid_aligned\big_dataset.csv
	comment Which tier number is the tier containing your phonemes/phones of interest?
	integer phoneTierNumber 1
    comment Which tier number is your task type tier? Leave as 0 if none.
    integer taskTierNumber 0
    comment Which tier number is your word tier? Leave as 0 if none.
    integer wordTierNumber 0
    comment Are you on Windows or another operating system? 
    comment Don't use quotes. Type "windows" or "other"
    sentence operatingSystem other
endform

appendInfoLine: newline$, "This script will take a while to run while acoustic measurements are being gathered."
appendInfoLine: newline$, "Do not exit the program. Please stand by"

#This "writeFileLine" command has two sections, your actual file name and the name of your columns. The file name is csvName$, which was set during the form...
#in the previous section. The column names are everything afterwards. Column names aren't variables, so you can set these to whatever you please.
#Use a comma to write a new column name, and avoid using spaces in your column names otherwise coding languages like R might not know how to process your data.
writeFileLine: csvName$, "file_name,start_time,end_time,phoneme,word,task_type,duration,preceding_phone,following_phone,f0_10,f0_20,f0_30,f0_40,f0_50,f0_60,f0_70,f0_80,f0_90,f1_10,f1_20,f1_30,f1_40,f1_50,f1_60,f1_70,f1_80,f1_90,f2_10,f2_20,f2_30,f2_40,f2_50,f2_60,f2_70,f2_80,f2_90,f3_10,f3_20,f3_30,f3_40,f3_50,f3_60,f3_70,f3_80,f3_90,f4_10,f4_20,f4_30,f4_40,f4_50,f4_60,f4_70,f4_80,f4_90,f5_10,f5_20,f5_30,f5_40,f5_50,f5_60,f5_70,f5_80,f5_90,bandwidth1_10,bandwidth1_20,bandwidth1_30,bandwidth1_40,bandwidth1_50,bandwidth1_60,bandwidth1_70,bandwidth1_80,bandwidth1_90,bandwidth2_10,bandwidth2_20,bandwidth2_30,bandwidth2_40,bandwidth2_50,bandwidth2_60,bandwidth2_70,bandwidth2_80,bandwidth2_90,bandwidth3_10,bandwidth3_20,bandwidth3_30,bandwidth3_40,bandwidth3_50,bandwidth3_60,bandwidth3_70,bandwidth3_80,bandwidth3_90,bandwidth4_10,bandwidth4_20,bandwidth4_30,bandwidth4_40,bandwidth4_50,bandwidth4_60,bandwidth4_70,bandwidth4_80,bandwidth4_90,bandwidth5_10,bandwidth5_20,bandwidth5_30,bandwidth5_40,bandwidth5_50,bandwidth5_60,bandwidth5_70,bandwidth5_80,bandwidth5_90,f1_slope_20,f1_slope_30,f1_slope_40,f1_slope_50,f1_slope_60,f1_slope_70,f1_slope_80,f2_slope_20,f2_slope_30,f2_slope_40,f2_slope_50,f2_slope_60,f2_slope_70,f2_slope_80,f3_slope_20,f3_slope_30,f3_slope_40,f3_slope_50,f3_slope_60,f3_slope_70,f3_slope_80,f4_slope_20,f4_slope_30,f4_slope_40,f4_slope_50,f4_slope_60,f4_slope_70,f4_slope_80,f5_slope_20,f5_slope_30,f5_slope_40,f5_slope_50,f5_slope_60,f5_slope_70,f5_slope_80,harmonicity_10,harmonicity_20,harmonicity_30,harmonicity_40,harmonicity_50,harmonicity_60,harmonicity_70,harmonicity_80,harmonicity_90,intensity_10,intensity_20,intensity_30,intensity_40,intensity_50,intensity_60,intensity_70,intensity_80,intensity_90,intensity_100,intensity_max,intensity_min,intensity_difference,jitter,shimmer,cog,cogSD,skewness,kurtosis,END_OF_FORM_FOR_PROPER_DISPLAY_OF_DATA"

#This makes your script file-folder batchable. Backslashes only work on windows and forward slashes are for mac.
#You'll notice a lot of incoming if statements related to this. Basically, Praat needs to know whether your operating system uses forward slashes or backslashes
#Otherwise it can't read the file from your computer :(
if operatingSystem$ = "windows"
    #or operatingSystem$ = "Windows" or operatingSystem = "WINDOWS" or operatingSystem = "WindowsOS" or operatingSystem = "Windows OS"
    appendInfoLine: "Detected Windows as your Operating System"
    operatingSystem$ = "windows"
    fileList = Create Strings as file list: "fileList", inputFolder$ + "\" +"*.TextGrid"
    numberOfFiles = Get number of strings
else
    appendInfoLine: "Detected Mac, Linux, or a non-backslash operating system"
    operatingSystem$ = "mac"
    fileList = Create Strings as file list: "fileList", inputFolder$ + "/" +"*.TextGrid"
    numberOfFiles = Get number of strings
endif
for file to numberOfFiles
    #Just for fun. While you wait for your script, some fun facts will print to the Praat Info page
    factNumber = randomInteger (1, 30)
    appendInfoLine: newline$, "Here's a fun fact while you wait:"
    if factNumber = 1
        appendInfoLine: newline$, "A group of ferrets are called a fesnyng, the etymology of which traces back to a printing error."
    elsif factNumber = 2
        appendInfoLine: newline$, "The word, chortle, comes from the poem Jabberwocky by Lewis Caroll."
    elsif factNumber = 3
        appendInfoLine: newline$, "Fricatives can be syllable nuclei in the Nuxalk language."
    elsif factNumber = 4
        appendInfoLine: newline$, "nh is a digraph representing a palatal nasal stop in Portuguese."
    elsif factNumber = 5
        appendInfoLine: newline$, "Are special characters displaying weird in Excel? Try adding a BOM to your spreadsheet."
    elsif factNumber = 6
        appendInfoLine: newline$, "Thums Up is a drink closely related to Coca Cola and is especially popular in India."
    elsif factNumber = 7
        appendInfoLine: newline$, "Google street view cars in Kenya have a snorkel sticking out of the front of them."
    elsif factNumber = 8
        appendInfoLine: newline$, "Some people use the Russian word, blin, meaning pancakes, as a politcally correct curse-word."
    elsif factNumber = 9
        appendInfoLine: newline$, "If you want to learn to Praat script, the comments within this code provide useful tips."
    elsif factNumber = 10
        appendInfoLine: newline$, "The csv of this script is almost ready to go for analysis in R. Just delete any boxes that say --undefined-- before you start"
    elsif factNumber = 11
        appendInfoLine: newline$, "The csv of this script is almost ready to go for analysis in R. Just delete any boxes that say --undefined-- before you start"
    elsif factNumber = 12
        appendInfoLine: newline$, "If you want to learn to Praat script, the comments within this code provide useful tips."
    elsif factNumber = 13
        appendInfoLine: newline$, "Are special characters displaying weird in Excel? Try adding a BOM to your spreadsheet."
    elsif factNumber = 14
        appendInfoLine: newline$, "Andre3000 released an experimental flute album in 2023 called New Blue Sun. It's known for it's wacky song titles."
    elsif factNumber = 15
        appendInfoLine: newline$, "Joey Stanley has some really great Praat and R tutorials!"
    elsif factNumber = 16
        appendInfoLine: newline$, "The Voynich Manuscript is an undeciphered alphabetic script from Southern Europe"
    elsif factNumber = 17
        appendInfoLine: newline$, "The Greenlandic Government has invested heavily in creating resources for the Kalaallisut language, creating a government branch called the Language Secretariat"
    elsif factNumber = 18
        appendInfoLine: newline$, "The Altaic language family is one of the most controversial proposed language families"
    elsif factNumber = 19
        appendInfoLine: newline$, "Damin is the only Australian language with clicks. It's a ritual language related to Lardil."
    elsif factNumber = 20
        appendInfoLine: newline$, "This script can take a super long time to run if you have enough speech data. Just hold tight!"
    elsif factNumber = 21
        appendInfoLine: newline$, "Antartica is the largest desert in the world."
    elsif factNumber = 22
        appendInfoLine: newline$, "The llareta plant is a globular plant that grows at about one meter per century and is native to the Atacama desert."
    elsif factNumber = 23
        appendInfoLine: newline$, "There are very small amounts of liquid water flowing on Mars."
    elsif factNumber = 24
        appendInfoLine: newline$, "Implosive sounds can sometimes pattern phonologically with either obstruents or sonorants."
    elsif factNumber = 25
        appendInfoLine: newline$, "The Isle of Man is known for its recent successes in revitalizing the Manx language."
    elsif factNumber = 26
        appendInfoLine: newline$, "A new Indo-European language (Anatolian Branch), Kalasmaic, was discovered in 2023."
    elsif factNumber = 27
        appendInfoLine: newline$, "Whales communicate through a series of clicks called codas."
    elsif factNumber = 28
        appendInfoLine: newline$, "If you have suggestions about what features to incorporate in this script, email julianvargo at berkeley dot edu"
    elsif factNumber = 29
        appendInfoLine: newline$, "A very small number of languages have rhotic vowel harmony."
    elsif factNumber = 30
        appendInfoLine: newline$, "Sam Cooke and Muhammad Ali wrote a song together called The Gangs All Here."
    endif
    selectObject: fileList
    currentFile$ = Get string: file
    if operatingSystem$ = "windows"
        currentTextGrid = Read from file: inputFolder$ + "\"+ currentFile$
    else
        currentTextGrid = Read from file: inputFolder$ + "/"+ currentFile$
    endif
    currentTextGrid$ = selected$("TextGrid")
    if operatingSystem$ = "windows"
        currentSound = Read from file: inputFolder$ + "\"+ ( replace$(currentFile$,  ".TextGrid", ".wav", 4))
    else
        currentSound = Read from file: inputFolder$ + "/"+ ( replace$(currentFile$,  ".TextGrid", ".wav", 4))
    endif
    currentSound$ = selected$("Sound")
    selectObject: currentTextGrid

    #Gather the number of intervals on your phoneme/phone tier. Stores this value to a variable called numberOfIntervals
    numberOfIntervals = Get number of intervals: phoneTierNumber
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
    #Creates a Formant Object. With the formant object, we can gather formant values and formant bandwidths. Change '5500' to '5000' if your data has mostly male speakers. 
    select Sound 'currentSound$'
    currentFormant = To Formant (burg)... 0 5 5500 0.025 50
    #Creates a Harmonicity Object, useful for both obstruent analysis and voice quality analysis.
    select Sound 'currentSound$'
    currentHarmonicity = To Harmonicity (cc)... 0.01 75 0.1 4.5
    #Creates an Intensity Object
    select Sound 'currentSound$'
    currentIntensity = To Intensity... 50 0 yes
    #Creates a Point Process object, which is the object type used to gather jitter and shimmer.
    select Sound 'currentSound$'
    currentPointProcess = To PointProcess (periodic, cc)... 50 800
    
    #Executes a command starting at the first interval and goes all the way up to the final interval on the phonemes/phones tier.
    #The current interval being scanned for is called 'currentInter'
    for currentInterval from 1 to numberOfIntervals
        select TextGrid 'currentTextGrid$'
        thisPhoneme$ = Get label of interval: phoneTierNumber, currentInterval
        if not thisPhoneme$ = ""
            thisPhonemeStartTime = Get start point: phoneTierNumber, currentInterval
            thisPhonemeEndTime = Get end point: phoneTierNumber, currentInterval
            precederNumber = currentInterval - 1
            precedingPhoneme$ = "boundary"
            followerNumber = currentInterval + 1
            followingPhoneme$ = "boundary"

            #We can only gather info about the preceding phoneme if we're not on the very first interval, so we use this "if" statement.
            if currentInterval > 1
                precedingPhoneme$ = Get label of interval: phoneTierNumber, precederNumber
                if precedingPhoneme$ = ""
                    precedingPhoneme$ = "boundary"
                endif
            endif
           
            #Same logic as the preceding phoneme. We can only gather info about the following phoneme if we're not on the very last interval, so we use this "if" statement.
            if currentInterval < numberOfIntervals
                followingPhoneme$ = Get label of interval: phoneTierNumber, followerNumber
                if followingPhoneme$ = ""
                    followingPhoneme$ = "boundary"
                endif
            endif

            #Now we need to note all of the key timestamps. These are the start points, end points, and 10% increments throughout the sound.
            #One quirk about praat is that you can convert numbers into strings by using the fixed$ notation, that you'll see a lot of going forward.
            thisPhonemeStartTime$ = fixed$(thisPhonemeStartTime, 4)
            thisPhonemeEndTime$ = fixed$(thisPhonemeEndTime, 4)
            duration = thisPhonemeEndTime - thisPhonemeStartTime
            duration$ = fixed$(duration, 4)
            tenpercent = thisPhonemeStartTime + duration/10
            twentypercent = thisPhonemeStartTime + duration/5
            thirtypercent = thisPhonemeStartTime + (duration*3)/10
            fortypercent = thisPhonemeStartTime + (duration*2)/5
            fiftypercent = thisPhonemeStartTime + duration/2
            sixtypercent = thisPhonemeStartTime + (duration*3)/5
            seventypercent = thisPhonemeStartTime + (duration*7)/10
            eightypercent = thisPhonemeStartTime + (duration*4)/5
            ninetypercent = thisPhonemeStartTime + (duration*9)/10

            #Collects optional intervals, such as task type and word.
            currentWord$ = "--undefined--"
            if wordTierNumber <> 0
                currentWordInterval = Get interval at time: wordTierNumber, fiftypercent
                currentWord$ = Get label of interval: wordTierNumber, currentWordInterval
            endif
            currentTask$ = "--undefined--"
            if taskTierNumber <> 0
                currentTaskInterval = Get interval at time: taskTierNumber, fiftypercent
                currentTask$ = Get label of interval: taskTierNumber, currentTaskInterval
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
            f0_10$ = fixed$(f0_10, 4)
            f0_20$ = fixed$(f0_20, 4)
            f0_30$ = fixed$(f0_30, 4)
            f0_40$ = fixed$(f0_40, 4)
            f0_50$ = fixed$(f0_50, 4)
            f0_60$ = fixed$(f0_60, 4)
            f0_70$ = fixed$(f0_70, 4)
            f0_80$ = fixed$(f0_80, 4)
            f0_90$ = fixed$(f0_90, 4)

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
            f1_10$ = fixed$(f1_10, 4)
            f1_20$ = fixed$(f1_20, 4)
            f1_30$ = fixed$(f1_30, 4)
            f1_40$ = fixed$(f1_40, 4)
            f1_50$ = fixed$(f1_50, 4)
            f1_60$ = fixed$(f1_60, 4)
            f1_70$ = fixed$(f1_70, 4)
            f1_80$ = fixed$(f1_80, 4)
            f1_90$ = fixed$(f1_90, 4)
            f2_10$ = fixed$(f2_10, 4)
            f2_20$ = fixed$(f2_20, 4)
            f2_30$ = fixed$(f2_30, 4)
            f2_40$ = fixed$(f2_40, 4)
            f2_50$ = fixed$(f2_50, 4)
            f2_60$ = fixed$(f2_60, 4)
            f2_70$ = fixed$(f2_70, 4)
            f2_80$ = fixed$(f2_80, 4)
            f2_90$ = fixed$(f2_90, 4)
            f3_10$ = fixed$(f3_10, 4)
            f3_20$ = fixed$(f3_20, 4)
            f3_30$ = fixed$(f3_30, 4)
            f3_40$ = fixed$(f3_40, 4)
            f3_50$ = fixed$(f3_50, 4)
            f3_60$ = fixed$(f3_60, 4)
            f3_70$ = fixed$(f3_70, 4)
            f3_80$ = fixed$(f3_80, 4)
            f3_90$ = fixed$(f3_90, 4)
            f4_10$ = fixed$(f4_10, 4)
            f4_20$ = fixed$(f4_20, 4)
            f4_30$ = fixed$(f4_30, 4)
            f4_40$ = fixed$(f4_40, 4)
            f4_50$ = fixed$(f4_50, 4)
            f4_60$ = fixed$(f4_60, 4)
            f4_70$ = fixed$(f4_70, 4)
            f4_80$ = fixed$(f4_80, 4)
            f4_90$ = fixed$(f4_90, 4)
            f5_10$ = fixed$(f5_10, 4)
            f5_20$ = fixed$(f5_20, 4)
            f5_30$ = fixed$(f5_30, 4)
            f5_40$ = fixed$(f5_40, 4)
            f5_50$ = fixed$(f5_50, 4)
            f5_60$ = fixed$(f5_60, 4)
            f5_70$ = fixed$(f5_70, 4)
            f5_80$ = fixed$(f5_80, 4)
            f5_90$ = fixed$(f5_90, 4)
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
            bandwidth1_10$ = fixed$(bandwidth1_10, 4)
            bandwidth1_20$ = fixed$(bandwidth1_20, 4)
            bandwidth1_30$ = fixed$(bandwidth1_30, 4)
            bandwidth1_40$ = fixed$(bandwidth1_40, 4)
            bandwidth1_50$ = fixed$(bandwidth1_50, 4)
            bandwidth1_60$ = fixed$(bandwidth1_60, 4)
            bandwidth1_70$ = fixed$(bandwidth1_70, 4)
            bandwidth1_80$ = fixed$(bandwidth1_80, 4)
            bandwidth1_90$ = fixed$(bandwidth1_90, 4)
            bandwidth2_10$ = fixed$(bandwidth2_10, 4)
            bandwidth2_20$ = fixed$(bandwidth2_20, 4)
            bandwidth2_30$ = fixed$(bandwidth2_30, 4)
            bandwidth2_40$ = fixed$(bandwidth2_40, 4)
            bandwidth2_50$ = fixed$(bandwidth2_50, 4)
            bandwidth2_60$ = fixed$(bandwidth2_60, 4)
            bandwidth2_70$ = fixed$(bandwidth2_70, 4)
            bandwidth2_80$ = fixed$(bandwidth2_80, 4)
            bandwidth2_90$ = fixed$(bandwidth2_90, 4)
            bandwidth3_10$ = fixed$(bandwidth3_10, 4)
            bandwidth3_20$ = fixed$(bandwidth3_20, 4)
            bandwidth3_30$ = fixed$(bandwidth3_30, 4)
            bandwidth3_40$ = fixed$(bandwidth3_40, 4)
            bandwidth3_50$ = fixed$(bandwidth3_50, 4)
            bandwidth3_60$ = fixed$(bandwidth3_60, 4)
            bandwidth3_70$ = fixed$(bandwidth3_70, 4)
            bandwidth3_80$ = fixed$(bandwidth3_80, 4)
            bandwidth3_90$ = fixed$(bandwidth3_90, 4)
            bandwidth4_10$ = fixed$(bandwidth4_10, 4)
            bandwidth4_20$ = fixed$(bandwidth4_20, 4)
            bandwidth4_30$ = fixed$(bandwidth4_30, 4)
            bandwidth4_40$ = fixed$(bandwidth4_40, 4)
            bandwidth4_50$ = fixed$(bandwidth4_50, 4)
            bandwidth4_60$ = fixed$(bandwidth4_60, 4)
            bandwidth4_70$ = fixed$(bandwidth4_70, 4)
            bandwidth4_80$ = fixed$(bandwidth4_80, 4)
            bandwidth4_90$ = fixed$(bandwidth4_90, 4)
            bandwidth5_10$ = fixed$(bandwidth5_10, 4)
            bandwidth5_20$ = fixed$(bandwidth5_20, 4)
            bandwidth5_30$ = fixed$(bandwidth5_30, 4)
            bandwidth5_40$ = fixed$(bandwidth5_40, 4)
            bandwidth5_50$ = fixed$(bandwidth5_50, 4)
            bandwidth5_60$ = fixed$(bandwidth5_60, 4)
            bandwidth5_70$ = fixed$(bandwidth5_70, 4)
            bandwidth5_80$ = fixed$(bandwidth5_80, 4)
            bandwidth5_90$ = fixed$(bandwidth5_90, 4)
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
            f1_slope_20$ = fixed$(f1_slope_20, 4)
            f1_slope_30$ = fixed$(f1_slope_30, 4)
            f1_slope_40$ = fixed$(f1_slope_40, 4)
            f1_slope_50$ = fixed$(f1_slope_50, 4)
            f1_slope_60$ = fixed$(f1_slope_60, 4)
            f1_slope_70$ = fixed$(f1_slope_70, 4)
            f1_slope_80$ = fixed$(f1_slope_80, 4)
            f2_slope_20$ = fixed$(f2_slope_20, 4)
            f2_slope_30$ = fixed$(f2_slope_30, 4)
            f2_slope_40$ = fixed$(f2_slope_40, 4)
            f2_slope_50$ = fixed$(f2_slope_50, 4)
            f2_slope_60$ = fixed$(f2_slope_60, 4)
            f2_slope_70$ = fixed$(f2_slope_70, 4)
            f2_slope_80$ = fixed$(f2_slope_80, 4)
            f3_slope_20$ = fixed$(f3_slope_20, 4)
            f3_slope_30$ = fixed$(f3_slope_30, 4)
            f3_slope_40$ = fixed$(f3_slope_40, 4)
            f3_slope_50$ = fixed$(f3_slope_50, 4)
            f3_slope_60$ = fixed$(f3_slope_60, 4)
            f3_slope_70$ = fixed$(f3_slope_70, 4)
            f3_slope_80$ = fixed$(f3_slope_80, 4)
            f4_slope_20$ = fixed$(f4_slope_20, 4)
            f4_slope_30$ = fixed$(f4_slope_30, 4)
            f4_slope_40$ = fixed$(f4_slope_40, 4)
            f4_slope_50$ = fixed$(f4_slope_50, 4)
            f4_slope_60$ = fixed$(f4_slope_60, 4)
            f4_slope_70$ = fixed$(f4_slope_70, 4)
            f4_slope_80$ = fixed$(f4_slope_80, 4)
            f5_slope_20$ = fixed$(f5_slope_20, 4)
            f5_slope_30$ = fixed$(f5_slope_30, 4)
            f5_slope_40$ = fixed$(f5_slope_40, 4)
            f5_slope_50$ = fixed$(f5_slope_50, 4)
            f5_slope_60$ = fixed$(f5_slope_60, 4)
            f5_slope_70$ = fixed$(f5_slope_70, 4)
            f5_slope_80$ = fixed$(f5_slope_80, 4)

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
            harmonicity_10$ = fixed$(harmonicity_10, 4)
            harmonicity_20$ = fixed$(harmonicity_20, 4)
            harmonicity_30$ = fixed$(harmonicity_30, 4)
            harmonicity_40$ = fixed$(harmonicity_40, 4)
            harmonicity_50$ = fixed$(harmonicity_50, 4)
            harmonicity_60$ = fixed$(harmonicity_60, 4)
            harmonicity_70$ = fixed$(harmonicity_70, 4)
            harmonicity_80$ = fixed$(harmonicity_80, 4)
            harmonicity_90$ = fixed$(harmonicity_90, 4)

            #This is the intensity section. We're going to gather mean intensities throughout the sound.
            #We're also going to gather min, and max intensity.
            #Lastly, we're going to include an intensity difference measure, which comes from Bongiovanni 2015.
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
            intensity_10$ = fixed$(intensity_10, 4)
            intensity_20$ = fixed$(intensity_20, 4)
            intensity_30$ = fixed$(intensity_30, 4)
            intensity_40$ = fixed$(intensity_40, 4)
            intensity_50$ = fixed$(intensity_50, 4)
            intensity_60$ = fixed$(intensity_60, 4)
            intensity_70$ = fixed$(intensity_70, 4)
            intensity_80$ = fixed$(intensity_80, 4)
            intensity_90$ = fixed$(intensity_90, 4)
            intensity_100$ = fixed$(intensity_100, 4)
            intensity_max = Get maximum... thisPhonemeStartTime thisPhonemeEndTime Parabolic
            intensity_min = Get minimum... thisPhonemeStartTime thisPhonemeEndTime Parabolic
            intensity_max$ = fixed$(intensity_max, 4)
            intensity_min$ = fixed$(intensity_min, 4)
            
            intensity_difference$ = "--undefined--"
            if currentInterval > 1
                selectObject: currentTextGrid
                previous_initial_time = Get start point: phoneTierNumber, precederNumber
                selectObject: currentIntensity
                previous_intensity_minimum = Get minimum... previous_initial_time thisPhonemeStartTime Parabolic
                intensity_difference = intensity_max - previous_intensity_minimum
                intensity_difference$ = fixed$(intensity_difference, 4)
            endif

            #Now we select the Point Process object to collect Jitter and Shimmer data.
            selectObject: currentPointProcess
            jitter = Get jitter (local, absolute)... thisPhonemeStartTime thisPhonemeEndTime 0.0001 0.02 1.3
            jitter$ = fixed$(jitter, 4)

            selectObject: currentSound, currentPointProcess
            shimmer = Get shimmer (local): thisPhonemeStartTime, thisPhonemeEndTime, 0.0001, 0.02, 1.3, 1.6
            shimmer$ = fixed$(shimmer, 4)
            
            #This is the final acoustical extraction, which creates a bunch of spectrum objects.
            selectObject: currentSound
            currentSoundChunk = Extract part... thisPhonemeStartTime thisPhonemeEndTime rectangular 1 on
            currentSpectrum = To Spectrum... yes
            selectObject: currentSpectrum
            cog = Get centre of gravity... 2
            cogSD = Get standard deviation... 2
            skewness = Get skewness... 2
            kurtosis = Get kurtosis... 2
            removeObject: currentSpectrum
            removeObject: currentSoundChunk
            cog$ = fixed$(cog, 4)
            cogSD$ = fixed$(cogSD, 4)
            skewness$ = fixed$(skewness, 4)
            kurtosis$ = fixed$(kurtosis, 4)

            endOfForm$ = "end_of_form"
            appendFileLine: csvName$, currentFile$,",",thisPhonemeStartTime,",",thisPhonemeEndTime,",",thisPhoneme$,",",currentWord$,",",currentTask$,",",duration$,",",precedingPhoneme$,",",followingPhoneme$,",",f0_10$,",",f0_20$,",",f0_30$,",",f0_40$,",",f0_50$,",",f0_60$,",",f0_70$,",",f0_80$,",",f0_90$,",",f1_10$,",",f1_20$,",",f1_30$,",",f1_40$,",",f1_50$,",",f1_60$,",",f1_70$,",",f1_80$,",",f1_90$,",",f2_10$,",",f2_20$,",",f2_30$,",",f2_40$,",",f2_50$,",",f2_60$,",",f2_70$,",",f2_80$,",",f2_90$,",",f3_10$,",",f3_20$,",",f3_30$,",",f3_40$,",",f3_50$,",",f3_60$,",",f3_70$,",",f3_80$,",",f3_90$,",",f4_10$,",",f4_20$,",",f4_30$,",",f4_40$,",",f4_50$,",",f4_60$,",",f4_70$,",",f4_80$,",",f4_90$,",",f5_10$,",",f5_20$,",",f5_30$,",",f5_40$,",",f5_50$,",",f5_60$,",",f5_70$,",",f5_80$,",",f5_90$,",",bandwidth1_10$,",",bandwidth1_20$,",",bandwidth1_30$,",",bandwidth1_40$,",",bandwidth1_50$,",",bandwidth1_60$,",",bandwidth1_70$,",",bandwidth1_80$,",",bandwidth1_90$,",",bandwidth2_10$,",",bandwidth2_20$,",",bandwidth2_30$,",",bandwidth2_40$,",",bandwidth2_50$,",",bandwidth2_60$,",",bandwidth2_70$,",",bandwidth2_80$,",",bandwidth2_90$,",",bandwidth3_10$,",",bandwidth3_20$,",",bandwidth3_30$,",",bandwidth3_40$,",",bandwidth3_50$,",",bandwidth3_60$,",",bandwidth3_70$,",",bandwidth3_80$,",",bandwidth3_90$,",",bandwidth4_10$,",",bandwidth4_20$,",",bandwidth4_30$,",",bandwidth4_40$,",",bandwidth4_50$,",",bandwidth4_60$,",",bandwidth4_70$,",",bandwidth4_80$,",",bandwidth4_90$,",",bandwidth5_10$,",",bandwidth5_20$,",",bandwidth5_30$,",",bandwidth5_40$,",",bandwidth5_50$,",",bandwidth5_60$,",",bandwidth5_70$,",",bandwidth5_80$,",",bandwidth5_90$,",",f1_slope_20$,",",f1_slope_30$,",",f1_slope_40$,",",f1_slope_50$,",",f1_slope_60$,",",f1_slope_70$,",",f1_slope_80$,",",f2_slope_20$,",",f2_slope_30$,",",f2_slope_40$,",",f2_slope_50$,",",f2_slope_60$,",",f2_slope_70$,",",f2_slope_80$,",",f3_slope_20$,",",f3_slope_30$,",",f3_slope_40$,",",f3_slope_50$,",",f3_slope_60$,",",f3_slope_70$,",",f3_slope_80$,",",f4_slope_20$,",",f4_slope_30$,",",f4_slope_40$,",",f4_slope_50$,",",f4_slope_60$,",",f4_slope_70$,",",f4_slope_80$,",",f5_slope_20$,",",f5_slope_30$,",",f5_slope_40$,",",f5_slope_50$,",",f5_slope_60$,",",f5_slope_70$,",",f5_slope_80$,",",harmonicity_10$,",",harmonicity_20$,",",harmonicity_30$,",",harmonicity_40$,",",harmonicity_50$,",",harmonicity_60$,",",harmonicity_70$,",",harmonicity_80$,",",harmonicity_90$,",",intensity_10$,",",intensity_20$,",",intensity_30$,",",intensity_40$,",",intensity_50$,",",intensity_60$,",",intensity_70$,",",intensity_80$,",",intensity_90$,",",intensity_100$,",",intensity_max$,",",intensity_min$,",",intensity_difference$,",",jitter$,",",shimmer$,",",cog$,",",cogSD$,",",skewness$,",",kurtosis$,",",endOfForm$,tab$
        endif
    endfor
    removeObject: currentPitch
    removeObject: currentHarmonicity
    removeObject: currentIntensity
    removeObject: currentPointProcess
    removeObject: currentSound
    removeObject: currentFormant
    removeObject: currentTextGrid
endfor
removeObject: fileList
appendInfoLine: newline$, "SCRIPT COMPLETED SUCCESSFULLY! WOOHOO!"
