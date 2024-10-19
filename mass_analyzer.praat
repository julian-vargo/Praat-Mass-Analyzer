writeInfoLine: "Initializing Praat Bulk Analyzer"
appendInfoLine: "Vargo, Julian (2024). Praat Bulk Analyzer [Computer Software]"
appendInfoLine: "University of California, Berkeley. Department of Spanish & Portuguese"
thisSound$ = selected$("Sound")
thisTextGrid$ = selected$("TextGrid")
appendInfoLine: "Sound and TextGrid files successfully selected"
select TextGrid 'thisTextGrid$'

#select the second tier of the textgrid (this is where my data's phoneme-by-phoneme parsing is located)
numberOfPhonemes = Get number of intervals: 2
appendInfoLine: newline$, "Number of intervals to be analyzed:"
appendInfoLine: numberOfPhonemes
#On my to-do list, add these queries
#currentPitch = To Pitch
#currentIntensity = 
#currentAmplitude
#Create a phone duration script

#create a spreadsheet file to save your data
appendInfoLine: "Creating results file"
writeFileLine: "C:\Users\julia\Documents\Test_SRT\Praat_Sript_Analyzer\acousticdata.csv", "start_time,end_time,phoneme,F1_10,F1_20,F1_30,F1_40,F1_50,F1_60,F1_70,F1_80,F1_90,F2_10,F2_20,F2_30,F2_40,F2_50,F2_60,F2_70,F2_80,F2_90,F3_10,F3_20,F3_30,F3_40,F3_50,F3_60,F3_70,F3_80,F3_90,F4_10,F4_20,F4_30,F4_40,F4_50,F4_60,F4_70,F4_80,F4_90,F5_10,F5_20,F5_30,F5_40,F5_50,F5_60,F5_70,F5_80,F5_90,Bandwidth1_10,Bandwidth1_20,Bandwidth1_30,Bandwidth1_40,Bandwidth1_50,Bandwidth1_60,Bandwidth1_70,Bandwidth1_80,Bandwidth1_90,Bandwidth2_10,Bandwidth2_20,Bandwidth2_30,Bandwidth2_40,Bandwidth2_50,Bandwidth2_60,Bandwidth2_70,Bandwidth2_80,Bandwidth2_90,Bandwidth3_10,Bandwidth3_20,Bandwidth3_30,Bandwidth3_40,Bandwidth3_50,Bandwidth3_60,Bandwidth3_70,Bandwidth3_80,Bandwidth3_90,Bandwidth4_10,Bandwidth4_20,Bandwidth4_30,Bandwidth4_40,Bandwidth4_50,Bandwidth4_60,Bandwidth4_70,Bandwidth4_80,Bandwidth4_90,Bandwidth5_10,Bandwidth5_20,Bandwidth5_30,Bandwidth5_40,Bandwidth5_50,Bandwidth5_60,Bandwidth5_70,Bandwidth5_80,Bandwidth5_90"
outputPath$ = "C:\Users\julia\Documents\Test_SRT\Praat_Sript_Analyzer\acousticdata.csv"
appendInfoLine: "results file is now on your computer"

appendInfoLine: newline$, "Creating objects (this may take a while for your computer to process)"
select Sound 'thisSound$'
currentFormant = To Formant (burg)... 0 5 5500 0.025 50
appendInfoLine: "Formant object successfully created!"

