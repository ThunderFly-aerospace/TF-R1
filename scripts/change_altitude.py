from pymavlink import mavutil
master = mavutil.mavlink_connection('udpin:0.0.0.0:14540')
master.wait_heartbeat()
print("Mam heartbeat")

master.mav.command_long_send(
    master.target_system,
    master.target_component,
    mavutil.mavlink.MAV_CMD_DO_CHANGE_ALTITUDE,
    0,
    30, mavutil.mavlink.MAV_FRAME_GLOBAL_RELATIVE_ALT, 0, 0, 0, 0, 0)
