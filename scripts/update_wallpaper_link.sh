#!/bin/bash


NEW_WALLPAPER=$1
LINK_PATH="$HOME/.cache/current_wallpaper"

# 1. Safety check: If for some reason a directory named 'current_wallpaper' exists, remove it
if [ -d "$LINK_PATH" ] && [ ! -L "$LINK_PATH" ]; then
  rm -rf "$LINK_PATH"
fi

if [ -z "$NEW_WALLPAPER" ]; then
  echo "Error: No wallpaper path provided."
  exit 1
fi

# generating colors with pywal
source ~/.venv/bin/activate

wal -i $NEW_WALLPAPER -n -s -t -e

# 2. Ensure the parent directory (.cache) exists
mkdir -p "$(dirname "$LINK_PATH")"

# 3. Create the symlink
# We use -n to prevent it from nesting inside if it's a directory
# We use -f to overwrite the old link
ln -sfn "$NEW_WALLPAPER" "$LINK_PATH"

echo "Updated link: $LINK_PATH points to $NEW_WALLPAPER"
