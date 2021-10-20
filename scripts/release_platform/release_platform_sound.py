from pymavlink import mavutil
import beepy

mavlink = mavutil.mavlink_connection('udpin:0.0.0.0:14550')

mavlink.wait_heartbeat()
print("Heartbeat from system (system %u component %u)" % (mavlink.target_system, mavlink.target_component))

last_state = -1

# CAMERA_IMAGE_CAPTURED {time_boot_ms : 49348205, time_utc : 9926083, camera_id : 1, lat : -2147483648, lon : 243787498, alt : 18, relative_alt : 1000, q : [0.0, 0.0, 0.0, 0.0], image_index : 1, capture_result : 0, file_url : }


while 1:
    msg = mavlink.recv_match(blocking=True)
    if not msg:
        pass
    if msg.get_type() == 'CAMERA_IMAGE_CAPTURED':
        print(msg)
        dic = msg.to_dict()
        #print("Dic", dic)
        new_state = dic['image_index']
        new_release = dic['capture_result']
        
        if new_release or new_state == 2:
            beepy.beep(sound=6)
            print("RELEASE")
        elif last_state != new_state:
            beepy.beep(sound=4)
            print("CHANGE")

        last_state = new_state
        
    else:
        #print(".", end='', flush=True)
        #Message is valid
        # Use the attribute
        #print('Mode:', msg.get_type())
        pass
