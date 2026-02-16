#!/bin/bash

# Simple rofi script to launch applications
# Usage: ./rofi_script.sh

# Get list of installed applications
apps=$(ls /usr/share/applications/ | sed 's/\.desktop$//' | sort)

# Launch rofi with the list of applications
chosen=$(echo "$apps" | rofi -dmenu -i -p "Run:"\
    -theme-str 'window { background-color: #282828; width: 30%; }' \
    -theme-str 'mainbox { children: [listview]; }' \
    -theme-str 'listview { columns: 1; lines: 10; }' \
    -theme-str 'textbox { background-color: #282828; text-color: #ebdbb2; }' \
    -theme-str 'entry { background-color: #282828; text-color: #ebdbb2; }' \
    -theme-str 'listview { background-color: #282828; text-color: #ebdbb2; }' \
    -theme-str 'element { background-color: #282828; text-color: #ebdbb2; }' \
    -theme-str 'element selected { background-color: #458588; text-color: #282828; }')


# If an application was chosen, launch it
if [ -n "$chosen" ]; then
    $chosen &
fi
