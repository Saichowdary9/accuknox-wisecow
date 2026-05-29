#!/bin/bash

URL=$1

if [ -z "$URL" ]; then
    echo "Usage: ./health_check.sh <URL>"
    exit 1
fi

STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL")

if [ "$STATUS" -eq 200 ]; then
    echo "Application Status: UP"
else
    echo "Application Status: DOWN"
fi

echo "HTTP Status Code: $STATUS"