import serial
import time

def chck(data):
    v = 0
    for i in data[1:]:
        v ^= ord(i) 
    return data+"*{:x}\r\n".format(v)

class platform_serial():
    def __init__(self, serial_port, debug=False):
        self.ser = serial.Serial(serial_port, timeout=0, baudrate=115200)
        self.debug = debug

        self.lock_status = -1
        self.actuator_status = -1
        self.ready_btn = -1
        self.service_btn = -1
        self.last_status_update = 0

        self.callback_f = None

    def set_status_callback(self, funct):
        try:
            self.callback_f  = funct
        except Exception as e:
            print("Err", e)

    def update(self):
        try:
            if self.ser.in_waiting > 0:
                s = self.ser.read(self.ser.in_waiting).decode(encoding="utf-8")
                if len(s):
                    s = s.split('\n')

                    for message in s:
                        if '$PLSTS,' in message and len(message.split('*')[0].split(",")) == 7:
                            parts = message.split('*')[0].split(",")
                            self.service_btn = int(parts[4])
                            self.ready_btn = int(parts[5])
                            self.lock_status  = int(parts[2])
                            self.actuator_status =  float(parts[6])
                            #self.last_status_update = time.time.now()
                            print(self.lock_status, message)
                            if self.callback_f:
                                lock = bool(self.actuator_status > 1300)
                                self.callback_f(int(lock))
                        #if self.debug:
                        #    print(repr(message))
        except Exception as e:
            print("Chyba prijmu dat", e)

    def unlock(self):
        string = chck("$PLBLK,0")
        self.write(bytes(string, 'utf-8'))
    
    def lock(self):
        string = chck("$PLBLK,1")
        self.write(bytes(string, 'utf-8'))


    def open(self, timeout = 10, unlock = 0):

        if unlock:
            self.unlock()
            time.sleep(1)

        string = chck("$PLLCK,0,0,1,{}".format(timeout*1000))
        print(string)
        self.write(bytes(string, 'utf-8'))

    def close(self):
        string = chck("$PLLCK,1,0,0,{}".format(0*0))
        print(">> ", string)
        self.write(bytes(string, 'utf-8'))

    def block(self):
        self.write(b"$BL;\n")

    def unblock(self):
        self.write(b"$UL;\n")

    def write(self, data):
        if self.debug:
            print("Serial>> ", data.decode("utf-8"))
        self.ser.write(data)
