#!/bin/bash
# handle if no argument is provided
if [ $# -eq 0 ]; then
  echo "No background image path provided"
  exit 1
fi

echo "Setting background to $1"

# handle err if below command fails
swaymsg "output * background \"$1\" fill"
if [ $? -ne 0 ]; then
  echo "Failed to set background"
  exit 1
else
  echo "Background set successfully"
fi
