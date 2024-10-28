writeInfoLine: "Initializing Praat Bulk Analyzer"
appendInfoLine: newline$, "Vargo, Julian (2024). Praat Bulk Analyzer [Computer Software]"
appendInfoLine: "University of California, Berkeley. Department of Spanish & Portuguese"
appendInfoLine: newline$, "Please enter the appropriate file paths into lines 6, 7, and 409"
appendInfoLine: "Script is loading. This may take a minute. Please stand by."
inputFolder$ = "C:\Users\julia\Documents\Test_SRT\small_dataset"
writeFileLine: "C:\Users\julia\Documents\Test_SRT\notabdata.csv", "start_time,end_time,phoneme,place,manner,voice,height,backness,roundness,tenseness,word,duration,preceding_phone,following_phone,f0_10,f0_20,f0_30,f0_40,f0_50,f0_60,f0_70,f0_80,f0_90,f1_10,f1_20,f1_30,f1_40,f1_50,f1_60,f1_70,f1_80,f1_90,f2_10,f2_20,f2_30,f2_40,f2_50,f2_60,f2_70,f2_80,f2_90,f3_10,f3_20,f3_30,f3_40,f3_50,f3_60,f3_70,f3_80,f3_90,f4_10,f4_20,f4_30,f4_40,f4_50,f4_60,f4_70,f4_80,f4_90,f5_10,f5_20,f5_30,f5_40,f5_50,f5_60,f5_70,f5_80,f5_90,bandwidth1_10,bandwidth1_20,bandwidth1_30,bandwidth1_40,bandwidth1_50,bandwidth1_60,bandwidth1_70,bandwidth1_80,bandwidth1_90,bandwidth2_10,bandwidth2_20,bandwidth2_30,bandwidth2_40,bandwidth2_50,bandwidth2_60,bandwidth2_70,bandwidth2_80,bandwidth2_90,bandwidth3_10,bandwidth3_20,bandwidth3_30,bandwidth3_40,bandwidth3_50,bandwidth3_60,bandwidth3_70,bandwidth3_80,bandwidth3_90,bandwidth4_10,bandwidth4_20,bandwidth4_30,bandwidth4_40,bandwidth4_50,bandwidth4_60,bandwidth4_70,bandwidth4_80,bandwidth4_90,bandwidth5_10,bandwidth5_20,bandwidth5_30,bandwidth5_40,bandwidth5_50,bandwidth5_60,bandwidth5_70,bandwidth5_80,bandwidth5_90,f1_slope_20,f1_slope_30,f1_slope_40,f1_slope_50,f1_slope_60,f1_slope_70,f1_slope_80,f2_slope_20,f2_slope_30,f2_slope_40,f2_slope_50,f2_slope_60,f2_slope_70,f2_slope_80,f3_slope_20,f3_slope_30,f3_slope_40,f3_slope_50,f3_slope_60,f3_slope_70,f3_slope_80,f4_slope_20,f4_slope_30,f4_slope_40,f4_slope_50,f4_slope_60,f4_slope_70,f4_slope_80,f5_slope_20,f5_slope_30,f5_slope_40,f5_slope_50,f5_slope_60,f5_slope_70,f5_slope_80,harmonicity_10,harmonicity_20,harmonicity_30,harmonicity_40,harmonicity_50,harmonicity_60,harmonicity_70,harmonicity_80,harmonicity_90,intensity_10,intensity_20,intensity_30,intensity_40,intensity_50,intensity_60,intensity_70,intensity_80,intensity_90,intensity_100,jitter_10,jitter_20,jitter_30,jitter_40,jitter_50,jitter_60,jitter_70,jitter_80,jitter_90,jitter_100, cog, cogSD, skewness, kurtosis"
fileList = Create Strings as file list: "fileList", inputFolder$ + "\" +"*.TextGrid"
numberOfFiles = Get number of strings

place$ = "specifyplace"
manner$ = "specifymanner"
voice$ = "specifyvoice"
height$ = "specifylow"
backness$ = "specifybackness"
roundness$ = "specifyroundness"
tenseness$ = "specifytenseness"

for file to numberOfFiles
selectObject: fileList
currentFile$ = Get string: file
currentTextGrid = Read from file: inputFolder$ + "\"+ currentFile$
currentTextGrid$ = selected$("TextGrid")
currentSound = Read from file: inputFolder$ + "\"+ ( replace$(currentFile$,  ".TextGrid", ".wav", 4))
currentSound$ = selected$("Sound")
selectObject: currentTextGrid
numberOfPhonemes = Get number of intervals: 2
Convert to Unicode
select Sound 'currentSound$'
currentFormant = To Formant (burg)... 0 5 5500 0.025 50
select Sound 'currentSound$'
currentPitch = To Pitch... 0 50 800
select Sound 'currentSound$'
currentHarmonicity = To Harmonicity (cc)... 0.01 75 0.1 4.5
select Sound 'currentSound$'
currentIntensity = To Intensity... 50 0 yes
select Sound 'currentSound$'
currentPointProcess = To PointProcess (periodic, cc)... 50 800
intervalNumber = 1

