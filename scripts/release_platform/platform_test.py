import platform_serial
import time

ps = platform_serial.platform_serial('/dev/ttyUSB0', debug=True)

while 1:
    print("Open")
    ps.open()
    time.sleep(2)

    print("Close")
    ps.close()
    time.sleep(2)
