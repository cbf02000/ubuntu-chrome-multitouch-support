#!/bin/bash

set -e

# Check Root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 1>&2
    exit 1
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

# Get Device and Initiate Supervisor
DEVICE=`python GetInput.py`

cat ./supervisor-conf-template.txt |  sed -e "s,{{{ device_id }}},$DEVICE,g" > /etc/supervisor/conf.d/multitouch-support.conf
mkdir -p /var/log/multitouch-support
supervisorctl update

cp ./disable-mouse-emulation /usr/local/bin/.
cp ./x-startup-script.desktop /etc/xdg/autostart/.

sudo reboot
