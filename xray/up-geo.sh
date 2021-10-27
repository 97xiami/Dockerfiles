#!/usr/bin/bash

IP="https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geoip.dat"
SITE="https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geosite.dat"

rm -rf /usr/share/xray/geo*.dat

wget -O /usr/share/xray/geoip.dat $IP
wget -O /usr/share/xray/geosite.dat $SITE

sleep 1

killall -9 xray
