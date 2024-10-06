#!/bin/bash

# Check CPU architecture
ARCH=$(uname -m)

echo "Check CPU architecture ..."
if [[ ${ARCH}  == "x86_64" ]]; then
  FILENAME="frp_[0-9]+\.[0-9]+\.[0-9]+_linux_amd64\.tar\.gz"
elif [[ ${ARCH}  == "aarch64" ]]; then
  FILENAME="frp_[0-9]+\.[0-9]+\.[0-9]+_linux_arm64\.tar\.gz"
else
  echo "Unsupported architecture: ${ARCH}"
  exit 1
fi

#Download Files
echo "Downloading binary file for architecture: ${ARCH}"

URL=$(curl -s "https://api.github.com/repos/fatedier/frp/releases/latest" | grep "browser_download_url" | grep -E "${FILENAME}" | cut -d '"' -f 4)

if [ -z "${URL}" ]; then
  echo "Failed to find the download URL for ${FILENAME}."
  exit 1
fi

curl -L -o frp.tar.gz ${URL} || { echo "Failed to download the file."; exit 1; }
echo "Download completed."

tar -xzf frp.tar.gz
cp frp_*/frps* .
chmod +x frps
