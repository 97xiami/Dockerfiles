#!/bin/bash

# Check CPU architecture
ARCH=$(uname -m)

echo "Check CPU architecture ..."
if [[ ${ARCH}  == "x86_64" ]]; then
  FILENAME="qbittorrent-enhanced-nox_x86_64-linux-musl_static.zip"
elif [[ ${ARCH}  == "aarch64" ]]; then
  FILENAME="qbittorrent-enhanced-nox_aarch64-linux-musl_static.zip"
else
  echo "Unsupported architecture: ${ARCH}"
  exit 1
fi

#Download Files
echo "Downloading binary file for architecture: ${ARCH}"
URL=$(curl -s "https://api.github.com/repos/c0re100/qBittorrent-Enhanced-Edition/releases/latest" | grep "browser_download_url" | grep ${FILENAME} | cut -d '"' -f 4)

if [ -z "$URL" ]; then
  echo "Failed to find the download URL for ${FILENAME}."
  exit 1
fi

curl -L -o ${FILENAME} $URL || { echo "Failed to download the file."; exit 1; }

echo "Download completed."
unzip ${FILENAME} -d ${PWD}
chmod +x qbittorrent-nox
