#!/bin/sh
# stolen from 6gk
# usage: timer <time to wait> <notification>

calc() {
	seconds="$(echo "$1*$2" | bc | sed 's/\..*$//')"
}

case "$1" in
	*h) calc "${1%?}" 3600;;
	*m) calc "${1%?}"   60;;
	*s) seconds="${1%?}"  ;;
	*)  calc "$1"       60;;
esac

echo "timer set for $1 ($seconds) ${2:+- $2}"
{
	sleep "$seconds"
	paplay "/usr/share/sounds/freedesktop/stereo/complete.oga" |: &
	notify-send -u critical "Times Up!" "$2"
} &