appendInfoLine: newline$, "Editing the data spreadsheet"
for thisInterval from 1 to numberOfPhonemes
select TextGrid 'thisTextGrid$'
thisPhoneme$ = Get label of interval: 2, thisInterval
thisPhonemeStartTime = Get start point: 2, thisInterval
thisPhonemeEndTime   = Get end point:   2, thisInterval
duration = thisPhonemeEndTime - thisPhonemeStartTime
tenpercent = thisPhonemeStartTime + duration/10
twentypercent = thisPhonemeStartTime + duration/5
thirtypercent = thisPhonemeStartTime + (duration*3)/10
fourtypercent = thisPhonemeStartTime + (duration*2)/5
fiftypercent = thisPhonemeStartTime + duration/2
sixtypercent = thisPhonemeStartTime + (duration*3)/5
seventypercent = thisPhonemeStartTime + (duration*7)/10
eightypercent = thisPhonemeStartTime + (duration*4)/5
ninetypercent = thisPhonemeStartTime + (duration*9)/10
selectObject: currentFormant
f1_10 = Get value at time... 1 tenpercent Hertz Linear
f1_20 = Get value at time... 1 twentypercent Hertz Linear
f1_30 = Get value at time... 1 thirtypercent Hertz Linear
f1_40 = Get value at time... 1 fourtypercent Hertz Linear
f1_50 = Get value at time... 1 fiftypercent Hertz Linear
f1_60 = Get value at time... 1 sixtypercent Hertz Linear
f1_70 = Get value at time... 1 seventypercent Hertz Linear
f1_80 = Get value at time... 1 eightypercent Hertz Linear
f1_90 = Get value at time... 1 ninetypercent Hertz Linear
f2_10 = Get value at time... 2 tenpercent Hertz Linear
f2_20 = Get value at time... 2 twentypercent Hertz Linear
f2_30 = Get value at time... 2 thirtypercent Hertz Linear
f2_40 = Get value at time... 2 fourtypercent Hertz Linear
f2_50 = Get value at time... 2 fiftypercent Hertz Linear
f2_60 = Get value at time... 2 sixtypercent Hertz Linear
f2_70 = Get value at time... 2 seventypercent Hertz Linear
f2_80 = Get value at time... 2 eightypercent Hertz Linear
f2_90 = Get value at time... 2 ninetypercent Hertz Linear
f3_10 = Get value at time... 3 tenpercent Hertz Linear
f3_20 = Get value at time... 3 twentypercent Hertz Linear
f3_30 = Get value at time... 3 thirtypercent Hertz Linear
f3_40 = Get value at time... 3 fourtypercent Hertz Linear
f3_50 = Get value at time... 3 fiftypercent Hertz Linear
f3_60 = Get value at time... 3 sixtypercent Hertz Linear
f3_70 = Get value at time... 3 seventypercent Hertz Linear
f3_80 = Get value at time... 3 eightypercent Hertz Linear
f3_90 = Get value at time... 3 ninetypercent Hertz Linear
f4_10 = Get value at time... 4 tenpercent Hertz Linear
f4_20 = Get value at time... 4 twentypercent Hertz Linear
f4_30 = Get value at time... 4 thirtypercent Hertz Linear
f4_40 = Get value at time... 4 fourtypercent Hertz Linear
f4_50 = Get value at time... 4 fiftypercent Hertz Linear
f4_60 = Get value at time... 4 sixtypercent Hertz Linear
f4_70 = Get value at time... 4 seventypercent Hertz Linear
f4_80 = Get value at time... 4 eightypercent Hertz Linear
f4_90 = Get value at time... 4 ninetypercent Hertz Linear
f5_10 = Get value at time... 5 tenpercent Hertz Linear
f5_20 = Get value at time... 5 twentypercent Hertz Linear
f5_30 = Get value at time... 5 thirtypercent Hertz Linear
f5_40 = Get value at time... 5 fourtypercent Hertz Linear
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
b1_10 = Get bandwidth at time... 1 tenpercent Hertz Linear
b1_20 = Get bandwidth at time... 1 twentypercent Hertz Linear
b1_30 = Get bandwidth at time... 1 thirtypercent Hertz Linear
b1_40 = Get bandwidth at time... 1 fourtypercent Hertz Linear
b1_50 = Get bandwidth at time... 1 fiftypercent Hertz Linear
b1_60 = Get bandwidth at time... 1 sixtypercent Hertz Linear
b1_70 = Get bandwidth at time... 1 seventypercent Hertz Linear
b1_80 = Get bandwidth at time... 1 eightypercent Hertz Linear
b1_90 = Get bandwidth at time... 1 ninetypercent Hertz Linear
b2_10 = Get bandwidth at time... 2 tenpercent Hertz Linear
b2_20 = Get bandwidth at time... 2 twentypercent Hertz Linear
b2_30 = Get bandwidth at time... 2 thirtypercent Hertz Linear
b2_40 = Get bandwidth at time... 2 fourtypercent Hertz Linear
b2_50 = Get bandwidth at time... 2 fiftypercent Hertz Linear
b2_60 = Get bandwidth at time... 2 sixtypercent Hertz Linear
b2_70 = Get bandwidth at time... 2 seventypercent Hertz Linear
b2_80 = Get bandwidth at time... 2 eightypercent Hertz Linear
b2_90 = Get bandwidth at time... 2 ninetypercent Hertz Linear
b3_10 = Get bandwidth at time... 3 tenpercent Hertz Linear
b3_20 = Get bandwidth at time... 3 twentypercent Hertz Linear
b3_30 = Get bandwidth at time... 3 thirtypercent Hertz Linear
b3_40 = Get bandwidth at time... 3 fourtypercent Hertz Linear
b3_50 = Get bandwidth at time... 3 fiftypercent Hertz Linear
b3_60 = Get bandwidth at time... 3 sixtypercent Hertz Linear
b3_70 = Get bandwidth at time... 3 seventypercent Hertz Linear
b3_80 = Get bandwidth at time... 3 eightypercent Hertz Linear
b3_90 = Get bandwidth at time... 3 ninetypercent Hertz Linear
b4_10 = Get bandwidth at time... 4 tenpercent Hertz Linear
b4_20 = Get bandwidth at time... 4 twentypercent Hertz Linear
b4_30 = Get bandwidth at time... 4 thirtypercent Hertz Linear
b4_40 = Get bandwidth at time... 4 fourtypercent Hertz Linear
b4_50 = Get bandwidth at time... 4 fiftypercent Hertz Linear
b4_60 = Get bandwidth at time... 4 sixtypercent Hertz Linear
b4_70 = Get bandwidth at time... 4 seventypercent Hertz Linear
b4_80 = Get bandwidth at time... 4 eightypercent Hertz Linear
b4_90 = Get bandwidth at time... 4 ninetypercent Hertz Linear
b5_10 = Get bandwidth at time... 5 tenpercent Hertz Linear
b5_20 = Get bandwidth at time... 5 twentypercent Hertz Linear
b5_30 = Get bandwidth at time... 5 thirtypercent Hertz Linear
b5_40 = Get bandwidth at time... 5 fourtypercent Hertz Linear
b5_50 = Get bandwidth at time... 5 fiftypercent Hertz Linear
b5_60 = Get bandwidth at time... 5 sixtypercent Hertz Linear
b5_70 = Get bandwidth at time... 5 seventypercent Hertz Linear
b5_80 = Get bandwidth at time... 5 eightypercent Hertz Linear
b5_90 = Get bandwidth at time... 5 ninetypercent Hertz Linear
b1_10$ = fixed$(b1_10, 0)
b1_20$ = fixed$(b1_20, 0)
b1_30$ = fixed$(b1_30, 0)
b1_40$ = fixed$(b1_40, 0)
b1_50$ = fixed$(b1_50, 0)
b1_60$ = fixed$(b1_60, 0)
b1_70$ = fixed$(b1_70, 0)
b1_80$ = fixed$(b1_80, 0)
b1_90$ = fixed$(b1_90, 0)
b2_10$ = fixed$(b2_10, 0)
b2_20$ = fixed$(b2_20, 0)
b2_30$ = fixed$(b2_30, 0)
b2_40$ = fixed$(b2_40, 0)
b2_50$ = fixed$(b2_50, 0)
b2_60$ = fixed$(b2_60, 0)
b2_70$ = fixed$(b2_70, 0)
b2_80$ = fixed$(b2_80, 0)
b2_90$ = fixed$(b2_90, 0)
b3_10$ = fixed$(b3_10, 0)
b3_20$ = fixed$(b3_20, 0)
b3_30$ = fixed$(b3_30, 0)
b3_40$ = fixed$(b3_40, 0)
b3_50$ = fixed$(b3_50, 0)
b3_60$ = fixed$(b3_60, 0)
b3_70$ = fixed$(b3_70, 0)
b3_80$ = fixed$(b3_80, 0)
b3_90$ = fixed$(b3_90, 0)
b4_10$ = fixed$(b4_10, 0)
b4_20$ = fixed$(b4_20, 0)
b4_30$ = fixed$(b4_30, 0)
b4_40$ = fixed$(b4_40, 0)
b4_50$ = fixed$(b4_50, 0)
b4_60$ = fixed$(b4_60, 0)
b4_70$ = fixed$(b4_70, 0)
b4_80$ = fixed$(b4_80, 0)
b4_90$ = fixed$(b4_90, 0)
b5_10$ = fixed$(b5_10, 0)
b5_20$ = fixed$(b5_20, 0)
b5_30$ = fixed$(b5_30, 0)
b5_40$ = fixed$(b5_40, 0)
b5_50$ = fixed$(b5_50, 0)
b5_60$ = fixed$(b5_60, 0)
b5_70$ = fixed$(b5_70, 0)
b5_80$ = fixed$(b5_80, 0)
b5_90$ = fixed$(b5_90, 0)
appendFileLine: outputPath$, thisPhonemeStartTime, tab$, ",", tab$, thisPhonemeEndTime, tab$, ",", tab$, thisPhoneme$, tab$, ",", tab$, f1_10$, tab$, ",", tab$, f1_20$, tab$, ",", tab$, f1_30$, tab$, ",", tab$, f1_40$, tab$, ",", tab$, f1_50$, tab$, ",", tab$, f1_60$, tab$, ",", tab$, f1_70$, tab$, ",", tab$, f1_80$, tab$, ",", tab$, f1_90$, tab$, ",", tab$, f2_10$, tab$, ",", tab$, f2_20$, tab$, ",", tab$, f2_30$, tab$, ",", tab$, f2_40$, tab$, ",", tab$, f2_50$, tab$, ",", tab$, f2_60$, tab$, ",", tab$, f2_70$, tab$, ",", tab$, f2_80$, tab$, ",", tab$, f2_90$, tab$, ",", tab$, f3_10$, tab$, ",", tab$, f3_20$, tab$, ",", tab$, f3_30$, tab$, ",", tab$, f3_40$, tab$, ",", tab$, f3_50$, tab$, ",", tab$, f3_60$, tab$, ",", tab$, f3_70$, tab$, ",", tab$, f3_80$, tab$, ",", tab$, f3_90$, tab$, ",", tab$, f4_10$, tab$, ",", tab$, f4_20$, tab$, ",", tab$, f4_30$, tab$, ",", tab$, f4_40$, tab$, ",", tab$, f4_50$, tab$, ",", tab$, f4_60$, tab$, ",", tab$, f4_70$, tab$, ",", tab$, f4_80$, tab$, ",", tab$, f4_90$, tab$, ",", tab$, f5_10$, tab$, ",", tab$, f5_20$, tab$, ",", tab$, f5_30$, tab$, ",", tab$, f5_40$, tab$, ",", tab$, f5_50$, tab$, ",", tab$, f5_60$, tab$, ",", tab$, f5_70$, tab$, ",", tab$, f5_80$, tab$, ",", tab$, f5_90$,tab$, ",", tab$, b1_10$, tab$, ",", tab$, b1_20$, tab$, ",", tab$, b1_30$, tab$, ",", tab$, b1_40$, tab$, ",", tab$, b1_50$, tab$, ",", tab$, b1_60$, tab$, ",", tab$, b1_70$, tab$, ",", tab$, b1_80$, tab$, ",", tab$, b1_90$, tab$, ",", tab$, b2_10$, tab$, ",", tab$, b2_20$, tab$, ",", tab$, b2_30$, tab$, ",", tab$, b2_40$, tab$, ",", tab$, b2_50$, tab$, ",", tab$, b2_60$, tab$, ",", tab$, b2_70$, tab$, ",", tab$, b2_80$, tab$, ",", tab$, b2_90$, tab$, ",", tab$, b3_10$, tab$, ",", tab$, b3_20$, tab$, ",", tab$, b3_30$, tab$, ",", tab$, b3_40$, tab$, ",", tab$, b3_50$, tab$, ",", tab$, b3_60$, tab$, ",", tab$, b3_70$, tab$, ",", tab$, b3_80$, tab$, ",", tab$, b3_90$, tab$, ",", tab$, b4_10$, tab$, ",", tab$, b4_20$, tab$, ",", tab$, b4_30$, tab$, ",", tab$, b4_40$, tab$, ",", tab$, b4_50$, tab$, ",", tab$, b4_60$, tab$, ",", tab$, b4_70$, tab$, ",", tab$, b4_80$, tab$, ",", tab$, b4_90$, tab$, ",", tab$, b5_10$, tab$, ",", tab$, b5_20$, tab$, ",", tab$, b5_30$, tab$, ",", tab$, b5_40$, tab$, ",", tab$, b5_50$, tab$, ",", tab$, b5_60$, tab$, ",", tab$, b5_70$, tab$, ",", tab$, b5_80$, tab$, ",", tab$, b5_90$,tab$
endfor
removeObject: currentFormant

appendInfoLine: newline$, "Script completed successfully"
