#!/bin/bash

echo -e "\nSimple statusbar program for dwm\n\nDefault install location is: $HOME/.dwmbar\n [y] - OK\n [a] - use this location as install directory\n [n] - abort installation"

read -p "$ > [y/a/n] : " input
    case $input in
    	[Yy]*) echo "YEAS" ;;  
        [Aa]*) echo "NOUS" ;;
		[Nn]*) echo "PLS"  ;;
    esac

sudo ln -s "$HOME/Documents/Scripts/dwmbar/dwmbar.sh" /usr/bin/dwmbar
sudo ln -s "$HOME/Documents/Scripts/dwmbar/status.sh" /usr/bin/dwmstatusmy
sudo ln -s "$HOME/Documents/Scripts/dwmbar/refbar.sh" /usr/bin/refbar
exit 0
