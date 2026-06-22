#!/bin/bash

# Run health check and save output to file
REPORT_FILE="/tmp/health_report_$(date '+%Y%m%d_%H%M%S').txt"
~/scripts/health_check.sh > $REPORT_FILE

echo "✅ Health check complete — uploading to S3..."

# Upload to S3
aws s3 cp $REPORT_FILE s3://mainak-devops-bucket-2026/health-reports/

echo "✅ Report uploaded!"

# List all reports in S3
echo "📋 All reports in S3:"
aws s3 ls s3://mainak-devops-bucket-2026/health-reports/
