# Changelog

## [v2.1.0] - May 20, 2026
#### Major Features:
- I've been continuously adding to the script but not keeping track of update versions, woops!
- Added several new acoustic measures such as voice report, zero crossing rate, and MFCC
- Fixed a handful of bugs and issues
- Added a mac and linux multiprocessing scripts (written with AI). I don't have mac or linux and cannot troubleshoot at the moment.

## [v2.0.0] - Dec 20, 2025
#### Major Features:
- Multiprocessing support for Windows via batch script (`devtools/windows_threading.bat`)
- Several Nasal pole amplitude and frequency measurements, H1-through-H5 frequency & amplitude, amplitudes from 1k-through-5k, RMS Energy, LTAS of F0-through-F5
- Massive overhaul of script logic for printing
- Widened shimmer and jitter timestamps for more accurate windows
- Widened harmonicity timestamps for more accurate windows
- Replaced hard-coded timestamps (eg. tenPercent$) with dynamic arrays, shortening script and making better maintainability
- Moved numeric-to-string$ conversion into results-compiling lines
- Gave fricative measurements continuous analyses
- Completely removed formant auto-tracking feature, as the whole algorithm should be gutted and replaced
- Completely removed formant slopes from the script, as the user can calculate this from the raw formants how they please. Formant slopes were making the file unnecessarily large.

