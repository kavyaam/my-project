#!/bin/bash
usage=$(uptime|cut -d "," -f4|sed -e "s/\.//g")
threshold=6
while [ 1 ]
do
if [ $usage -gt $threshold ]
then
echo PID %cpu COMMAND
echo $( ps -eo pid -eo pcpu -eo cmd|sort -k 2 rn|head -n 1 )
echo usage greater than threshold
echo kill the above process y\/n
read opt
if [ opt="y" ]
then
echo check
tukill -9 $(ps -eo pid -eo pcpu|grep -v %cpu|sort -k 2 -rn|head -n 1 |cut -d " " -f2)
echo after killing
else
echo no killing 
fi
fi
sleep 6
done
