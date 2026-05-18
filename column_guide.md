# A Guide to Reading the Column Names Produced by the Mass Analyzer

## General columns
file_name = name of the TextGrid file being analyzed
start_time = start time of the phoneme being analyzed
end_time = end time of the phoneme being analyzed

phoneme = label of the phoneme being analyzed
word = label of the word tier at the timestamp of the phoneme being analyzed. Optional.
misc_tier = label of the miscellaneous tier at the timestamp of the phoneme being analyzed. Optional.
misc_tier_b = label of the second miscellaneous tier at the timestamp of the phoneme being analyzed. Optional.

preceding_phone = label of the preceding phoneme directly to the left of the currently analyzed one. Prints "boundary" if the preceding phoneme label is blank or if the preceding phoneme is audio-initial
following_phone = label of the following phoneme directly to the right of the currently analyzed one. Prints "boundary" if the preceding phoneme label is blank or if the following phoneme is audio-final

## If you want pitch, the script will output the columns:
f0_10, f0_20, ... f0_90 = Fundamental frequency of the phoneme at the 10%, 20%, ... 90% timepoints of the phoneme

## If you want formants, the script will output the columns:
f1_10, f1_20, ... f1_90 = First formant at the 10%, 20%, ... 90% timepoints of the phoneme
f2_10, f2_20, ... f2_90 = Second formant at the 10%, 20%, ... 90% timepoints of the phoneme
f3_10, f3_20, ... f3_90 = Third formant at the 10%, 20%, ... 90% timepoints of the phoneme
f4_10, f4_20, ... f4_90 = Fourth formant at the 10%, 20%, ... 90% timepoints of the phoneme
f5_10, f5_20, ... f5_90 = Fifth formant at the 10%, 20%, ... 90% timepoints of the phoneme

bw1_10, bw1_20, ... bw1_90 = Bandwidth of the first formant at the 10%, 20%, ... 90% timepoints of the phoneme
bw2_10, bw2_20, ... bw2_90 = Bandwidth of the second formant at the 10%, 20%, ... 90% timepoints of the phoneme
bw3_10, bw3_20, ... bw3_90 = Bandwidth of the third formant at the 10%, 20%, ... 90% timepoints of the phoneme
bw4_10, bw4_20, ... bw4_90 = Bandwidth of the fourth formant at the 10%, 20%, ... 90% timepoints of the phoneme
bw5_10, bw5_20, ... bw5_90 = Bandwidth of the fifth formant at the 10%, 20%, ... 90% timepoints of the phoneme

## If you want formants, the script will output the columns:
harmonicity_10, harmonicity_20, ... harmonicity_90 = Harmonicity (HNR) at the 10%, 20%, ... 90% timepoints of the phoneme

## If you want intensity, the script will output the columns:
intensity_10, intensity_20, ... intensity_90, intensity_100 = Intensity at the 10%, 20%, ... 100% timepoints of the phoneme
intensity_max = Maximum intensity of the phoneme. One measurement taken per phoneme.
intensity_min = Minimum intensity of the phoneme. One measurement taken per phoneme.
intensity_difference = Difference between maximum and minimum intensity of the phoneme. One measurement taken per phoneme.

## If you want jitter and shimmer, the script will output the columns:
jitter_10, jitter_20, ... jitter_90 = Jitter at the 10%, 20%, ... 90% timepoints of the phoneme
shimmer_10, shimmer_20, ... shimmer_90 = Shimmer at the 10%, 20%, ... 90% timepoints of the phoneme

## If you want fricative measurements, i.e. spectral moments, the script will output the columns:
cog_10, cog_20, ... cog_100 = Center of gravity at the 10%, 20%, ... 100% timepoints of the phoneme
cogSD_10, cogSD_20, ... cogSD_100 = Standard deviation of the spectrum at the 10%, 20%, ... 100% timepoints of the phoneme
skewness_10, skewness_20, ... skewness_100 = Spectral skewness at the 10%, 20%, ... 100% timepoints of the phoneme
kurtosis_10, kurtosis_20, ... kurtosis_100 = Spectral kurtosis at the 10%, 20%, ... 100% timepoints of the phoneme


## If you want advanced parameters, i.e. Long term average spectrum (LTAS), nasalization, harmonic amplitudes, the script will output the columns:
ltas_f0_10, ltas_f0_20, ... ltas_f0_100 = LTAS version of fundamental frequency at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme
ltas_f1_10, ltas_f1_20, ... ltas_f1_100 = LTAS version of first formant at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme
ltas_f2_10, ltas_f2_20, ... ltas_f2_100 = LTAS version of second formant at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme
ltas_f3_10, ltas_f3_20, ... ltas_f3_100 = LTAS version of third formant at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme
ltas_f4_10, ltas_f4_20, ... ltas_f4_100 = LTAS version of fourth formant at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme
ltas_f5_10, ltas_f5_20, ... ltas_f5_100 = LTAS version of fifth formant at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme

a1_10, a1_20, ... a1_100 = Amplitude of the first (LTAS) formant at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme
a2_10, a2_20, ... a2_100 = Amplitude of the second (LTAS) formant at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme
a3_10, a3_20, ... a3_100 = Amplitude of the third (LTAS) formant at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme
a4_10, a4_20, ... a4_100 = Amplitude of the fourth (LTAS) formant at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme
a5_10, a5_20, ... a5_100 = Amplitude of the fifth (LTAS) formant at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme

