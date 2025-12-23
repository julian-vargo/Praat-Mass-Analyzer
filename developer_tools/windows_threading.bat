@echo off
setlocal enabledelayedexpansion

set "SCRIPT_DIR=%~dp0"
cd /d "%SCRIPT_DIR%\.."

set "NUM_CORES=10"
set "PRAAT_EXE=C:\Users\julia\Desktop\Praat.exe"

REM Make it less brutal:
set "PRIORITY=/NORMAL"
set "LAUNCH_DELAY_SECONDS=2"

for /L %%I in (1,1,%NUM_CORES%) do (
    echo Launching process %%I of %NUM_CORES%...
    start "" %PRIORITY% "%PRAAT_EXE%" --run "mass_analyzer.praat" 1 %NUM_CORES% %%I
    timeout /t %LAUNCH_DELAY_SECONDS% /nobreak >nul
)

pause
