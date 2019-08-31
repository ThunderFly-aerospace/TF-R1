#!/bin/bash

station='rear-cam'
camera='10.42.0.123'
today=`date '+%Y_%m_%d_%H%M%S%N'`;
filename="$station-$today.mp4"
filename = "aaa"

echo "$camera"
#rtsp://10.42.0.66/user=admin&password=&channel=1&stream=0

#cvlc "rtsp://@$camera/user=admin&password=&channel=1&stream=0" --sout "#std{access=file{no-append,no-format,no-overwrite},mux='mp4',dst='/data/cam_out/$filename'}"

cvlc "rtsp://@$camera/user=admin&password=&channel=1&stream=0" --sout "#record{dst-prefix='/data/cam_out/$filename',mux='mp4'}"

