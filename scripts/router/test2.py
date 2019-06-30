import pyttsx3
from dronekit import connect
import math
import time


help(connect)

v = connect("127.0.0.1:11000")
v = connect("10.42.0.1:11000")
v.close()
v.initialize()

v.parameters.__dict__

v.last_heartbeat
v.channels


i = list(range(1, 18))
i

v.initialize()
v.channels


v.outputs

v.outputs[2]
v.outputs[1]

help(v)
v.channels.overrides[1] = 1300

v.mode.name
v.
v.channels

help(v)
