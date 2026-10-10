#!/bin/bash

THRESHOLD=80
MEMORY_THRESHOLD=80
EXIT_CODE=0

# Create the logs directory
mkdir -p logs

# Delete monitoring logs older than 24 hours
find logs/ -type f -name "health-*.log" -mmin +1440 -delete

# Generate a timestamped log filename
LOG_FILE="logs/health-$(date +%Y-%m-%d_%H-%M-%S).log"

# Save output and display it simultaneously
exec > >(tee -a "$LOG_FILE") 2>&1

echo "===== LINUX HEALTH MONITOR ====="
echo "Hostname: $(hostname)"
echo "Date: $(date)"
echo

echo "----- System Uptime -----"
uptime
echo

echo "----- Disk Usage -----"
DISK_USAGE=$(df -P / | awk 'NR==2 {gsub(/%/,"",$5); print $5}')

echo "Disk usage: ${DISK_USAGE}%"

if [ "$DISK_USAGE" -ge "$THRESHOLD" ]; then
    echo "WARNING: Disk usage is high!"
    EXIT_CODE=1
else
    echo "OK: Disk usage is normal."
fi

echo

# Check memory usage
echo "----- Memory Usage -----"
free -h

MEMORY_THRESHOLD=80

MEMORY_USAGE=$(free | awk '/^Mem:/ {
    printf "%.0f", (($2 - $7) / $2) * 100
}')

echo "Memory usage: ${MEMORY_USAGE}%"

if [ "$MEMORY_USAGE" -ge "$MEMORY_THRESHOLD" ]; then
    echo "WARNING: Memory usage is high!"
    EXIT_CODE=1
else
    echo "OK: Memory usage is normal."
fi

echo

echo "----- CPU Information -----"
nproc
echo

echo "----- Top Running Processes -----"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6

echo
echo "===== CHECK COMPLETED ====="
echo "Log saved to: $LOG_FILE"

exit "$EXIT_CODE"
