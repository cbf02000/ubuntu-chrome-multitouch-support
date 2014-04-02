#!/bin/bash

set -e

# Check Root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

PROCESS=$(ps aux | grep 'supervisord' | grep -v grep | awk '{print $2}')
if [[ ! -z $PROCESS ]]; then
    kill $PROCESS
fi

PROCESS=$(ps aux | grep 'mtdev2tuio' | grep -v grep | awk '{print $2}')
if [[ ! -z $PROCESS ]]; then
    kill $PROCESS
fi

PROCESS=$(ps aux | grep 'node' | grep -v grep | awk '{print $2}')
if [[ ! -z $PROCESS ]]; then
    kill $PROCESS
fi

# Uninstall Caress Server
rm -rf /usr/local/caress-server

# Uninstall Mouse Emulation Disabler
rm -rf /usr/local/bin/disable-mouse-emulation

# Uninstall Device ID Extractor
rm -rf /usr/local/bin/get-touch-device-id

# Remove from Supervisor
rm -rf /etc/supervisor/conf.d/multitouch-support.conf
service supervisor start
supervisorctl update

# Copy Disabler Configuration in Autostart Apps
rm -rf /etc/xdg/autostart/x-startup-script.desktop

sudo reboot
