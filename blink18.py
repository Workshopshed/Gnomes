#!/usr/bin/env python
#Simply tries to switch Pin 12 on for 1 sec and off for 2 secs
#V0.2 26Aug12

# Must be run as root - sudo python blink11.py 

import time, RPi.GPIO as GPIO

GPIO.setmode(GPIO.BOARD)
GPIO.setup(12, GPIO.OUT)

while True:
	LEDon = GPIO.output(12, 0)
	time.sleep(1)
	LEDoff = GPIO.output(12, 1)
	time.sleep(2)

