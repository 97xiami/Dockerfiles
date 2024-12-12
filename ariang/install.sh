#!/bin/bash

#Download Files
echo "Downloading : AriaNg.zip"
URL=$(curl -s "https://api.github.com/repos/mayswind/AriaNg/releases/latest" | grep "browser_download_url" | grep -E "AriaNg-[0-9]+\.[0-9]+\.[0-9]+\.zip" | cut -d '"' -f 4)

if [ -z "$URL" ]; then
  echo "Failed to find the download."
  exit 1
fi

curl -L -o AriaNg.zip $URL || { echo "Failed to download the file."; exit 1; }

echo "Download completed."
unzip AriaNg.zip -d ${PWD}
rm AriaNg.zip
