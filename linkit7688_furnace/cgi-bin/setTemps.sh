#!/bin/sh
echo "Content-type: text/plain"
echo ""

echo $QUERY_STRING | awk '{split($0, a, ","); print a[1]}' > /root/temp_high.txt

echo $QUERY_STRING | awk '{split($0, a, ","); print a[2]}' > /root/temp_low.txt

