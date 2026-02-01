#!/bin/bash

i3status | while :
do
     line=$(bash ~/.config/i3/i3status.sh)
    vpn_status=$(bash /etc/vpn-config/i3status-server.sh)  # Call your VPN script
    echo "$vpn_status |$line" || exit 1
    sleep 1
done

