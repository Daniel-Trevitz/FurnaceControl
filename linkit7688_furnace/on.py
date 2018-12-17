#!/usr/bin/env python

import mraa

x = mraa.Gpio(0)
x.dir(mraa.DIR_OUT)
x.write(1)

x = mraa.Gpio(1)                                                        
x.dir(mraa.DIR_OUT)                                                     
x.write(1)

while True :
  x.write(1)
