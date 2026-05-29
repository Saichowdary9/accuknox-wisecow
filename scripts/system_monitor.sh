#!/bin/bash

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
MEM=$(free | awk '/Mem:/ {printf("%.2f"), $3/$2 * 100}')
DISK=$(df / | awk 'END {print $5}' | sed 's/%//')

echo "===== System Health Report ====="
echo "CPU Usage: $CPU%"
echo "Memory Usage: $MEM%"
echo "Disk Usage: $DISK%"

if (( $(echo "$CPU > 80" | bc -l) )); then
    echo "ALERT: CPU usage above 80%"
fi

if (( $(echo "$MEM > 80" | bc -l) )); then
    echo "ALERT: Memory usage above 80%"
fi

if [ "$DISK" -gt 80 ]; then
    echo "ALERT: Disk usage above 80%"
fi

echo ""
echo "Top 5 CPU Consuming Processes:"
ps aux --sort=-%cpu | head -6