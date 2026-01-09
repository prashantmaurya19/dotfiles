#!/bin/bash
if bluetoothctl show | rg "Powered: yes"; then
  rfkill block bluetooth
else
  rfkill unblock bluetooth
fi
