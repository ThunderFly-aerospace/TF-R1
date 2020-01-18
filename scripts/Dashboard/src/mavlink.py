from dronekit import connect

import queue
import threading
import time

from kivy.logger import Logger


class mavlink (threading.Thread):
    def __init__(self, data_queue, sound):
        threading.Thread.__init__(self)
        self.daemon = True
        self.q = data_queue
        self.q_sound = sound
        self.connected = False

    def run(self):
        print("START mavlink thread")
        if not self.connected:
            self.connect()

        print("starting loop")
        self.run = True
        self.q.put('vehicle', self.vehicle)

        last_disconected = time.time()
        while self.run:
            time.sleep(0.1)
            #print("Attitude: %s" % self.vehicle.attitude)
            print(self.vehicle.last_heartbeat)
            self.q.put('attitude', self.vehicle.attitude)
            self.q.put('arm', self.vehicle.armed)
            self.q.put('airspeed', self.vehicle.airspeed)
            self.q.put('groundspeed', self.vehicle.groundspeed)
            self.q.put('vehicle', self.vehicle)

            if self.vehicle.last_heartbeat > 3:
                if self.connected:
                    self.alert("No data")
                    self.connected = False
                    next_no_data_alert = self.vehicle.last_heartbeat + 2
                    self.q.put('connected', False)

                if next_no_data_alert < time.time():
                    next_no_data_alert = time.time() + 2
                    self.q_sound.put({'type':'play', 'data': "discon"})
                    self.q.put('connected', False)
            else:
                if not self.connected:
                    self.alert("Renewed")
                    self.q.put('connected', True)
                self.connected = True

    def connect(self):
        try:
            self.vehicle = connect("0.0.0.0:11000", status_printer = self.alert, wait_ready=True, timeout = 5, heartbeat_timeout = None, source_system = 56)
            #self.vehicle.wait_ready(True, raise_exception=False)
            self.vehicle.initialize()
        except Exception as e:
            print("ERRROR>>>", e)

        self.vehicle_connected = True
        self.q_sound.put({'type':'tts', 'data': "connected"})
        self.print_info()
        Logger.info('Connected to vehicle')

    def print_info(self):
        print("Autopilot Firmware version: %s" % self.vehicle.version)
        print("Autopilot capabilities (supports ftp): %s" % self.vehicle.capabilities.ftp)
        print("Global Location: %s" % self.vehicle.location.global_frame)
        print("Global Location (relative altitude): %s" % self.vehicle.location.global_relative_frame)
        print("Local Location: %s" % self.vehicle.location.local_frame)    #NED
        print("Attitude: %s" % self.vehicle.attitude)
        print("Velocity: %s" % self.vehicle.velocity)
        print("GPS: %s" % self.vehicle.gps_0)
        print("Groundspeed: %s" % self.vehicle.groundspeed)
        print("Airspeed: %s" % self.vehicle.airspeed)
        print("Gimbal status: %s" % self.vehicle.gimbal)
        print("Battery: %s" % self.vehicle.battery)
        print("EKF OK?: %s" % self.vehicle.ekf_ok)
        print("Last Heartbeat: %s" % self.vehicle.last_heartbeat)
        print("Rangefinder: %s" % self.vehicle.rangefinder)
        print("Rangefinder distance: %s" % self.vehicle.rangefinder.distance)
        print("Rangefinder voltage: %s" % self.vehicle.rangefinder.voltage)
        print("Heading: %s" % self.vehicle.heading)
        print("Is Armable?: %s" % self.vehicle.is_armable)
        print("System status: %s" % self.vehicle.system_status.state)
        print("Mode: %s" % self.vehicle.mode.name)    # settable
        print("Armed: %s" % self.vehicle.armed)    # settable

    def alert(self, msg):
        print("ALERT::", msg)
        self.q_sound.put({'type':'tts', 'data': msg})

    def stop(self):
        print("Ukoncuji mavlink vlakno")
        self.run = False
