#!/bin/bash
screen -dmS server java -jar server-release.jar

echo "Server started in screen session 'server'. Keeping container alive..."
echo "运行docker exec -it 容器名称 screen -r server进入"
tail -f /dev/null
