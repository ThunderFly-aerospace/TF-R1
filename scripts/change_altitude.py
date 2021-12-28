from pymavlink import mavutil
import time

#14540 - pro simulator
#14550 - pro MOX

master = mavutil.mavlink_connection('udpin:0.0.0.0:14550', source_system=1, autoreconnect=True)
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


min = 30
max = 300
step = 10
delay = 15
steps = list(range(min, max, step))
#steps += steps[::-1]
print(steps)

print("pocet kroku", len(steps))
print("Doba: ", len(steps)*delay/60, "min")


for alt_sp in steps:
    print("Nova vyska:", alt_sp)
    set_pos(alt_sp)
    time.sleep(delay/2);
    set_pos(alt_sp);
    time.sleep(delay/2);
