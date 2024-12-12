#!/bin/bash

#Download Files
echo "Downloading : AriaNG.zip"
URL=$(curl -s "https://api.github.com/repos/mayswind/AriaNg/releases/latest" | grep "browser_download_url" | grep -E "AriaNG-[0-9]+\.[0-9]+\.[0-9]+\.zip" | cut -d '"' -f 4)

if [ -z "$URL" ]; then
  echo "Failed to find the download."
  exit 1
fi

curl -L -o AriaNG.ZIP $URL || { echo "Failed to download the file."; exit 1; }

echo "Download completed."
unzip AriaNG.ZIP -d ${PWD}
rm AriaNG.zip
