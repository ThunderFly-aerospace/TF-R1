import platform_serial
import time

ps = platform_serial.platform_serial('/dev/ttyUSB0', debug=True)

while 1:
    print("Open")
    ps.open(timeout = 10)
    time.sleep(5)

    print("Close")
    ps.close()
    time.sleep(5)
