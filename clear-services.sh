#!/bin/bash

echo "=== Clearing services ==="

SERVICES=(
    tlp
    cryptdisks
    cryptdisks-early
    haveged
)

for service in "${SERVICES[@]}"; do
    if [ -f "/etc/init.d/$service" ]; then
        echo "Clearing $service..."
        sudo update-rc.d "$service" disable
    else
        echo "Service $service does not, skipping..."
    fi
done

echo "Clear finished"
echo "Reboot to apply changes"
