@echo off
setlocal enabledelayedexpansion

REM Path configuration
set "SCRIPT_DIR=%~dp0"
cd /d "%SCRIPT_DIR%\.."
set "PRAAT_EXE=C:\Users\julia\Desktop\Praat.exe"

REM number of logical processors
set "NUM_CORES=10"

REM Set priority and reduce crashes
set "PRIORITY=/NORMAL"
set "LAUNCH_DELAY_SECONDS=2"

REM Main loop
for /L %%I in (1,1,%NUM_CORES%) do (
    echo Launching process %%I of %NUM_CORES%...
    start "" %PRIORITY% "%PRAAT_EXE%" --run "mass_analyzer.praat" 1 %NUM_CORES% %%I
    timeout /t %LAUNCH_DELAY_SECONDS% /nobreak >nul
)

pause
