#!/bin/sh

trap 'update' 5

# set given values

update() {
	xsetroot -name "$(dwmstatusmy | tr '\n' ' ')" &
	wait
}

while :; do
	update

	sleep 10 &
	wait
done
