#!/bin/sh
io=1

echo "Content-type: text/plain"
echo ""

echo "Emergency On"
echo 0 > /sys/class/gpio/gpio$io/value
echo e_on > /root/e_on
