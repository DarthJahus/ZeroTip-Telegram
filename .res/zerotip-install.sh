#!/usr/bin/env bash
# Used on Ubuntu 16.04.6 LTS (xenial)
# assuming that /zero exists and contains:
# * zero.conf
# * zerod (daemon, binary)
# * config.json
# * this script

# Prepare daemon
mkdir /zero/daemon
mkdir /zero/data
mv zero.conf /zero/data/zero.conf
mv zerod /zero/daemon/zerod

# Download the bot
cd /zero
git clone https://github.com/DarthJahus/zerotip-telegram
mv config.json /zero/zerotip-telegram/

# start daemon service
cd /zero/zerotip-telegram/.res
cp ./zerod.service /lib/systemd/system/zerod.service
chmod 644 /lib/systemd/system/zerod.service
systemctl daemon-reload
systemctl enable zerod.service
systemctl start zerod.service
systemctl status zerod.service

# Start bot service
cd /zero/zerotip-telegram/
cp ./zerotip.service /lib/systemd/system/zerotip.service
chmod 644 /lib/systemd/system/zerotip.service
systemctl daemon-reload
systemctl enable zerotip.service
systemctl start zerotip.service
systemctl status zerotip.service
