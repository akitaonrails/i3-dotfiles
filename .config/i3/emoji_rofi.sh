#!/bin/bash

SRC_PATH="$HOME/.config/rofi/emoji-list"
DB_PATH="$HOME/.config/rofi/emoji.db"

# Create database (see also: `frece update`)
[[ -f "$DB_PATH" ]] || frece init $DB_PATH $SRC_PATH

# Rofi
line=`frece print "$DB_PATH" | rofi -dmenu -i -markup-rows -p "" -columns 6`
[[ -z $line ]] && exit

# Increment entry and paste
frece increment "$DB_PATH" "$line"
a="${line#*>}"
b="${a%<*}"
echo $a
echo $b
echo -n $b | xsel -ipb
xdotool key Ctrl+Shift+v
