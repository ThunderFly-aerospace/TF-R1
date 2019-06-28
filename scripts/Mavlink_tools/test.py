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
                roll = self.vehicle.attitude.roll
                roll = math.degrees(roll)
                roll = round(roll, 1)
                print("Roll: {}".format(roll))
                self.tts.say("{}".format(roll))
                self.tts.runAndWait()
                time.sleep(2)
            except Exception as e:
                print(e)

    def connect(self):
        self.vehicle = connect("127.0.0.1:11000")
        self.tts = pyttsx3.init()



aspd_r = aspd_reader()
