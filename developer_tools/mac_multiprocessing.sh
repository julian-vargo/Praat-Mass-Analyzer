#!/bin/bash

# Stop on unset variables
set -u

# Path configuration
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/.."

# Path to Praat executable on macOS
PRAAT_EXE="/Applications/Praat.app/Contents/MacOS/Praat"

# Number of parallel Praat processes
NUM_CORES=6

# Delay between launches to reduce crashes
LAUNCH_DELAY_SECONDS=2

# Main loop
for (( I=1; I<=NUM_CORES; I++ ))
do
    echo "Launching process $I of $NUM_CORES..."

    "$PRAAT_EXE" --run "mass_analyzer.praat" 1 "$NUM_CORES" "$I" &

    sleep "$LAUNCH_DELAY_SECONDS"
done

echo "All processes launched."
wait
echo "All processes finished."