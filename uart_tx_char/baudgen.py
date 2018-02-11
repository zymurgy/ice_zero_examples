def divisor(baudrate):
    """Calculate the divisor for generating a given baudrate"""
    CLOCK_HZ = 100000000     #--- Change it to fit your board system clock frequency
    return round(CLOCK_HZ / baudrate)

if __name__ == "__main__":

    # -- List with the standard baudrates
    baudrates = [115200, 57600, 38400, 19200, 9600, 4800, 2400, 1200, 600, 300]

    # -- Calcultate their divisors when using a frequency of CLOCK_HZ
    for baudrate in baudrates:
        print("`define B{} {}".format(baudrate, divisor(baudrate)))
