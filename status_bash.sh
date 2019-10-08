#!/bin/bash

#---------battery
#
# check if on ac and assign icons
#
bat=""
baticon=""
b0=$(cat /sys/class/power_supply/BAT0/capacity)
b1=$(cat /sys/class/power_supply/BAT1/capacity)
bat=$(( ($b0+$b1)/2 ))
if [[ $bat -lt 10 ]]; then	
	baticon=""
elif [[ $bat -ge 10 ]] && [[ $bat -lt 25 ]]; then
	baticon=""
elif [[ $bat -ge 25 ]] && [[ $bat -lt 50 ]]; then
	baticon=""
elif [[ $bat -ge 50 ]] && [[ $bat -lt 75 ]]; then
	baticon=""
else
	baticon=""
fi

if [[ "$(cat /sys/class/power_supply/AC/online)" == "1" ]];then
	baticon=""
fi
#
#--------!battery

#---------ethernet
#
# check if ethernet is not connected (perhaps room for improvement?)
# and if not imply wlan is
#
net=""
neticon=""
eth="enp0s31f6"
wlan="wlp3s0"
if [[ "$(cat /sys/class/net/$eth/carrier)" == "0" ]]; then
	#
	# if wlan has no connection too
	#
	if [[ "$(cat /sys/class/net/$wlan/carrier)" == "1" ]]; then
		net="$(iw dev wlp3s0 info | grep ssid | tr -d '^[\tssid]$') @ $(ip addr show $wlan | grep inet | awk 'NR==1{print $2}')"
		neticon=""
	else
		net="Not connected"
		neticon=""
	fi
else
	net="$(ip addr show $eth | grep inet | awk 'NR==1{print $2}')"
	neticon=""
fi
#
#--------!ethernet




#---------volume
#
# check if mute and assign volume icon
#
vol="0"
volicon=""
if [[ "$(pactl list sinks | grep "Mute: " | tr -d ' \tMute:')" == "no" ]]; then
	vol=$(pactl list sinks | grep "Volume:" | awk 'NR==1{print $5}' | tr -d "%")
	volicon=""
	if [[ $vol -eq 0 ]]; then
		volicon=""
	elif [[ $vol -lt 25 ]]; then
		volicon=""
	elif [[ $vol -ge 25 ]] && [[ $vol -lt 60 ]]; then
		volicon=""
	else
		volicon=""
fi
else
	volicon=""
fi
#
# check if headphones are plugged in
#
if [[ "$(pacmd list-cards | grep Headphones | awk '{print $10}' | tr -d ')')" == "yes" ]]; then
	volicon=" $volicon"
fi
#
#--------!volume


# set given values
echo -e "[ $neticon$net ] [ $volicon $vol% ] [ $baticon $bat% ] | $(date '+%a %d %b %Y - %H:%M')"
