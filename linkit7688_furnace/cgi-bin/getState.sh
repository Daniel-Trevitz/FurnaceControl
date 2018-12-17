#!/bin/sh
echo "Content-type: text/plain"
echo ""

echo "state=`cat /sys/class/gpio/gpio0/value`"
echo "onTemp=`cat temp_low.txt`"
echo "offTemp=`cat temp_high.txt`"
echo "temp=`cat temp.txt`"

if [ -e /root/e_on -o -e /root/e_off ]
then
  echo "e_state=1"
else
  echo "e_state=0"
fi

