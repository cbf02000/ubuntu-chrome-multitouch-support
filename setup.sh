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

# Install Dependencies
add-apt-repository ppa:chris-lea/node.js
apt-get update
apt-get install g++ supervisor input-utils mtdev-tools libmtdev-dev liblo-dev nodejs

# Install TUIO Server
cd tuio-server
make clean
make
make install
cd ..

# Install Caress Server
cp -r ./caress-server /usr/local/.

# Install Mouse Emulation Disabler
cp ./disable-mouse-emulation /usr/local/bin/.

# Install Device ID Extractor
cp ./get-touch-device-id /usr/local/bin/.

# Get Device and Initiate Supervisor
cp ./supervisor-multitouch-support.conf /etc/supervisor/conf.d/multitouch-support.conf
mkdir -p /var/log/multitouch-support
service supervisor start
supervisorctl update

# Copy Disabler Configuration in Autostart Apps
cp ./x-startup-script.desktop /etc/xdg/autostart/.

sudo reboot
