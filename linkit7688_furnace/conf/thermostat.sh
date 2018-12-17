#!/bin/sh /etc/rc.common

START=99
STOP=15

start() {
        uhttpd -h /root/ -p 8080
        sh /root/thermostat.sh &
}
