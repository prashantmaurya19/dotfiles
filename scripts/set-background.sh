#!/bin/bash
# handle if no argument is provided
# if [ $# -eq 0 ]; then
#   echo "No background image path provided"
#   exit 1
# fi

# echo "Setting background to $1"

# # handle err if below command fails
# swaymsg "output * background \"$1\" fill"
# if [ $? -ne 0 ]; then
#   echo "Failed to set background"
#   exit 1
# else
#   echo "Background set successfully"
# fi

# Configuration
CACHE_DIR="$HOME/.cache/sway"
CACHE_FILE="$CACHE_DIR/last_bg"
FALLBACK_BG="/usr/share/backgrounds/default.jpg" # Change this to your actual fallback path

# Ensure cache directory exists
mkdir -p "$CACHE_DIR"

# 1. Determine which image to use
if [ -n "$1" ]; then
    # Use the argument provided by the user
    TARGET_BG="$1"
elif [ -s "$CACHE_FILE" ]; then
    # No argument, so try to read from cache (if file exists and is not empty)
    TARGET_BG=$(cat "$CACHE_FILE")
else
    # No argument and no cache, use fallback
    TARGET_BG="$FALLBACK_BG"
fi

# 2. Validate the target path
# If the file doesn't exist, revert to fallback
if [ ! -f "$TARGET_BG" ]; then
    echo "Warning: $TARGET_BG not found. Using fallback."
    TARGET_BG="$FALLBACK_BG"
fi

# 3. Apply the background
echo "Setting background to: $TARGET_BG"
swaymsg "output * background \"$TARGET_BG\" fill"

# 4. Handle results and update cache
if [ $? -eq 0 ]; then
    echo "Background set successfully"
    # Save the successful path to cache for next time
    echo "$TARGET_BG" > "$CACHE_FILE"
else
    echo "Error: swaymsg failed to set background"
    exit 1
fi
