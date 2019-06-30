#!/bin/bash

station='left-front-cam'
camera='10.42.0.66'
today=`date '+%Y_%m_%d_%H%M%S%N'`;
filename="./$station-$today.mp4"

echo "$camera"

cvlc "rtsp://@$camera/user=admin&password=&channel=0&stream=0" --network-caching=45 --http-reconnect --sout "std{access=file{no-append,no-format,no-overwrite},mux='mp4',dst='../../cam_out/1/$filename'}"
