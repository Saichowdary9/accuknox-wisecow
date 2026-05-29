#!/bin/bash

echo "===== System Health Report ====="

echo "CPU Usage:"
top -bn1 | grep "Cpu(s)"

echo ""
echo "Memory Usage:"
free -h

echo ""
echo "Disk Usage:"
df -h /

echo ""
echo "Top 5 Processes:"
ps aux --sort=-%cpu | head -6