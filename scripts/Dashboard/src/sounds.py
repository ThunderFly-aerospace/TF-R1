
import queue
import threading
import time

from kivy.core.audio import SoundLoader
import pyttsx3

class sounds (threading.Thread):
    def __init__(self, data_queue):
        threading.Thread.__init__(self)
        self.daemon = True
        self.q = data_queue

        self.tts = pyttsx3.init()
        self.sound_ping = SoundLoader.load('media/sounds/short-ping.wav')
        self.sound_discon = SoundLoader.load('media/sounds/disconnected-02.wav')
        self.sound_pop = SoundLoader.load('media/sounds/pop.wav')

    def run(self):
        print("START sounds thread")
        self.run = True
        while self.run:
            try:
                data = self.q.get(True, 1)
                type = data.get('type', 'tts')
                if type == 'tts':
                    self.tts.say("{}".format(data.get('data', 'Missing value')))
                    self.tts.runAndWait()

                elif type == 'play':
                    value = data['data']
                    if value == 'ping':
                        self.sound_ping.play()
                    elif value == 'pop':
                        self.sound_pop.play()
                    elif value == 'discon':
                        self.sound_discon.play()

                print("SOUND DATA: ", data)
            except Exception as e:
                pass

        print("Sounds ukoncen")

    def stop(self):
        print("Ukoncuji sound vlakno")
        self.run = False
