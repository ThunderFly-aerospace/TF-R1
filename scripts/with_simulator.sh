trap 'kill 0' EXIT
mavlink-routerd -c router_config/simulator.conf &
python3 ../sw/WebDashboard/mavlink-websocket/mavlink-websocket.py &

while true; do read; done
