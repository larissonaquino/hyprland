#!/bin/bash

OPTIONS="  Power Off\n  Reboot\n  Lock\n󰒲  Suspend\n  Log Out"

chosen_option=$(echo -e "$OPTIONS" | rofi -dmenu -p "Power Menu" -theme gruvbox-dark)

case "$chosen_option" in
    "  Power Off")
        systemctl poweroff
        ;;
    "  Reboot")
        systemctl reboot
        ;;
    "  Lock")
        hyprlock
        ;;
    "󰒲  Suspend")
        systemctl suspend
        ;;
    "  Log Out")
        hyprctl dispatch exit
        ;;
esac