#!/usr/bin/env sh

while :; do
	DATETIME="$(date +'%Y-%m-%d %H:%M:%S')"


	echo ",[{\"name\":\"time\",\"full_text\":\"$(date)\"}]"
	sleep 1
done
