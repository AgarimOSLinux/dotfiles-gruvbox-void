#!/usr/bin/env sh

while :; do
	DATETIME="$(date +'%Y-%m-%d %H:%M:%S')"
	BATTERY="$(upower -i `upower -e | grep 'BAT'` | grep -E "percentage" | grep -oP '\d+(%)')"
	INPUT_VOLUME="$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -oP '\d+(...)')"
	OUTPUT_VOLUME="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -oP '\d+(...)')"

	echo "OUT: $OUTPUT_VOLUME | IN: $INPUT_VOLUME | BAT: $BATTERY | $DATETIME"
	sleep 0.05
done
