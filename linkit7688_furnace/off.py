#!/usr/bin/env python

import mraa

x = mraa.Gpio(20)
x.dir(mraa.DIR_OUT)
x.write(0)

x = mraa.Gpio(21)   
x.dir(mraa.DIR_OUT)                                                     
x.write(0)

