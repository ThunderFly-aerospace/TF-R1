from pymavlink import mavutil
import time

# port 14550
mavlink = mavutil.mavlink_connection('udpin:0.0.0.0:14540')

mavlink.wait_heartbeat()
print("Heartbeat from system (system %u component %u)" % (mavlink.target_system, mavlink.target_component))


#set_param('AG_PROT_MIN_RPM', 10)


seznam = [
#[b'AG_TKOFF', 1, mavutil.mavlink.MAV_PARAM_TYPE_INT8],
#[b'RWTO_TKOFF', 0,  mavutil.mavlink.MAV_PARAM_TYPE_INT8],
[b'AG_PROT_MIN_RPM', 10],
[b'AG_PROT_TRG_RPM', 400],
[b'AG_ROTOR_RPM', 400],
[b'AG_PROT_TYPE', 1],
[b'RWTO_MAX_PITCH', 10],
[b'RWTO_MAX_ROLL', 15],
[b'RWTO_NAV_ALT', 10],
[b'FW_CLMBOUT_DIFF', 10],
[b'MIS_TAKEOFF_ALT', 15],

]


def set_param(mavlink, name, value, type):

    print("nastavuji", name, value, type)

    mavlink.mav.param_set_send(
        mavlink.target_system, mavlink.target_component,
        name,
        value,
        type
    )

    # Read ACK
    # IMPORTANT: The receiving component should acknowledge the new parameter value by sending a
    # param_value message to all communication partners.
    # This will also ensure that multiple GCS all have an up-to-date list of all parameters.
    # If the sending GCS did not receive a PARAM_VALUE message within its timeout time,
    # it should re-send the PARAM_SET message.
    message = mavlink.recv_match(type='PARAM_VALUE', blocking=True).to_dict()
    print('name: %s\tvalue: %d' %
          (message['param_id'], message['param_value']))

    time.sleep(1)

    # Request parameter value to confirm
    mavlink.mav.param_request_read_send(
        mavlink.target_system, mavlink.target_component,
        name,
        -1
    )


for param in seznam:
    if len(param) == 2:
        set_param(mavlink, param[0], param[1], mavutil.mavlink.MAV_PARAM_TYPE_REAL32)
    else:
        set_param(mavlink, param[0], param[1], param[2])
