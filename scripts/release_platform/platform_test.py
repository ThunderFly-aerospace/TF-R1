import platform_serial
import time

ps = platform_serial.platform_serial('/dev/ttyUSB1', debug=True)

while 1:
    ps.update()
    print("Unlock")
    ps.unlock()
    print("Lze sklopit")
    for x in range(7):
        ps.update()
        time.sleep(1)
    print("Otevrit zamek na 5s")
    ps.open(timeout = 5)
    for x in range(7):
        ps.update()
        time.sleep(1)
    print("Zavrit")
    ps.close()
    time.sleep(5)
    print("Zamknout")
    ps.lock()
    print("Zamknuto")
    time.sleep(5)
    ps.update()
