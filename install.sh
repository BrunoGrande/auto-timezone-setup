#!/bin/bash

# Install necessary packages
sudo apt update
sudo apt install -y curl jq

# Download the auto_timezone.sh script
sudo curl -sL https://raw.githubusercontent.com/USERNAME/REPOSITORY/main/auto_timezone.sh -o /usr/local/bin/auto_timezone.sh

# Make the script executable
sudo chmod +x /usr/local/bin/auto_timezone.sh

# Create a systemd service
echo "[Unit]
Description=Ajuste automático do fuso horário com base em IP
After=network-online.target
Wants=network-online.target

[Service]
ExecStart=/usr/local/bin/auto_timezone.sh
Type=oneshot
Environment=PATH=/usr/local/bin:/usr/bin:/bin

[Install]
WantedBy=basic.target" | sudo tee /etc/systemd/system/auto_timezone.service > /dev/null

# Reload systemd and enable the service
sudo systemctl daemon-reload
sudo systemctl enable auto_timezone.service
sudo systemctl start auto_timezone.service

echo "Installation complete! The timezone will be automatically set based on your IP."
