#!/bin/sh /etc/rc.common

START=99
STOP=15

start() {
        echo "Starting local web server"
        uhttpd -h /root/ -p 8080
        echo "Starting remote web server"
        uhttpd -h /root/ -s 8081 -D -C /root/furnace.crt -K /root/furnace.key -c /root/httpd.conf
        echo "Starting controller"
        sh /root/thermostat.sh &
        echo "Done"
}
