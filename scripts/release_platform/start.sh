export MAVLINK20=1
export MAVLINK_DIALECT=common
export MAVLINK_ENDPOINT=udpin:0.0.0.0:14552

python3 release_platform_serial.py | tee /root/log_platform_$(date +"%Y%m%d_%H%M%S").log

