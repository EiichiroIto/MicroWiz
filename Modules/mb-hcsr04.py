# author Eiichiro Ito github.com/EiichiroIto
# License MIT License

import utime

class HCSR04:
    def __init__(self, trigger, echo):
        self.trigger = trigger
        self.echo = echo
    def _usec_getecho(self):
        count = 0
        self.trigger.write_digital(1)
        self.trigger.write_digital(0)
        while self.echo.read_digital() == 0:
            utime.sleep_us(1)
            count += 1
            if count > 1000:
                return 0
        t1 = utime.ticks_us()
        count = 0
        while self.echo.read_digital() > 0:
            utime.sleep_us(1)
            count += 1
            if count > 1000:
                return 0
        t2 = utime.ticks_us()
        return utime.ticks_diff(t2, t1)
    def distance(self):
        t = self._usec_getecho()
        return int(340.0 * t / 20000)
