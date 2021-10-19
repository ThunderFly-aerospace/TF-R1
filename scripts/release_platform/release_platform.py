from pymavlink import mavutil


mavlink = mavutil.mavlink_connection('udpin:localhost:14540')

mavlink.wait_heartbeat()
print("Heartbeat from system (system %u component %u)" % (mavlink.target_system, mavlink.target_component))


while 1:
    msg = mavlink.recv_match(blocking=True)
    if not msg:
        pass
    if msg.get_type() == 'CAMERA_IMAGE_CAPTURED':
        print(msg)
    else:
        #print(".", end='', flush=True)
        #Message is valid
        # Use the attribute
        #print('Mode:', msg.get_type())
        pass
