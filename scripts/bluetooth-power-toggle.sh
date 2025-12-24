#!/bin/bash
if bluetoothctl show | grep -q "Powered: yes"; then
  rfkill unblock bluetooth
else
  rfkill block bluetooth
fi
