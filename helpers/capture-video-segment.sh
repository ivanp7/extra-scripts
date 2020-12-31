#!/bin/sh

if [ "$#" -eq 0 ]
then
    echo "capture-video-segment.sh URL FILENAME START_TIME DROP_FIRST_SECONDS RECORD_DURATION"
    exit 0
fi

URL="$1"
FILENAME="$2"
START_TIME="$3"
DROP_FIRST_SECONDS="$4"
RECORD_DURATION="$5"

youtube_urls=$(youtube-dl --youtube-skip-dash-manifest -g "$URL")
video_url=$(echo "$youtube_urls" | head -1)
audio_url=$(echo "$youtube_urls" | tail -1)

ffmpeg -ss $START_TIME -i "$video_url" -ss $START_TIME -i "$audio_url" -map 0:v -map 1:a -ss $DROP_FIRST_SECONDS -t $RECORD_DURATION -c:v libx264 -c:a aac "$FILENAME"

