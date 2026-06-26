#!/bin/bash

DATE=$(date '+%y-%m-%d :%H:%M:S')
HOSTNAME=$(hostname)

echo "======================================="
echo "=======Server Health Report============"
echo "=======Generated on: $DATE============="
echo "=======Server : $HOSTNAME=============="
echo "======================================="

#S3_BUCKET="s3://mainak-devops-bucket-2026/health-reports"
REPORT_FILE="/tmp/health_report_$(date '+%y%m%d_%H%M%S').txt"
DISC_THRESOLD=80

##CPU USAGE
CPU_USAGE=$(top -bn1|grep "Cpu(s)"| awk '{print $2}'| cut -d '%' -f1)
echo ""
echo "Cpu Usage : $CPU_USAGE%"

##RAM USAGE
TOTAL_RAM=$(free -m | awk 'NR==2{print $2}')
USED_RAM=$(free -m| awk 'NR==2{print $3}')
RAM_PERCENT=$(echo "scale=2; $USED_RAM * 100 / $TOTAL_RAM" | bc)
echo "RAM Usage: ${USED_RAM}MB / ${TOTAL_RAM}MB (${RAM_PERCENT}%)"

##DISC USAGE
DISC_USAGE=$(df -h /| awk 'NR==2{print $5}'| cut -d "%" -f1)
DISC_AVAILABLE=$(df -h /|awk 'NR==2{print $4}')
echo "Disc Usage: ${DISC_USAGE}% (${DISC_AVAILABLE} is available)"

##PROCESS COUNT
PROCESS_COUNT=$(ps aux|wc -l)
echo "Running Process: $PROCESS_COUNT"

##UPTIME
UPTIME=$(uptime -p)
echo "Uptime: $UPTIME"

echo ""
echo "==========================================="
##DISC ALERT

if [ "$DISC_USAGE" -gt "$DISC_THRESOLD" ]; then
	echo "ALERT! Disc usage above $DISC_THRESOLD"
else
	echo "USAGE is normal"
fi

echo "============================================="
	


