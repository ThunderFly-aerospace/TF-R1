import serial
import time


class platform_serial():
    def __init__(self, serial_port, debug=False):
        self.ser = serial.Serial(serial_port, timeout=0, baudrate=115200)
        self.debug = debug

        self.lock_status = -1
        self.actuator_status = -1
        self.ready_btn = -1
        self.service_btn = -1
        self.last_status_update = 0

    def update(self):
        try:
            if self.ser.in_waiting > 0:
                s = self.ser.read(self.ser.in_waiting).decode(encoding="utf-8")
                if len(s):
                    s = s.split('\n')

                    for message in s:
                        if '$S;' in message:
                            parts = message.split(";")
                            self.service_btn = int(parts[2])
                            self.ready_bts = int(parts[3])
                            self.lock_status  = int(parts[4])
                            self.actuator_status =  float(parts[5])
                            #self.last_status_update = time.time.now()
                        if self.debug:
                            print(repr(message))
        except Exception as e:
            print("Chyba prijmu dat", e)

    def open(self, timeout = 10):
        time.sleep(1)
        string = "$O;"+str(int(timeout))+";0;\n"
        self.write(bytes(string, 'utf-8'))

    def close(self):
        self.write(b"$C;\n")

    def block(self):
        self.write(b"$BL;\n")

    def unblock(self):
        self.write(b"$UL;\n")

    def write(self, data):
        if self.debug:
            print("Serial>> ", data.decode("utf-8"))
        self.ser.write(data)
