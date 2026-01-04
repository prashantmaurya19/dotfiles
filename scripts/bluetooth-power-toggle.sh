#!/bin/bash
if bluetoothctl show | rg "Powered: yes"; then
  sudo rfkill unblock bluetooth
else
  sudo rfkill block bluetooth
fi
