#!/bin/bash
screen -dmS server java -jar server-release.jar

echo "Server started in screen session 'server'. Keeping container alive..."
tail -f /dev/null
