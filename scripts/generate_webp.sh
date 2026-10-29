#!/bin/bash
if [ -z "$1" ]; then echo "Usage: ./scripts/generate_webp_script.sh output/your_video_4x.mp4"; exit 1; fi
FILENAME=$(basename -- "$1")
BASENAME="${FILENAME%.*}"
echo "Converting $1 to animated WebP..."
ffmpeg -i "$1" -vcodec libwebp -filter:v fps=fps=15 -lossless 0 -compression_level 4 -q:v 70 -loop 0 "output/${BASENAME}.webp"
echo "Done! Saved as output/${BASENAME}.webp"
