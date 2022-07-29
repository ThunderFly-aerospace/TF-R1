from pymavlink import mavutil
import platform_serial
#import beepy
import serial
import time


class PeriodicTimer():
    def __init__(self, function, duration=1, args={}):
        self.duration = duration
        self.function = function
        self.run()

    def run(self):
        self.last_run = time.time()
        return self.function()

    def update(self):
        if time.time() > self.last_run+self.duration:
            return self.run()
        return False


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

def send_hb():
    mavlink.mav.heartbeat_send(mavutil.mavlink.MAV_TYPE_GENERIC, # type
                               mavutil.mavlink.MAV_AUTOPILOT_INVALID, #autopilot
                               1, # base_mode
                               mavutil.mavlink.MAV_STATE_ACTIVE, #custom mode
                               0 # system status
                               )
    print("Send HB")

def send_val(name = "lock", val = 0):
    mavlink.mav.named_value_int_send(0, #time from boot
        bytes(name, 'utf-8'), val)


def callback_funct(status):
    send_val(val=status)

mavlink = mavutil.mavlink_connection('udpin:0.0.0.0:14552', source_system=67)
#mavlink = mavutil.mavlink_connection('udpin:0.0.0.0:14555', source_system=67)

ps = platform_serial.platform_serial('/dev/ttyUSB1', debug=True)
ps.set_status_callback(callback_funct)

print("Script started, waiting to mavlink heartbeat")
mavlink.wait_heartbeat()
request_message_interval(mavutil.mavlink.MAVLINK_MSG_ID_DEBUG, 5)
print(mavutil.mavlink.MAV_AUTOPILOT_GENERIC)

send_hb()
hb_timer = PeriodicTimer(send_hb, 1)
print("Heartbeat from system (system %u component %u)" % (mavlink.target_system, mavlink.target_component))

last_state = -1

platform_state = 0

autogyro_armed = 0
autogyro_armed_last = 0

while 1:
    hb_timer.update()
    ps.update()

    msg = mavlink.recv_match(blocking=False)
    if not msg:
        continue
        pass

    if msg.get_type() == 'HEARTBEAT' and msg.get_srcSystem() == 1:
        print("heartbeat recieved")
        autogyro_armed = (msg.base_mode & mavutil.mavlink.MAV_MODE_FLAG_SAFETY_ARMED)
        print(bin(msg.base_mode))
        print("Autogyro armed?", autogyro_armed)
        if autogyro_armed != autogyro_armed_last:
            autogyro_armed_last = autogyro_armed

            if autogyro_armed:
                print("Odemykam platformu")
                ps.unlock()
            else:
                print("Zamykam platformu")
                ps.lock()

    if msg.get_type() == 'DEBUG':
        dic = msg.to_dict()
        dic['msgid'] = msg.get_msgId()
        dic['sysid'] = msg.get_srcSystem()
        dic['compid'] = msg.get_srcComponent()
        print("DEBUG", dic, msg)
#        if dic['ind'] == 0:
        new_state = float(dic['value'])
        print(new_state)

        if last_state != new_state:
            print("CHANGE")

        if new_state > 2.5:
            if platform_state != 1:
                platform_state = 1
#                time.sleep(1.5)
                ps.open(10)
                print("RELEASE")
            print("Release again")
        else:
            if platform_state:
                platform_state = 0
                print("Reset stavu zamku")

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


