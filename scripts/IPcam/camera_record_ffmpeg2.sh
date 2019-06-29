#!/bin/bash

station='center-rear-cam'
camera='10.42.0.144'
today=`date '+%Y_%m_%d-%H_%M_%S-%N'`;
filename="./$station-$today.mp4"
echo "$camera"

ffmpeg -i "rtsp://@$camera/user=admin&password=&channel=0&stream=0" -y $filename -movflags faststart -vcodec copy -r 20 -threads 4
