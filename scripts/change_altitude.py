from pymavlink import mavutil
import time
import sys

#14540 - pro simulator
#14550 - pro MOX

master = mavutil.mavlink_connection('udpin:0.0.0.0:14540', source_system=1, autoreconnect=True)
print("Heartbeat from system (system %u component %u)" % (master.target_system, master.target_component))
#master = mavutil.mavlink_connection('udpin:0.0.0.0:14445')
master.wait_heartbeat()
print("Mam heartbeat")


# 460 AMLS


min_alt = 460 # AMLS
lat = float("NAN")
lon = float("NAN")

#lat = 49.1169
#lon = 14.3832

def set_pos(rel_alt, lat = float("NAN"), lon = float("NAN"), rate = float("NAN")):
    master.mav.command_long_send(
        master.target_system,
        master.target_component,
        mavutil.mavlink.MAV_CMD_DO_REPOSITION,
        0,
        -1, # nemenit airspeed
        mavutil.mavlink.MAV_DO_REPOSITION_FLAGS_CHANGE_MODE,
        0, # reserved
        0, # smer otaceni
        lat,
        lon,
        min_alt+rel_alt )

try:
    min = 60
    max = 300
    delay = 300

    rate = (max-min)/delay

    print("Stoupani/klesani:", rate)
    print("Doba letu: ", 2*delay/60, "min")

    master.mav.param_set_send(
        master.target_system,
        master.target_component, b"FW_T_CLMB_R_SP", rate, mavutil.mavlink.MAVLINK_TYPE_FLOAT)

    master.mav.param_set_send(
        master.target_system,
        master.target_component, b"FW_T_SINK_R_SP", rate, mavutil.mavlink.MAVLINK_TYPE_FLOAT)


    print("Nova vyska:", max, "m AGL")
    set_pos(max, lat, lon, rate)
    print("Klesani vyresit pres QGC")
    while True:
        pass
##    time.sleep(delay);
#    print("Nova vyska:", min, "m AGL")
#    set_pos(min, lat, lon, -rate)
#    time.sleep(delay);

except KeyboardInterrupt:
    master.mav.param_set_send(
        master.target_system,
        master.target_component, b"FW_T_CLMB_R_SP", 3, mavutil.mavlink.MAVLINK_TYPE_FLOAT)

    master.mav.param_set_send(
        master.target_system,
        master.target_component, b"FW_T_SINK_R_SP", 2, mavutil.mavlink.MAVLINK_TYPE_FLOAT)

    sys.exit(0)
