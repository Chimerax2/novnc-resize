#!/bin/bash -e

Xvfb -screen 0 1920x1080x24 -ac &

export DISPLAY=:0
jwm -display :0 &

# Open firefox to see if screen resizes since otherwise its black screen
firefox -fullscreen &

# Start vnc
x11vnc &

# Start the novnc
/home/chimera/noVNC/utils/launch.sh --vnc localhost:5900 &

# Start the nodejs server that fires resize
cd ~/server && node app.js &
export WID=$!

tail -f /dev/null