h2_10, h2_20, ... h2_100 = Frequency of the second harmonic at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme
h3_10, h3_20, ... h3_100 = Frequency of the third harmonic at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme
h4_10, h4_20, ... h4_100 = Frequency of the fourth harmonic at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme
h5_10, h5_20, ... h5_100 = Frequency of the fifth harmonic at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme

ha1_10, ha1_20, ... ha1_100 = Amplitude of the fundamental frequency at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme
ha2_10, ha2_20, ... ha2_100 = Amplitude of the second harmonic at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme
ha3_10, ha3_20, ... ha3_100 = Amplitude of the third harmonic at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme
ha4_10, ha4_20, ... ha4_100 = Amplitude of the fourth harmonic at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme
ha5_10, ha5_20, ... ha5_100 = Amplitude of the fifth harmonic at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme

k1a_10, k1a_20, ... k1a_100 = Amplitude of the signal at 1000 Hz at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme
k2a_10, k2a_20, ... k2a_100 = Amplitude of the signal at 2000 Hz at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme
k3a_10, k3a_20, ... k3a_100 = Amplitude of the signal at 3000 Hz at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme
k4a_10, k4a_20, ... k4a_100 = Amplitude of the signal at 4000 Hz at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme
k5a_10, k5a_20, ... k5a_100 = Amplitude of the signal at 5000 Hz at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme

pa0_via_h1h2_10, pa0_via_h1h2_20, ... pa0_via_h1h2_100 = Amplitude at the first nasal pole, defined as the higher-amplitude of the first two harmonics (ha1 and ha2) at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme

p0_via_250_450_10, p0_via_250_450_20, ... p0_via_250_450_100 = Frequency of the first nasal pole, defined as the highest amplitude harmonic between 250 and 450 Hz at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme
pa0_via_250_450_10, pa0_via_250_450_20, ... pa0_via_250_450_100 = Amplitude of the first nasal pole, defined as the highest amplitude harmonic between 250 and 450 Hz at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme

p0_via_below_f1_10, p0_via_below_f1_20, ... p0_via_below_f1_100 = Frequency of the first nasal pole, defined as the harmonic directly below F1 (LTAS) at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme
pa0_via_below_f1_10, pa0_via_below_f1_20, ... pa0_via_below_f1_100 = Amplitude of the first nasal pole, defined as the harmonic directly below F1 (LTAS) at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme

p1_via_850_1050_10, p1_via_850_1050_20, ... p1_via_850_1050_100 = Frequency of the second nasal pole, defined as the highest amplitude harmonic between 850 and 1050 Hz at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme
pa1_via_850_1050_10, pa1_via_850_1050_20, ... pa1_via_850_1050_100 = Amplitude of the second nasal pole, defined as the highest amplitude harmonic between 850 and 1050 Hz at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme

p1_via_above_f1_10, p1_via_above_f1_20, ... p1_via_above_f1_100 = Frequency of the second nasal pole, defined as the harmonic directly above F1 (LTAS) at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme
pa1_via_above_f1_10, pa1_via_above_f1_20, ... pa1_via_above_f1_100 = Amplitude of the second nasal pole, defined as the harmonic directly above F1 (LTAS) at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme

rms_10, rms_20, ... rms_100 = Root mean squared energy at the 0-to-10%, 10-to-20%, ... 90-to-100% timepoints of the phoneme

## If you want voice analysis (Only one voice analysis per phoneme, due to window-size limitations):
voice_pitch_median = Median pitch of the phoneme
voice_pitch_mean = Mean pitch of the phoneme
voice_pitch_sd = Standard deviation of pitch of the phoneme
voice_pitch_min = Minimum pitch of the phoneme
voice_pitch_max = Maximum pitch of the phoneme

voice_pulses_n = Number of glottal pulses in the phoneme
voice_periods_n = Number of pitch periods in the phoneme
voice_period_mean = Mean pitch period of the phoneme
voice_period_sd = Standard deviation of pitch periods of the phoneme

voice_unvoiced_fraction = Fraction of the phoneme that is unvoiced
voice_voicebreaks_n = Number of voice breaks in the phoneme
voice_voicebreaks_degree = Degree of voice breaks in the phoneme

voice_jitter_local = Local jitter of the phoneme
voice_jitter_local_abs = Absolute local jitter of the phoneme
voice_jitter_rap = Relative average perturbation (RAP) jitter of the phoneme
voice_jitter_ppq5 = Five-point period perturbation quotient (PPQ5) jitter of the phoneme
voice_jitter_ddp = average absolute difference between consecutive differences between consecutive periods of the phoneme

voice_shimmer_local = Local shimmer of the phoneme
voice_shimmer_local_db = Local shimmer in decibels of the phoneme
voice_shimmer_apq3 = Three-point amplitude perturbation quotient (APQ3) shimmer of the phoneme
voice_shimmer_apq5 = Five-point amplitude perturbation quotient (APQ5) shimmer of the phoneme
voice_shimmer_apq11 = Eleven-point amplitude perturbation quotient (APQ11) shimmer of the phoneme
voice_shimmer_dda = average absolute difference between consecutive differences between the amplitudes of consecutive periods of the phoneme

voice_autocorr_mean = Mean autocorrelation of the phoneme
voice_nhr_mean = Mean noise-to-harmonics ratio (NHR) of the phoneme
voice_hnr_mean = Mean harmonics-to-noise ratio (HNR) of the phoneme

voice_h1h2_points = Point-based H1–H2 measure of the phoneme
voice_h1h2_curve = Curve-based H1–H2 measure of the phoneme

## If you want zero crossing rate:
n_zero_crossings = Number of zero crossings
zero_crossing_rate = zero crossing rate in crossings per second
