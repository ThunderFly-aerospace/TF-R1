# Mavlink

### Příklady použití v autě TF-R1

V palubním počítači spustit:
```
roscore

rosrun mavros mavros_node _fcu_url:=/dev/ttyUSB0 _gcs_url:='udp://@<adresa QGC>'
```
