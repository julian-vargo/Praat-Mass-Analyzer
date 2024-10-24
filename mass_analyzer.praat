writeInfoLine: "Initializing Praat Mass Analyzer"
appendInfoLine: newline$, "Vargo, Julian (2024). Praat Mass Analyzer [Computer Software]"
appendInfoLine: "University of California, Berkeley. Department of Spanish & Portuguese"
appendInfoLine: newline$, "Please enter the appropriate file paths into lines 6, 7, 8, and 396"
appendInfoLine: "Script is loading. This may take a minute. Please stand by."

inputFolder$ = "C:\Users\julia\Documents\Test_SRT\Praat_Sript_Analyzer"
outputCSV$ = "C:\Users\julia\Downloads\testerdata.csv"
writeFileLine: "C:\Users\julia\Downloads\testerdata.csv", "start_time,end_time,phoneme,duration,preceding_phone,following_phone,f0_10,f0_20,f0_30,f0_40,f0_50,f0_60,f0_70,f0_80,f0_90,f1_10,f1_20,f1_30,f1_40,f1_50,f1_60,f1_70,f1_80,f1_90,f2_10,f2_20,f2_30,f2_40,f2_50,f2_60,f2_70,f2_80,f2_90,f3_10,f3_20,f3_30,f3_40,f3_50,f3_60,f3_70,f3_80,f3_90,f4_10,f4_20,f4_30,f4_40,f4_50,f4_60,f4_70,f4_80,f4_90,f5_10,f5_20,f5_30,f5_40,f5_50,f5_60,f5_70,f5_80,f5_90,bandwidth1_10,bandwidth1_20,bandwidth1_30,bandwidth1_40,bandwidth1_50,bandwidth1_60,bandwidth1_70,bandwidth1_80,bandwidth1_90,bandwidth2_10,bandwidth2_20,bandwidth2_30,bandwidth2_40,bandwidth2_50,bandwidth2_60,bandwidth2_70,bandwidth2_80,bandwidth2_90,bandwidth3_10,bandwidth3_20,bandwidth3_30,bandwidth3_40,bandwidth3_50,bandwidth3_60,bandwidth3_70,bandwidth3_80,bandwidth3_90,bandwidth4_10,bandwidth4_20,bandwidth4_30,bandwidth4_40,bandwidth4_50,bandwidth4_60,bandwidth4_70,bandwidth4_80,bandwidth4_90,bandwidth5_10,bandwidth5_20,bandwidth5_30,bandwidth5_40,bandwidth5_50,bandwidth5_60,bandwidth5_70,bandwidth5_80,bandwidth5_90,f1_slope_20,f1_slope_30,f1_slope_40,f1_slope_50,f1_slope_60,f1_slope_70,f1_slope_80,f2_slope_20,f2_slope_30,f2_slope_40,f2_slope_50,f2_slope_60,f2_slope_70,f2_slope_80,f3_slope_20,f3_slope_30,f3_slope_40,f3_slope_50,f3_slope_60,f3_slope_70,f3_slope_80,f4_slope_20,f4_slope_30,f4_slope_40,f4_slope_50,f4_slope_60,f4_slope_70,f4_slope_80,f5_slope_20,f5_slope_30,f5_slope_40,f5_slope_50,f5_slope_60,f5_slope_70,f5_slope_80,harmonicity_10,harmonicity_20,harmonicity_30,harmonicity_40,harmonicity_50,harmonicity_60,harmonicity_70,harmonicity_80,harmonicity_90,intensity_10,intensity_20,intensity_30,intensity_40,intensity_50,intensity_60,intensity_70,intensity_80,intensity_90,intensity_100,jitter_10,jitter_20,jitter_30,jitter_40,jitter_50,jitter_60,jitter_70,jitter_80,jitter_90,jitter_100"
fileList = Create Strings as file list: "fileList", inputFolder$ + "\" +"*.TextGrid"
numberOfFiles = Get number of strings
for file to numberOfFiles
	selectObject: fileList
	currentFile$ = Get string: file
	currentTextGrid = Read from file: inputFolder$ + "\"+ currentFile$
	currentTextGrid$ = selected$("TextGrid")
	currentSound = Read from file: inputFolder$ + "\"+ ( replace$(currentFile$,  ".TextGrid", ".wav", 0))
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
thisPhonemeStartTime = Get start point: 2, thisInterval
thisPhonemeEndTime = Get end point: 2, thisInterval

