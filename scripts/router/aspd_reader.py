import pyttsx3
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
                #airspeed = self.vehicle.attitude.roll
                #airspeed = math.degrees(airspeed)

                airspeed = self.airspeed
                airspeed = round(airspeed, 1)

                print("Aspd: {}".format(airspeed))
                self.tts.say("{}".format(airspeed))
                self.tts.runAndWait()
                time.sleep(2)
            except Exception as e:
                print(e)

    def connect(self):
        self.vehicle = connect("127.0.0.1:11000")
        self.tts = pyttsx3.init()



aspd_r = aspd_reader()
