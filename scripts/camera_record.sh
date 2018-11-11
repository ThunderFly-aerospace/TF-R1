#!/bin/bash

station='left-front-cam'

today=`date '+%Y_%m_%d_%H%M%S%N'`;
filename="./$station-$today.mkv"
mpv --record-file=$filename "rtsp://10.42.0.67/user=admin&password=&channel=1&stream=0" --fps 19 --no-correct-pts

