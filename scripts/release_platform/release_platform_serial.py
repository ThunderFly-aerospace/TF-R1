from pymavlink import mavutil
import platform_serial
import beepy
import serial


# 14550 real situation
mavlink = mavutil.mavlink_connection('udpin:0.0.0.0:14540')
ps = platform_serial.platform_serial('/tmp/vserial2')

mavlink.wait_heartbeat()
print("Heartbeat from system (system %u component %u)" % (mavlink.target_system, mavlink.target_component))

last_state = -1


while 1:
    ps.update()
    msg = mavlink.recv_match(blocking=True)
    if not msg:
        pass
    if msg.get_type() == 'DEBUG':
        print(msg)
        dic = msg.to_dict()
        if dic['ind'] == 0:
            new_state = dic['value']

            if new_state == 3:
                ps.open()
                #beepy.beep(sound=6)
                print("RELEASE")

            elif last_state != new_state:
                beepy.beep(sound=4)
                print("CHANGE")

        last_state = new_state

    else:
        pass
