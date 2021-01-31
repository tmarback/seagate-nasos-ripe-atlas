#!/bin/bash

set -e # Do not continue if anything fails

echo "Build starting."

BUILD_DIR="/tmp/ripe-atlas"
STORE_DIR="/opt/ripe-atlas"

mkdir -p $BUILD_DIR
mkdir -p $STORE_DIR

cp -r -t $BUILD_DIR /home/source/ripe-atlas-software-probe
echo "Installing dependencies."
if sudo apt update && sudo apt-get install --yes --no-install-recommends tar fakeroot libssl-dev libcap2-bin autoconf automake libtool build-essential openssh-client logrotate; then
	echo "Dependencies installed."
else
	echo "Could not install dependencies."
	exit 1
fi

cd $BUILD_DIR
echo "Building probe."
if ./ripe-atlas-software-probe/build-config/debian/bin/make-deb; then
	echo "Probe build completed."	
else
	echo "Probe build failed."
	exit 2
fi

echo "Installing artifacts."
install -m 755 $BUILD_DIR/atlasswprobe-??????.deb $STORE_DIR/atlasswprobe.deb
install -m 644 /home/source/logrotate.config $STORE_DIR/logrotate.config

echo "Cleaning up."
rm -r $BUILD_DIR

echo "Installing static files."
install -m 755 /home/source/rc.local /etc

install -m 644 /home/source/default.conf.apache_template /etc/default.conf.apache_template
install -m 644 /home/source/ports.conf.apache_template /etc/ports.conf.apache_template
rm -rf /var/www/*
cp -r /home/source/www/* /var/www/
chmod a+r -R /var/www

echo "Build complete."

exit 0
