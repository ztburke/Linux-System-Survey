#!/bin/bash

echo "----- Process Information -----"
echo "Active Processes:"
ps aux

echo "Listening Services:"
ss -tuln

echo "Scheduled Tasks:"
crontab -l

echo "----- Spotting Anomalies -----"
echo "Unusual Services Starting at Boot Time:"
systemctl list-unit-files --state=enabled

echo "Services with Unusual Ownership:"
ps -eo user,comm

echo "Services Starting from Unexpected Locations:"
ls -l /proc/*/exe

echo "Processes with Unusual Arguments:"
ps -eo args

echo "Processes with Abnormal Lineage:"
pstree
