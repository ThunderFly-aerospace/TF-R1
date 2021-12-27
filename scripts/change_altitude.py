from pymavlink import mavutil
import time

#14540 - pro simulator
#14550 - pro MOX

master = mavutil.mavlink_connection('udpin:0.0.0.0:14540')
master.wait_heartbeat()
print("Mam heartbeat")

min_alt = 500 # AMLS
lat = float("NAN")
lon = float("NAN")


def set_pos(rel_alt, lat = float("NAN"), lon = float("NAN")):
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


for alt_sp in range(50, 100, 20):
    print("Nova vyska:", alt_sp)
    set_pos(alt_sp)
    time.sleep(100);
