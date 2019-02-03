#!/bin/bash

station='center-rear-cam'
camera='10.42.0.123'
today=`date '+%Y_%m_%d-%H_%M_%S-%N'`;
filename="./$station-$today.mp4"
echo "$camera"

ffmpeg -i "rtsp://@$camera/user=admin&password=&channel=0&stream=0" -y $filename -b 900k -vcodec copy -r 19 -threads 4
