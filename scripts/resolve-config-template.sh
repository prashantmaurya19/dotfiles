#!/bin/bash

# This script resolves environment variables in the Waybar configuration template
# and generates the final configuration file.
envsubst < ~/.config/waybar/template.jsonc > ~/.config/waybar/config.jsonc
