#!/bin/bash

set -u

# Path configuration
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/.."

# If Praat is installed system-wide, this should work.
# Otherwise replace with the full path to the Praat executable.
PRAAT_EXE="praat"

# Number of parallel Praat processes
NUM_CORES=6

# Delay between launches to reduce crashes
LAUNCH_DELAY_SECONDS=2

# Check that Praat is available
if ! command -v "$PRAAT_EXE" >/dev/null 2>&1; then
    echo "Error: Praat executable not found."
    echo "Install Praat or edit PRAAT_EXE in this script."
    echo ""
    echo "Examples:"
    echo '  PRAAT_EXE="praat"'
    echo '  PRAAT_EXE="/usr/bin/praat"'
    echo '  PRAAT_EXE="/home/yourname/bin/praat"'
    exit 1
fi

# Check that the script exists
if [ ! -f "mass_analyzer.praat" ]; then
    echo "Error: mass_analyzer.praat not found."
    echo "Current directory:"
    pwd
    exit 1
fi

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