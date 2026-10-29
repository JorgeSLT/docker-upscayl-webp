#!/bin/bash
if [ -z "$1" ]; then echo "Usage: ./scripts/upscale_script.sh input/your_video.mp4"; exit 1; fi
FILENAME=$(basename -- "$1")
BASENAME="${FILENAME%.*}"
echo "Processing $1..."
mkdir -p raw_frames proc_frames
ffmpeg -i "$1" -qscale:v 2 raw_frames/frame_%08d.jpg
/workspace/resources/linux/bin/upscayl-bin -i raw_frames -o proc_frames -m /workspace/resources/models -n ultrasharp-4x -f jpg
ffmpeg -framerate 30 -i proc_frames/frame_%08d.jpg -c:v libx264 -pix_fmt yuv420p "output/${BASENAME}_4x.mp4"
rm -rf raw_frames proc_frames
echo "Done! Saved as output/${BASENAME}_4x.mp4"
