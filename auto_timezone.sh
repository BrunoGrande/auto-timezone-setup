#!/bin/bash

# Get the public IP address
IP=$(curl -s ifconfig.me)

# Query the ip-api API to get the timezone
TIMEZONE=$(curl -s "http://ip-api.com/json/$IP" | jq -r '.timezone')

# Check if the timezone was successfully obtained
if [[ "$TIMEZONE" != "null" && "$TIMEZONE" != "" ]]; then
    echo "Detected timezone: $TIMEZONE"
    timedatectl set-timezone "$TIMEZONE"
else
    echo "Could not detect the timezone. API response: $TIMEZONE"
fi
