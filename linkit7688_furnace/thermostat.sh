#!/bin/sh
io=0

cd /root/

echo "Waiting for IP" > state.txt

while [ true ]
do
  ping 192.168.1.92 -c1
  if [ $? -eq 0 ]
  then
    break
  fi
done

echo "Starting" > state.txt

echo $io > /sys/class/gpio/export

echo out > /sys/class/gpio/gpio$io/direction 

echo 1 > /sys/class/gpio/gpio$io/value

state=0
while [ true ]
do
  sleep 1

  #degF=`ssh -i/root/sshkey pi@192.168.1.92 "/home/pi/printtemp.py"` 2> error.log
  degF=`wget 192.168.1.92:8080/cgi-bin/printtemp -O - 2> error.log`
  degF=`echo $degF | tr -d $'\r'`

  lowT=`cat temp_low.txt | tr -d $'\r'`
  higT=`cat temp_high.txt | tr -d $'\r'`
  echo $degF > temp.txt

  s=`echo "$degF < 5" | bc -l`

  if [ "$degF" == "" ]
  then
    state=0
  elif [ $s -eq 1 ]
  then
    state=0
  elif [ $state -eq 1 ]
  then
    s=`echo "$degF > $higT" | bc -l`
    if [ $s -eq 1 ]
    then
        state=0
    fi
  else # Currently Off
    s=`echo "$degF <= $lowT" | bc -l`
    if [ $s -eq 1 ]
    then
        state=1
    fi
  fi

  if [ -e /root/e_on ]
  then
    state=1 # Force on
  fi

  if [ -e /root/e_off ]
  then
    state=0 # Force off
  fi

  if [ $state -eq 1 ]
  then
    echo 0 > /sys/class/gpio/gpio$io/value
  else
    echo 1 > /sys/class/gpio/gpio$io/value
  fi

  echo $degF $lowT $higT $state > state.txt
done

