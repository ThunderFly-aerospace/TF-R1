from pymavlink import mavutil
import beepy

mavlink = mavutil.mavlink_connection('udpin:0.0.0.0:14540')

mavlink.wait_heartbeat()
print("Heartbeat from system (system %u component %u)" % (mavlink.target_system, mavlink.target_component))


mavlink.mav.set_mode_send(mavlink.target_system, mavutil.mavlink.MAV_MODE_FLAG_CUSTOM_MODE_ENABLED, 11)
print("cekam na odpoved")

while True:
    # Wait for ACK command
    ack_msg = mavlink.recv_match(type='COMMAND_ACK', blocking=True)
    ack_msg = ack_msg.to_dict()
    print("ACK", ack_msg)

    # Check if command in the same in `set_mode`
    if ack_msg['command'] != mavutil.mavlink.MAVLINK_MSG_ID_SET_MODE:
        continue

    # Print the ACK result !
    print(mavutil.mavlink.enums['MAV_RESULT'][ack_msg['result']].description)
    break

print("Prepnuti dokonceno")
