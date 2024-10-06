#!/bin/bash
set -e

if [ ! -f "/config/qBittorrent/config/qBittorrent.conf" ]; then
    mkdir -p /config/qBittorrent/config/
    cp /usr/local/qbittorrent/defaults/qBittorrent.conf /config/qBittorrent/config/qBittorrent.conf
fi

if [ $# -eq 0 ]; then
    qbittorrent-nox --webui-port="$WEBUIPORT" --profile=/config
else
    exec "$@"
fi
