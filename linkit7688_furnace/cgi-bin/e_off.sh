#!/bin/sh
io=0

echo "Content-type: text/plain"
echo ""

echo "Emergency Off"
echo 1 > /sys/class/gpio/gpio$io/value
echo e_off > /root/e_off
