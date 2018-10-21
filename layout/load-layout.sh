#!/bin/bash

# Building this layout
# workspace 1:
# ____________________________________
# |                     |             |
# |                     |             |
# |                     |  tty-clock  |
# |                     |             |
# |                     |_____________|
# |                     |             |
# |       termite       |   when ci   |
# |                     |             |
# |                     |-------------|
# |                     |             |
# |                     |   todo ls   |
# |                     |             |
# |_____________________|_____________|
#
# workspace 2:
# ____________________________________
# |                     |             |
# |                     |             |
# |                     |             |
# |                     |             |
# |                     |             |
# |                     |             |
# |       termite       |    kpcli    |
# |                     |             |
# |                     |             |
# |                     |             |
# |                     |             |
# |                     |             |
# |_____________________|_____________|
#
# It may be usefull to disable mouse pointer and/or touchpad while
# layouting.
#
# Disable mouse:
# mouseID=`xinput list | grep -Eo 'Mouse\s.*id\=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}'`
# xinput set-prop $mouseID "Device Enabled" 0
#
# Enable mouse:
# xinput set-prop $mouseID "Device Enabled" 1
#
# Disable the touchpad:
# touchID=`xinput list | grep -Eo 'TouchPad\s*id\=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}'`
# xinput set-prop $touchID "Device Enabled" 0
#
# Enable the touchpad
# xinput set-prop $touchID "Device Enabled" 1

# CODE
# ==========

# i3-msg workspace "2"

# i3-msg "append_layout $HOME/scripts/layout/workspace_2.json"
# termite --exec "bash -c 'ssh-add; clear; echo; neofetch; bash'" --title "Terminal2" &
# termite --exec "sh $HOME/scripts/kpcli.sh" --title "KeePass" &

# sleep 1

i3-msg workspace "1"

i3-msg "append_layout $HOME/scripts/layout/workspace_1.json"
termite --exec "bash -c 'echo; neofetch; bash'" --title "Terminal1" &
termite --exec "tty-clock -c -b -n -C 6" --title "Clock" &
termite --exec "sh $HOME/scripts/layout/update_calendar.sh" --title "Calendar" &
termite --exec "sh $HOME/scripts/layout/update_todo.sh" --title "To-Do List" &

sleep 1.0
i3-msg '[con_mark="primary_terminal"] focus'
sleep 3.0
i3-msg '[con_mark="primary_terminal"] focus'

