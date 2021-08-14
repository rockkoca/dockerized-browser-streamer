#!/bin/bash

set -xeuo pipefail

VIDEO_BITRATE=3000
VIDEO_FRAMERATE=30
VIDEO_GOP=$((VIDEO_FRAMERATE * 2))
AUDIO_BITRATE='192k'
AUDIO_SAMPLERATE=44100
AUDIO_CHANNELS=2

# ffmpeg -f x11grab -framerate 1 -video_size 1200x500 -i :0.0 -vframes 1 output.jpeg
CMD=(
  ffmpeg
  -hide_banner
  -loglevel error
  # disable interaction via stdin
  -nostdin
  # screen image size
  -video_size ${SCREEN_WIDTH}x${SCREEN_HEIGHT}
#  -filter:v "crop=out_w:out_h:x:y"
  # video frame rate
  #  -r 1
  # hides the mouse cursor from the resulting video
  -draw_mouse 0
  # grab the x11 display as video input
  -f x11grab
  -i ${DISPLAY}
  #  -framerate 1
  # grab pulse as audio input
  #  -i :0.0
  #  -vframes 1
#  -codec:v libx264 -pix_fmt yuv420p
  -y
  -update 1
  #  /output/output.jpeg
  -r 0.25 /output/output.png
)

sleep 5
while :; do
  # shellcheck disable=SC2093
  exec "${CMD[@]}"
  echo 'finished output'
  sleep 10
done
