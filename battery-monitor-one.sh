#!/bin/sh

##########
## Name: battery-monitor-one.sh
## Author: Rishabh Agrawal (arishabh.com)
## Description: 
## 			This is a small script for a 1 battery powered system.
##			It also gives how to calculate the total battery in the 
##			system and notifies if battery is full, at 15%, at 10% 
##			and suspends when at 5%.
##
## Date Modified : 4th February 2019
##
## Dependencies: send-notify, zenity
## 
## Tested on Ubuntu Desktop 16.04.2 LTS
##########

while true; do
    STATE=$( upower -i /org/freedesktop/UPower/devices/battery_BAT1 | awk '/state:/{print $2}' )

    if [ $STATE = "fully-charged" ]; then
	    notify-send "Battery Full!"

    elif [ $STATE = "discharging" ]; then
            BAT_LEVEL=$(cat /sys/class/power_supply/BAT0/capacity)
	
	    # Used for testing only, it prints the current battery value to see if the value we are getting is correct
	    ## **IMPORTANT** IF YOU ARE TESTING, MAKE SURE YOU COMMENT OUT LINE 50 WHICH SAYS "systemctl suspend i" because if the battery level is incorrect, it will suspend the computer 
            #notify-send "Current Battery: $BAT_LEVEL"

    	    if [ $BAT_LEVEL -eq 15 ] || [ $BAT_LEVEL -eq 14 ]; then
		    notify-send "Battery is at $BAT_LEVEL%, plug-in the computer"
		    #zenity --warning --text "Battery is at $BAT_LEVEL%, plug-in the computer" --width=150 --height=130
	    elif [ $BAT_LEVEL -eq 10 ] || [ $BAT_LEVEL -eq 9 ]; then
		    notify-send "Battery is at $BAT_LEVEL%, plug-in the computer right now"
		    zenity --warning --text "Battery is at $BAT_LEVEL%, plug-in the computer right now" --width=150 --height=130
		    
	    elif [ $BAT_LEVEL -le 5 ]; then
		    notify-send "Battery IS VERY LOW, SUSPENDING SYSTEM IN 10 SECONDS"
		    zenity --warning --text "Battery IS VERY LOW, SUSPENDING SYSTEM IN 10 SECONDS" --width=150 --height=130
		    sleep 10
		    systemctl suspend -i
	    fi
    fi
    sleep 200
done
