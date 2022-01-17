from dronekit import connect
import math
import time

class aspd_reader():
    def __init__(self):
        self.connect()
        self.start()

    def start(self):
        while True:
            try:
                #print(self.vehicle.system_status())
                a_location = LocationGlobal(50.16008, 14.44573, 50)
                self.vehicle.simple_goto(a_location)
                print("simple")
            except Exception as e:
                print(e)

    def connect(self):
        self.vehicle = connect("127.0.0.1:14550", wait_ready=['system_status','mode'])
        print("Ready")



aspd_r = aspd_reader()