for thisInterval from intervalNumber to numberOfPhonemes
select TextGrid 'currentTextGrid$'
thisPhoneme$ = Get label of interval: 2, thisInterval
if not thisPhoneme$ = ""
thisPhonemeStartTime = Get start point: 2, thisInterval
thisPhonemeEndTime = Get end point: 2, thisInterval
precederNumber = thisInterval - 1
precedingPhoneme$ = "boundary"

if thisInterval > 1
precedingPhoneme$ = Get label of interval: 2, precederNumber
if precedingPhoneme$ = ""
precedingPhoneme$ = "boundary"
endif
endif
followerNumber = thisInterval + 1
followingPhoneme$ = "boundary"

if thisInterval < numberOfPhonemes
followingPhoneme$ = Get label of interval: 2, followerNumber
if followingPhoneme$ = ""
followingPhoneme$ = "boundary"
endif
endif

if thisPhoneme$ = "AA0" or thisPhoneme$ = "AA1" or thisPhoneme$ = "AA2"
    place$ = "dorsal"
    manner$ = "vowel"
    voice$ = "voiced"
    height$ = "low"
    backness$ = "back"
    roundness$ = "unround"
    tenseness$ = "tense"
elsif thisPhoneme$ = "AE0" or thisPhoneme$ = "AE1" or thisPhoneme$ = "AE2"
    place$ = "dorsal"
    manner$ = "vowel"
    voice$ = "voiced"
    height$ = "low"
    backness$ = "front"
    roundness$ = "unround"
    tenseness$ = "tense"


elsif thisPhoneme$ = "AH0" or thisPhoneme$ = "AH1" or thisPhoneme$ = "AH2"
    place$ = "dorsal"
    manner$ = "vowel"
    voice$ = "voiced"
    height$ = "mid"
    backness$ = "back"
    roundness$ = "unround"
    tenseness$ = "lax"


elsif thisPhoneme$ = "AO0" or thisPhoneme$ = "AO1" or thisPhoneme$ = "AO2"
    place$ = "dorsal"
    manner$ = "vowel"
    voice$ = "voiced"
    height$ = "mid"
    backness$ = "back"
    roundness$ = "round"
    tenseness$ = "lax"


elsif thisPhoneme$ = "AW0" or thisPhoneme$ = "AW1" or thisPhoneme$ = "AW2"
    place$ = "dorsal"
    manner$ = "vowel"
    voice$ = "voiced"
    height$ = "low_high"
    backness$ = "central_back"
    roundness$ = "unround_round"
    tenseness$ = "diphthong"


elsif thisPhoneme$ = "AX0" or thisPhoneme$ = "AX1" or thisPhoneme$ = "AX2"
    place$ = "dorsal"
    manner$ = "vowel"
    voice$ = "voiced"
    height$ = "mid"
    backness$ = "central"
    roundness$ = "unround"
    tenseness$ = "lax"


elsif thisPhoneme$ = "AXR0" or thisPhoneme$ = "AXR1" or thisPhoneme$ = "AXR2"
    place$ = "dorsal"
    manner$ = "vowel"
    voice$ = "voiced"
    height$ = "mid"
    backness$ = "central"
    roundness$ = "round"
    tenseness$ = "rhotic"


elsif thisPhoneme$ = "AY0" or thisPhoneme$ = "AY1" or thisPhoneme$ = "AY2"
    place$ = "dorsal"
    manner$ = "vowel"
    voice$ = "voiced"
    height$ = "low_high"
    backness$ = "central_front"
    roundness$ = "unround"
    tenseness$ = "diphthong"


elsif thisPhoneme$ = "EH0" or thisPhoneme$ = "EH1" or thisPhoneme$ = "EH2"
    place$ = "dorsal"
    manner$ = "vowel"
    voice$ = "voiced"
    height$ = "mid"
    backness$ = "front"
    roundness$ = "unround"
    tenseness$ = "lax"


elsif thisPhoneme$ = "ER0" or thisPhoneme$ = "ER1" or thisPhoneme$ = "ER2"
    place$ = "dorsal"
    manner$ = "vowel"
    voice$ = "voiced"
    height$ = "mid"
    backness$ = "front"
    roundness$ = "round"
    tenseness$ = "rhotic"


elsif thisPhoneme$ = "EY0" or thisPhoneme$ = "EY1" or thisPhoneme$ = "EY2"
    place$ = "dorsal"
    manner$ = "vowel"
    voice$ = "voiced"
    height$ = "mid_high"
    backness$ = "front"
    roundness$ = "unround"
    tenseness$ = "diphthong"


