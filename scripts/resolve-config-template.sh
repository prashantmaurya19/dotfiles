#!/bin/bash

# This script resolves environment variables in the Waybar configuration template
# and generates the final configuration file.
envsubst < ~/.config/waybar/config.template > ~/.config/waybar/config
