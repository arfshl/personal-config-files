#!/bin/bash

# Format flags
# Download Video in 360p Resolution and mp4 format (change res: to any resolution)
VIDEO="-S vcodec:h264,fps,res:360,acodec:aac,ext:mp4 -P /home/$USER/Download"
# Download Audio in mp3 format
AUDIO="-x --audio-format mp3 -P /home/$USER/Download"

# Check arguments
if [[ $# -eq 0 ]]; then
    echo "Usage: ytdla [-v {video} |-a {audio}] <URL>"
    echo "Examples:"
    echo "  ./ytdla -v <URL>"
    echo "  ./ytdla -a <URL>"
    exit 1
fi

# Parse mode
if [[ "$1" == "-v" || "$1" == "-a" ]]; then
    MODE="$1"
    shift
fi

# URL check
if [[ -z "$1" ]]; then
    echo "Error: No URL provided."
    exit 1
fi

URL="$1"
FORMAT="$VIDEO"
if [[ "$MODE" == "-v" ]]; then
    FORMAT="$VIDEO"
elif [[ "$MODE" == "-a" ]]; then
    FORMAT="$AUDIO"
fi

# Download
yt-dlp $FORMAT "$URL"
