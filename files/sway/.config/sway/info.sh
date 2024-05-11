#!/usr/bin/env sh

while :; do
	DATETIME="$(date +'%Y-%m-%d %H:%M:%S')"
	BATTERY="$(upower -i `upower -e | grep 'BAT'` | grep -E "percentage" | grep -oP '\d+(%)')"
	INPUT_VOLUME="$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)"
	OUTPUT_VOLUME="$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"

	echo "OUT: $OUTPUT_VOLUME | IN: $INPUT_VOLUME | BAT: $BATTERY | $DATETIME"
	sleep 0.05
done