elsif thisPhoneme$ = "IH0" or thisPhoneme$ = "IH1" or thisPhoneme$ = "IH2"
    place$ = "dorsal"
    manner$ = "vowel"
    voice$ = "voiced"
    height$ = "high"
    backness$ = "front"
    roundness$ = "unround"
    tenseness$ = "lax"


elsif thisPhoneme$ = "IX0" or thisPhoneme$ = "IX1" or thisPhoneme$ = "IX2"
    place$ = "dorsal"
    manner$ = "vowel"
    voice$ = "voiced"
    height$ = "high"
    backness$ = "central"
    roundness$ = "unround"
    tenseness$ = "lax"


elsif thisPhoneme$ = "IY0" or thisPhoneme$ = "IY1" or thisPhoneme$ = "IY2"
    place$ = "dorsal"
    manner$ = "vowel"
    voice$ = "voiced"
    height$ = "high"
    backness$ = "front"
    roundness$ = "unround"
    tenseness$ = "tense"


elsif thisPhoneme$ = "OW0" or thisPhoneme$ = "OW1" or thisPhoneme$ = "OW2"
    place$ = "dorsal"
    manner$ = "vowel"
    voice$ = "voiced"
    height$ = "mid_high"
    backness$ = "back"
    roundness$ = "round"
    tenseness$ = "diphthong"


elsif thisPhoneme$ = "OY0" or thisPhoneme$ = "OY1" or thisPhoneme$ = "OY2"
    place$ = "dorsal"
    manner$ = "vowel"
    voice$ = "voiced"
    height$ = "mid_high"
    backness$ = "back_front"
    roundness$ = "round_unround"
    tenseness$ = "diphthong"


elsif thisPhoneme$ = "UH0" or thisPhoneme$ = "UH1" or thisPhoneme$ = "UH2"
    place$ = "dorsal"
    manner$ = "vowel"
    voice$ = "voiced"
    height$ = "high"
    backness$ = "back"
    roundness$ = "round"
    tenseness$ = "lax"


elsif thisPhoneme$ = "UW0" or thisPhoneme$ = "UW1" or thisPhoneme$ = "UW2"
    place$ = "dorsal"
    manner$ = "vowel"
    voice$ = "voiced"
    height$ = "high"
    backness$ = "back"
    roundness$ = "round"
    tenseness$ = "tense"


elsif thisPhoneme$ = "UX0" or thisPhoneme$ = "UX1" or thisPhoneme$ = "UX2"
    place$ = "dorsal"
    manner$ = "vowel"
    voice$ = "voiced"
    height$ = "high"
    backness$ = "back"
    roundness$ = "round"
    tenseness$ = "lax"