precederNumber = thisInterval - 1
precedingPhoneme$ = "null"
if thisInterval > 1
precedingPhoneme$ = Get label of interval: 2, precederNumber
endif

followerNumber = thisInterval + 1
followingPhoneme$ = "null"
if thisInterval < numberOfPhonemes
followingPhoneme$ = Get label of interval: 2, followerNumber
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
f0_10$ = fixed$(f0_10, 0)
f0_20$ = fixed$(f0_20, 0)
f0_30$ = fixed$(f0_30, 0)
f0_40$ = fixed$(f0_40, 0)
f0_50$ = fixed$(f0_50, 0)
f0_60$ = fixed$(f0_60, 0)
f0_70$ = fixed$(f0_70, 0)
f0_80$ = fixed$(f0_80, 0)
f0_90$ = fixed$(f0_90, 0)
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
f1_10$ = fixed$(f1_10, 0)
f1_20$ = fixed$(f1_20, 0)
f1_30$ = fixed$(f1_30, 0)
f1_40$ = fixed$(f1_40, 0)
f1_50$ = fixed$(f1_50, 0)
f1_60$ = fixed$(f1_60, 0)
f1_70$ = fixed$(f1_70, 0)
f1_80$ = fixed$(f1_80, 0)
f1_90$ = fixed$(f1_90, 0)
f2_10$ = fixed$(f2_10, 0)
f2_20$ = fixed$(f2_20, 0)
f2_30$ = fixed$(f2_30, 0)
f2_40$ = fixed$(f2_40, 0)
f2_50$ = fixed$(f2_50, 0)
f2_60$ = fixed$(f2_60, 0)
f2_70$ = fixed$(f2_70, 0)
f2_80$ = fixed$(f2_80, 0)
f2_90$ = fixed$(f2_90, 0)
f3_10$ = fixed$(f3_10, 0)
f3_20$ = fixed$(f3_20, 0)
f3_30$ = fixed$(f3_30, 0)
f3_40$ = fixed$(f3_40, 0)
f3_50$ = fixed$(f3_50, 0)
f3_60$ = fixed$(f3_60, 0)
f3_70$ = fixed$(f3_70, 0)
f3_80$ = fixed$(f3_80, 0)
f3_90$ = fixed$(f3_90, 0)
f4_10$ = fixed$(f4_10, 0)
f4_20$ = fixed$(f4_20, 0)
f4_30$ = fixed$(f4_30, 0)
f4_40$ = fixed$(f4_40, 0)
f4_50$ = fixed$(f4_50, 0)
f4_60$ = fixed$(f4_60, 0)
f4_70$ = fixed$(f4_70, 0)
f4_80$ = fixed$(f4_80, 0)
f4_90$ = fixed$(f4_90, 0)
f5_10$ = fixed$(f5_10, 0)
f5_20$ = fixed$(f5_20, 0)
f5_30$ = fixed$(f5_30, 0)
f5_40$ = fixed$(f5_40, 0)
f5_50$ = fixed$(f5_50, 0)
f5_60$ = fixed$(f5_60, 0)
f5_70$ = fixed$(f5_70, 0)
f5_80$ = fixed$(f5_80, 0)
f5_90$ = fixed$(f5_90, 0)
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
bandwidth1_10$ = fixed$(bandwidth1_10, 0)
bandwidth1_20$ = fixed$(bandwidth1_20, 0)
bandwidth1_30$ = fixed$(bandwidth1_30, 0)
bandwidth1_40$ = fixed$(bandwidth1_40, 0)
bandwidth1_50$ = fixed$(bandwidth1_50, 0)
bandwidth1_60$ = fixed$(bandwidth1_60, 0)
bandwidth1_70$ = fixed$(bandwidth1_70, 0)
bandwidth1_80$ = fixed$(bandwidth1_80, 0)
bandwidth1_90$ = fixed$(bandwidth1_90, 0)
bandwidth2_10$ = fixed$(bandwidth2_10, 0)
bandwidth2_20$ = fixed$(bandwidth2_20, 0)
bandwidth2_30$ = fixed$(bandwidth2_30, 0)
bandwidth2_40$ = fixed$(bandwidth2_40, 0)
bandwidth2_50$ = fixed$(bandwidth2_50, 0)
bandwidth2_60$ = fixed$(bandwidth2_60, 0)
bandwidth2_70$ = fixed$(bandwidth2_70, 0)
bandwidth2_80$ = fixed$(bandwidth2_80, 0)
bandwidth2_90$ = fixed$(bandwidth2_90, 0)
bandwidth3_10$ = fixed$(bandwidth3_10, 0)
bandwidth3_20$ = fixed$(bandwidth3_20, 0)
bandwidth3_30$ = fixed$(bandwidth3_30, 0)
bandwidth3_40$ = fixed$(bandwidth3_40, 0)
bandwidth3_50$ = fixed$(bandwidth3_50, 0)
bandwidth3_60$ = fixed$(bandwidth3_60, 0)
bandwidth3_70$ = fixed$(bandwidth3_70, 0)
bandwidth3_80$ = fixed$(bandwidth3_80, 0)
bandwidth3_90$ = fixed$(bandwidth3_90, 0)
bandwidth4_10$ = fixed$(bandwidth4_10, 0)
bandwidth4_20$ = fixed$(bandwidth4_20, 0)
bandwidth4_30$ = fixed$(bandwidth4_30, 0)
bandwidth4_40$ = fixed$(bandwidth4_40, 0)
bandwidth4_50$ = fixed$(bandwidth4_50, 0)
bandwidth4_60$ = fixed$(bandwidth4_60, 0)
bandwidth4_70$ = fixed$(bandwidth4_70, 0)
bandwidth4_80$ = fixed$(bandwidth4_80, 0)
bandwidth4_90$ = fixed$(bandwidth4_90, 0)
bandwidth5_10$ = fixed$(bandwidth5_10, 0)
bandwidth5_20$ = fixed$(bandwidth5_20, 0)
bandwidth5_30$ = fixed$(bandwidth5_30, 0)
bandwidth5_40$ = fixed$(bandwidth5_40, 0)
bandwidth5_50$ = fixed$(bandwidth5_50, 0)
bandwidth5_60$ = fixed$(bandwidth5_60, 0)
bandwidth5_70$ = fixed$(bandwidth5_70, 0)
bandwidth5_80$ = fixed$(bandwidth5_80, 0)
bandwidth5_90$ = fixed$(bandwidth5_90, 0)
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
f1_slope_20$ = fixed$(f1_slope_20, 2)
f1_slope_30$ = fixed$(f1_slope_30, 2)
f1_slope_40$ = fixed$(f1_slope_40, 2)
f1_slope_50$ = fixed$(f1_slope_50, 2)
f1_slope_60$ = fixed$(f1_slope_60, 2)
f1_slope_70$ = fixed$(f1_slope_70, 2)
f1_slope_80$ = fixed$(f1_slope_80, 2)
f2_slope_20$ = fixed$(f2_slope_20, 2)
f2_slope_30$ = fixed$(f2_slope_30, 2)
f2_slope_40$ = fixed$(f2_slope_40, 2)
f2_slope_50$ = fixed$(f2_slope_50, 2)
f2_slope_60$ = fixed$(f2_slope_60, 2)
f2_slope_70$ = fixed$(f2_slope_70, 2)
f2_slope_80$ = fixed$(f2_slope_80, 2)
f3_slope_20$ = fixed$(f3_slope_20, 2)
f3_slope_30$ = fixed$(f3_slope_30, 2)
f3_slope_40$ = fixed$(f3_slope_40, 2)
f3_slope_50$ = fixed$(f3_slope_50, 2)
f3_slope_60$ = fixed$(f3_slope_60, 2)
f3_slope_70$ = fixed$(f3_slope_70, 2)
f3_slope_80$ = fixed$(f3_slope_80, 2)
f4_slope_20$ = fixed$(f4_slope_20, 2)
f4_slope_30$ = fixed$(f4_slope_30, 2)
f4_slope_40$ = fixed$(f4_slope_40, 2)
f4_slope_50$ = fixed$(f4_slope_50, 2)
f4_slope_60$ = fixed$(f4_slope_60, 2)
f4_slope_70$ = fixed$(f4_slope_70, 2)
f4_slope_80$ = fixed$(f4_slope_80, 2)
f5_slope_20$ = fixed$(f5_slope_20, 2)
f5_slope_30$ = fixed$(f5_slope_30, 2)
f5_slope_40$ = fixed$(f5_slope_40, 2)
f5_slope_50$ = fixed$(f5_slope_50, 2)
f5_slope_60$ = fixed$(f5_slope_60, 2)
f5_slope_70$ = fixed$(f5_slope_70, 2)
f5_slope_80$ = fixed$(f5_slope_80, 2)
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
harmonicity_10$ = fixed$(harmonicity_10, 2)
harmonicity_20$ = fixed$(harmonicity_20, 2)
harmonicity_30$ = fixed$(harmonicity_30, 2)
harmonicity_40$ = fixed$(harmonicity_40, 2)
harmonicity_50$ = fixed$(harmonicity_50, 2)
harmonicity_60$ = fixed$(harmonicity_60, 2)
harmonicity_70$ = fixed$(harmonicity_70, 2)
harmonicity_80$ = fixed$(harmonicity_80, 2)
harmonicity_90$ = fixed$(harmonicity_90, 2)
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
intensity_10$ = fixed$(intensity_10, 2)
intensity_20$ = fixed$(intensity_20, 2)
intensity_30$ = fixed$(intensity_30, 2)
intensity_40$ = fixed$(intensity_40, 2)
intensity_50$ = fixed$(intensity_50, 2)
intensity_60$ = fixed$(intensity_60, 2)
intensity_70$ = fixed$(intensity_70, 2)
intensity_80$ = fixed$(intensity_80, 2)
intensity_90$ = fixed$(intensity_90, 2)
intensity_100$ = fixed$(intensity_100, 2)
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
jitter_10$ = fixed$(jitter_10, 2)
jitter_20$ = fixed$(jitter_20, 2)
jitter_30$ = fixed$(jitter_30, 2)
jitter_40$ = fixed$(jitter_40, 2)
jitter_50$ = fixed$(jitter_50, 2)
jitter_60$ = fixed$(jitter_60, 2)
jitter_70$ = fixed$(jitter_70, 2)
jitter_80$ = fixed$(jitter_80, 2)
jitter_90$ = fixed$(jitter_90, 2)
jitter_100$ = fixed$(jitter_100, 2)
appendFileLine: "C:\Users\julia\Downloads\testerdata.csv", thisPhonemeStartTime, tab$, ",", tab$, thisPhonemeEndTime, tab$, ",", tab$, thisPhoneme$, tab$, ",", tab$, duration$, tab$, ",", tab$, precedingPhoneme$, tab$, ",", tab$, followingPhoneme$, tab$, ",", tab$, f0_10$, tab$, ",", tab$, f0_20$, tab$, ",", tab$, f0_30$, tab$, ",", tab$, f0_40$, tab$, ",", tab$, f0_50$, tab$, ",", tab$, f0_60$, tab$, ",", tab$, f0_70$, tab$, ",", tab$, f0_80$, tab$, ",", tab$, f0_90$, tab$, ",", tab$, f1_10$, tab$, ",", tab$, f1_20$, tab$, ",", tab$, f1_30$, tab$, ",", tab$, f1_40$, tab$, ",", tab$, f1_50$, tab$, ",", tab$, f1_60$, tab$, ",", tab$, f1_70$, tab$, ",", tab$, f1_80$, tab$, ",", tab$, f1_90$, tab$, ",", tab$, f2_10$, tab$, ",", tab$, f2_20$, tab$, ",", tab$, f2_30$, tab$, ",", tab$, f2_40$, tab$, ",", tab$, f2_50$, tab$, ",", tab$, f2_60$, tab$, ",", tab$, f2_70$, tab$, ",", tab$, f2_80$, tab$, ",", tab$, f2_90$, tab$, ",", tab$, f3_10$, tab$, ",", tab$, f3_20$, tab$, ",", tab$, f3_30$, tab$, ",", tab$, f3_40$, tab$, ",", tab$, f3_50$, tab$, ",", tab$, f3_60$, tab$, ",", tab$, f3_70$, tab$, ",", tab$, f3_80$, tab$, ",", tab$, f3_90$, tab$, ",", tab$, f4_10$, tab$, ",", tab$, f4_20$, tab$, ",", tab$, f4_30$, tab$, ",", tab$, f4_40$, tab$, ",", tab$, f4_50$, tab$, ",", tab$, f4_60$, tab$, ",", tab$, f4_70$, tab$, ",", tab$, f4_80$, tab$, ",", tab$, f4_90$, tab$, ",", tab$, f5_10$, tab$, ",", tab$, f5_20$, tab$, ",", tab$, f5_30$, tab$, ",", tab$, f5_40$, tab$, ",", tab$, f5_50$, tab$, ",", tab$, f5_60$, tab$, ",", tab$, f5_70$, tab$, ",", tab$, f5_80$, tab$, ",", tab$, f5_90$, tab$, ",", tab$, bandwidth1_10$, tab$, ",", tab$, bandwidth1_20$, tab$, ",", tab$, bandwidth1_30$, tab$, ",", tab$, bandwidth1_40$, tab$, ",", tab$, bandwidth1_50$, tab$, ",", tab$, bandwidth1_60$, tab$, ",", tab$, bandwidth1_70$, tab$, ",", tab$, bandwidth1_80$, tab$, ",", tab$, bandwidth1_90$, tab$, ",", tab$, bandwidth2_10$, tab$, ",", tab$, bandwidth2_20$, tab$, ",", tab$, bandwidth2_30$, tab$, ",", tab$, bandwidth2_40$, tab$, ",", tab$, bandwidth2_50$, tab$, ",", tab$, bandwidth2_60$, tab$, ",", tab$, bandwidth2_70$, tab$, ",", tab$, bandwidth2_80$, tab$, ",", tab$, bandwidth2_90$, tab$, ",", tab$, bandwidth3_10$, tab$, ",", tab$, bandwidth3_20$, tab$, ",", tab$, bandwidth3_30$, tab$, ",", tab$, bandwidth3_40$, tab$, ",", tab$, bandwidth3_50$, tab$, ",", tab$, bandwidth3_60$, tab$, ",", tab$, bandwidth3_70$, tab$, ",", tab$, bandwidth3_80$, tab$, ",", tab$, bandwidth3_90$, tab$, ",", tab$, bandwidth4_10$, tab$, ",", tab$, bandwidth4_20$, tab$, ",", tab$, bandwidth4_30$, tab$, ",", tab$, bandwidth4_40$, tab$, ",", tab$, bandwidth4_50$, tab$, ",", tab$, bandwidth4_60$, tab$, ",", tab$, bandwidth4_70$, tab$, ",", tab$, bandwidth4_80$, tab$, ",", tab$, bandwidth4_90$, tab$, ",", tab$, bandwidth5_10$, tab$, ",", tab$, bandwidth5_20$, tab$, ",", tab$, bandwidth5_30$, tab$, ",", tab$, bandwidth5_40$, tab$, ",", tab$, bandwidth5_50$, tab$, ",", tab$, bandwidth5_60$, tab$, ",", tab$, bandwidth5_70$, tab$, ",", tab$, bandwidth5_80$, tab$, ",", tab$, bandwidth5_90$, tab$, ",", tab$, f1_slope_20$, tab$, ",", tab$, f1_slope_30$, tab$, ",", tab$, f1_slope_40$, tab$, ",", tab$, f1_slope_50$, tab$, ",", tab$, f1_slope_60$, tab$, ",", tab$, f1_slope_70$, tab$, ",", tab$, f1_slope_80$, tab$, ",", tab$, f2_slope_20$, tab$, ",", tab$, f2_slope_30$, tab$, ",", tab$, f2_slope_40$, tab$, ",", tab$, f2_slope_50$, tab$, ",", tab$, f2_slope_60$, tab$, ",", tab$, f2_slope_70$, tab$, ",", tab$, f2_slope_80$, tab$, ",", tab$, f3_slope_20$, tab$, ",", tab$, f3_slope_30$, tab$, ",", tab$, f3_slope_40$, tab$, ",", tab$, f3_slope_50$, tab$, ",", tab$, f3_slope_60$, tab$, ",", tab$, f3_slope_70$, tab$, ",", tab$, f3_slope_80$, tab$, ",", tab$, f4_slope_20$, tab$, ",", tab$, f4_slope_30$, tab$, ",", tab$, f4_slope_40$, tab$, ",", tab$, f4_slope_50$, tab$, ",", tab$, f4_slope_60$, tab$, ",", tab$, f4_slope_70$, tab$, ",", tab$, f4_slope_80$, tab$, ",", tab$, f5_slope_20$, tab$, ",", tab$, f5_slope_30$, tab$, ",", tab$, f5_slope_40$, tab$, ",", tab$, f5_slope_50$, tab$, ",", tab$, f5_slope_60$, tab$, ",", tab$, f5_slope_70$, tab$, ",", tab$, f5_slope_80$, tab$, ",", tab$, harmonicity_10$, tab$, ",", tab$, harmonicity_20$, tab$, ",", tab$, harmonicity_30$, tab$, ",", tab$, harmonicity_40$, tab$, ",", tab$, harmonicity_50$, tab$, ",", tab$, harmonicity_60$, tab$, ",", tab$, harmonicity_70$, tab$, ",", tab$, harmonicity_80$, tab$, ",", tab$, harmonicity_90$, tab$, ",", tab$, intensity_10$, tab$, ",", tab$, intensity_20$, tab$, ",", tab$, intensity_30$, tab$, ",", tab$, intensity_40$, tab$, ",", tab$, intensity_50$, tab$, ",", tab$, intensity_60$, tab$, ",", tab$, intensity_70$, tab$, ",", tab$, intensity_80$, tab$, ",", tab$, intensity_90$, tab$, ",", tab$, intensity_100$, tab$, ",", tab$, jitter_10$, tab$, ",", tab$, jitter_20$, tab$, ",", tab$, jitter_30$, tab$, ",", tab$, jitter_40$, tab$, ",", tab$, jitter_50$, tab$, ",", tab$, jitter_60$, tab$, ",", tab$, jitter_70$, tab$, ",", tab$, jitter_80$, tab$, ",", tab$, jitter_90$, tab$, ",", tab$, jitter_100$, tab$
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
