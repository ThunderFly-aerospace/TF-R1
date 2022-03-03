from pymavlink import mavutil
import platform_serial
#import beepy
import serial
import time



def request_message_interval(message_id: int, frequency_hz: float):
    """
    Request MAVLink message in a desired frequency,
    documentation for SET_MESSAGE_INTERVAL:
        https://mavlink.io/en/messages/common.html#MAV_CMD_SET_MESSAGE_INTERVAL

    Args:
        message_id (int): MAVLink message ID
        frequency_hz (float): Desired frequency in Hz
    """
    mavlink.mav.command_long_send(
        mavlink.target_system, mavlink.target_component,
        mavutil.mavlink.MAV_CMD_SET_MESSAGE_INTERVAL, 0,
        message_id, # The MAVLink message ID
        1e6 / frequency_hz, # The interval between two messages in microseconds. Set to -1 to disable and 0 to request default rate.
        0, 0, 0, 0, # Unused parameters
        0, # Target address of message stream (if message has target address fields). 0: Flight-stack default (recommended), 1: address of requestor, 2: broadcast.
    )





print("Script started, waiting to mavlink heartbeat")
# 14550 real situation
mavlink = mavutil.mavlink_connection('udpin:0.0.0.0:14550')
#mavlink = mavutil.mavlink_connection('udpin:0.0.0.0:14555')

ps = platform_serial.platform_serial('/dev/ttyUSB1', debug=True)

mavlink.wait_heartbeat()
request_message_interval(mavutil.mavlink.MAVLINK_MSG_ID_DEBUG, 5)
#mavlink.request_data_stream_send(mavlink.target_system, mavlink.target_component, mavutil.mavlink.MAVLINK_MSG_ID_DEBUG, 10)
print("Heartbeat from system (system %u component %u)" % (mavlink.target_system, mavlink.target_component))

last_state = -1

while 1:
    #print(".", end="")
    #ps.update()
    msg = mavlink.recv_match(blocking=False)
    #print(msg)
    if not msg:
        continue
        pass

    if msg.get_type() == 'HEARTBEAT':
        pass
        print("heartbeat")
        #ps.open(1)

    if msg.get_type() == 'DEBUG':
        dic = msg.to_dict()
        dic['msgid'] = msg.get_msgId()
        dic['sysid'] = msg.get_srcSystem()
        dic['compid'] = msg.get_srcComponent()
        print("DEBUG", dic, msg)
#        if dic['ind'] == 0:
        new_state = float(dic['value'])
        print(new_state)
        if new_state > 2.5:
            ps.open(10)
            print("RELEASE")

        if last_state != new_state:
            print("CHANGE")

        last_state = new_state



def request_message_interval(message_id: int, frequency_hz: float):
    """
    Request MAVLink message in a desired frequency,
    documentation for SET_MESSAGE_INTERVAL:
        https://mavlink.io/en/messages/common.html#MAV_CMD_SET_MESSAGE_INTERVAL

    Args:
        message_id (int): MAVLink message ID
        frequency_hz (float): Desired frequency in Hz
    """
    mavlink.mav.command_long_send(
        mavlink.target_system, mavlink.target_component,
        mavutil.mavlink.MAV_CMD_SET_MESSAGE_INTERVAL, 0,
        message_id, # The MAVLink message ID
        1e6 / frequency_hz, # The interval between two messages in microseconds. Set to -1 to disable and 0 to request default rate.
        0, 0, 0, 0, # Unused parameters
        0, # Target address of message stream (if message has target address fields). 0: Flight-stack default (recommended), 1: address of requestor, 2: broadcast.
    )


