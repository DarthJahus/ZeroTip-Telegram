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
git clone https://github.com/DarthJahus/ioctip-telegram
mv config.json /zero/ioctip-telegram/

# start daemon service
cd /zero/ioctip-telegram/.res
cp ./zerod.service /lib/systemd/system/zerod.service
chmod 644 /lib/systemd/system/zerod.service
systemctl daemon-reload
systemctl enable zerod.service
systemctl start zerod.service
systemctl status zerod.service

# Start bot service
cd /zero/ioctip-telegram/
cp ./ioctip.service /lib/systemd/system/zerod.service
chmod 644 /lib/systemd/system/ioctip.service
systemctl daemon-reload
systemctl enable ioctip.service
systemctl start ioctip.service
systemctl status ioctip.service
