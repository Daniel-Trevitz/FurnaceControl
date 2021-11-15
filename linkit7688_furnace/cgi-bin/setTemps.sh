#!/bin/sh
echo "Content-type: text/plain"
echo ""

echo $QUERY_STRING | awk '{split($0, a, ","); print a[1]}' > /root/temp_high.txt

echo $QUERY_STRING | awk '{split($0, a, ","); print a[2]}' > /root/temp_low.txt

echo $QUERY_STRING | awk '{split($0, a, ","); print a[3]}' > /root/night_temp_high.txt

echo $QUERY_STRING | awk '{split($0, a, ","); print a[4]}' > /root/night_temp_low.txt