endif


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
currentWordInterval = Get interval at time: 1, fiftypercent
currentWord$ = Get label of interval: 1, currentWordInterval
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
selectObject: currentPointProcess
jitter_10 = Get jitter (local, absolute)... thisPhonemeStartTime tenpercent 0.0001 0.02 1.3
jitter_20 = Get jitter (local, absolute)... tenpercent twentypercent 0.0001 0.02 1.3
jitter_30 = Get jitter (local, absolute)... twentypercent thirtypercent 0.0001 0.02 1.3
jitter_40 = Get jitter (local, absolute)... thirtypercent fortypercent 0.0001 0.02 1.3
jitter_50 = Get jitter (local, absolute)... fortypercent fiftypercent 0.0001 0.02 1.3
jitter_60 = Get jitter (local, absolute)... fiftypercent sixtypercent 0.0001 0.02 1.3
jitter_70 = Get jitter (local, absolute)... sixtypercent seventypercent 0.0001 0.02 1.3
jitter_80 = Get jitter (local, absolute)... seventypercent eightypercent 0.0001 0.02 1.3
jitter_90 = Get jitter (local, absolute)... eightypercent ninetypercent 0.0001 0.02 1.3
jitter_100 = Get jitter (local, absolute)... ninetypercent thisPhonemeEndTime 0.0001 0.02 1.3
jitter_10$ = fixed$(jitter_10, 4)
jitter_20$ = fixed$(jitter_20, 4)
jitter_30$ = fixed$(jitter_30, 4)
jitter_40$ = fixed$(jitter_40, 4)
jitter_50$ = fixed$(jitter_50, 4)
jitter_60$ = fixed$(jitter_60, 4)
jitter_70$ = fixed$(jitter_70, 4)
jitter_80$ = fixed$(jitter_80, 4)
jitter_90$ = fixed$(jitter_90, 4)
jitter_100$ = fixed$(jitter_100, 4)
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
appendFileLine: "C:\Users\julia\Documents\Test_SRT\notabdata.csv", thisPhonemeStartTime,",",thisPhonemeEndTime,",",thisPhoneme$,",",place$,",",manner$,",",voice$,",",height$,",",backness$,",",roundness$,",",tenseness$,",",currentWord$,",",duration$,",",precedingPhoneme$,",",followingPhoneme$,",",f0_10$,",",f0_20$,",",f0_30$,",",f0_40$,",",f0_50$,",",f0_60$,",",f0_70$,",",f0_80$,",",f0_90$,",",f1_10$,",",f1_20$,",",f1_30$,",",f1_40$,",",f1_50$,",",f1_60$,",",f1_70$,",",f1_80$,",",f1_90$,",",f2_10$,",",f2_20$,",",f2_30$,",",f2_40$,",",f2_50$,",",f2_60$,",",f2_70$,",",f2_80$,",",f2_90$,",",f3_10$,",",f3_20$,",",f3_30$,",",f3_40$,",",f3_50$,",",f3_60$,",",f3_70$,",",f3_80$,",",f3_90$,",",f4_10$,",",f4_20$,",",f4_30$,",",f4_40$,",",f4_50$,",",f4_60$,",",f4_70$,",",f4_80$,",",f4_90$,",",f5_10$,",",f5_20$,",",f5_30$,",",f5_40$,",",f5_50$,",",f5_60$,",",f5_70$,",",f5_80$,",",f5_90$,",",bandwidth1_10$,",",bandwidth1_20$,",",bandwidth1_30$,",",bandwidth1_40$,",",bandwidth1_50$,",",bandwidth1_60$,",",bandwidth1_70$,",",bandwidth1_80$,",",bandwidth1_90$,",",bandwidth2_10$,",",bandwidth2_20$,",",bandwidth2_30$,",",bandwidth2_40$,",",bandwidth2_50$,",",bandwidth2_60$,",",bandwidth2_70$,",",bandwidth2_80$,",",bandwidth2_90$,",",bandwidth3_10$,",",bandwidth3_20$,",",bandwidth3_30$,",",bandwidth3_40$,",",bandwidth3_50$,",",bandwidth3_60$,",",bandwidth3_70$,",",bandwidth3_80$,",",bandwidth3_90$,",",bandwidth4_10$,",",bandwidth4_20$,",",bandwidth4_30$,",",bandwidth4_40$,",",bandwidth4_50$,",",bandwidth4_60$,",",bandwidth4_70$,",",bandwidth4_80$,",",bandwidth4_90$,",",bandwidth5_10$,",",bandwidth5_20$,",",bandwidth5_30$,",",bandwidth5_40$,",",bandwidth5_50$,",",bandwidth5_60$,",",bandwidth5_70$,",",bandwidth5_80$,",",bandwidth5_90$,",",f1_slope_20$,",",f1_slope_30$,",",f1_slope_40$,",",f1_slope_50$,",",f1_slope_60$,",",f1_slope_70$,",",f1_slope_80$,",",f2_slope_20$,",",f2_slope_30$,",",f2_slope_40$,",",f2_slope_50$,",",f2_slope_60$,",",f2_slope_70$,",",f2_slope_80$,",",f3_slope_20$,",",f3_slope_30$,",",f3_slope_40$,",",f3_slope_50$,",",f3_slope_60$,",",f3_slope_70$,",",f3_slope_80$,",",f4_slope_20$,",",f4_slope_30$,",",f4_slope_40$,",",f4_slope_50$,",",f4_slope_60$,",",f4_slope_70$,",",f4_slope_80$,",",f5_slope_20$,",",f5_slope_30$,",",f5_slope_40$,",",f5_slope_50$,",",f5_slope_60$,",",f5_slope_70$,",",f5_slope_80$,",",harmonicity_10$,",",harmonicity_20$,",",harmonicity_30$,",",harmonicity_40$,",",harmonicity_50$,",",harmonicity_60$,",",harmonicity_70$,",",harmonicity_80$,",",harmonicity_90$,",",intensity_10$,",",intensity_20$,",",intensity_30$,",",intensity_40$,",",intensity_50$,",",intensity_60$,",",intensity_70$,",",intensity_80$,",",intensity_90$,",",intensity_100$,",",jitter_10$,",",jitter_20$,",",jitter_30$,",",jitter_40$,",",jitter_50$,",",jitter_60$,",",jitter_70$,",",jitter_80$,",",jitter_90$,",",jitter_100$,",",cog,",",cogSD,",",skewness,",",kurtosis, tab$
endif
endfor
removeObject: currentFormant
removeObject: currentPitch
removeObject: currentHarmonicity
removeObject: currentIntensity
removeObject: currentPointProcess
removeObject: currentSound
removeObject: currentTextGrid
endfor
removeObject: fileList
appendInfoLine: newline$, "Script completed successfully"
