#!/bin/sh

##########
## Name: battery-monitor.sh
## Author: Rishabh Agrawal (arishabh.com)
## Description: 
## 			This is a small script for a 2 battery powered system.
##			It also gives how to calculate the total battery in the 
##			system and notifies if battery is full, at 15%, at 10% 
##			and suspends when at 5%.
##
## Date Modified : 30th January 2019
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
	    LEVEL_BAT1=$(cat /sys/class/power_supply/BAT1/capacity)
	    ENERGY_BAT1=$(cat /sys/class/power_supply/BAT1/energy_full)
        
            LEVEL_BAT0=$(cat /sys/class/power_supply/BAT0/capacity)
            ENERGY_BAT0=$(cat /sys/class/power_supply/BAT0/energy_full) 
        
            ENERGY_TOTAL=$(( ENERGY_BAT1+ENERGY_BAT0 ))
	    ENERGY_PER1=$(awk -v E1=$ENERGY_BAT1 -v E2=$ENERGY_TOTAL 'BEGIN {print E1/E2}' )
	    ENERGY_PER0=$(awk -v E0=$ENERGY_BAT0 -v E2=$ENERGY_TOTAL 'BEGIN {print E0/E2}' )

            LEVEL_PER1=$(awk -v L1=$LEVEL_BAT1 -v E1=$ENERGY_PER1 'BEGIN {print L1*E1}' )
            LEVEL_PER0=$(awk -v L0=$LEVEL_BAT0 -v E0=$ENERGY_PER0 'BEGIN {print L0*E0}' ) 

            BAT_LEVEL=$(awk -v L1=$LEVEL_PER0 -v L2=$LEVEL_PER1 'BEGIN {print L1+L2}' )
   	    BAT_LEVEL=$( printf '%.0f' "$BAT_LEVEL" )
	

            #notify-send "Current Battery: $BAT_LEVEL"

    	    if [ $BAT_LEVEL -eq 15 ] || [ $BAT_LEVEL -eq 14 ]; then
		    notify-send "Battery is at $BAT_LEVEL%, plug-in the computer"
		    #zenity --warning --text "Battery is at $BAT_LEVEL%, plug-in the computer"
	    elif [ $BAT_LEVEL -eq 10 ] || [ $BAT_LEVEL -eq 9 ]; then
		    notify-send "Battery is at $BAT_LEVEL%, plug-in the computer right now"
		    zenity --warning --text "Battery is at $BAT_LEVEL%, plug-in the computer right now"
		    
	    elif [ $BAT_LEVEL -le 5 ]; then
		    notify-send "Battery IS VERY LOW, SUSPENDING SYSTEM IN 10 SECONDS"
		    zenity --warning --text "Battery IS VERY LOW, SUSPENDING SYSTEM IN 10 SECONDS"
		    sleep 10
		    systemctl suspend -i
	    fi
    fi
    sleep 200
done
