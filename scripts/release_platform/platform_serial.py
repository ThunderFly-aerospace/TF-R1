import serial
import time


class platform_serial():
    def __init__(self, serial_port, debug=False):
        self.ser = serial.Serial(serial_port, timeout=0)
        self.debug = debug

        self.lock_status = -1
        self.actuator_status = -1
        self.ready_btn = -1
        self.service_btn = -1
        self.last_status_update = 0

    def update(self):
        try:
            s = self.ser.read(500)
            s = s.split('\n')

            for message in s:
                if '$S;' in message:
                    parts = message.split(";")
                    self.service_btn = int(parts[2])
                    self.ready_bts = int(parts[3])
                    self.lock_status  = int(parts[4])
                    self.actuator_status =  float(parts[5])
                    self.last_status_update = time.time.now()
        except Exception as e:
            print("Chyba prijmu dat", e)

    def open(self):
        self.write(b"$O;0;0;\n")

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
