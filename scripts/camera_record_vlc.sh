#!/bin/bash

station='left-front-cam'
camera='10.42.0.66'
today=`date '+%Y_%m_%d_%H%M%S%N'`;
filename="./$station-$today.mkv"

 # mpv --record-file=$filename "rtsp://10.42.0.67/user=admin&password=&channel=1&stream=0" --fps 19 --no-correct-pts

echo "$camera"

#vlc "rtsp://@$camera/user=admin&password=&channel=0&stream=0" --network-caching=45 &
cvlc "rtsp://@$camera/user=admin&password=&channel=0&stream=0" --http-reconnect --sout "#transcode{acodec=none}:file{dst=../../cam_out/1/$filename}"

