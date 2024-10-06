docker-compose.yml
```yml
services:
  qbittorrentee:
    image: xiami110/qbittorrentee
    container_name: qbittorrentee
    restart: always
    ports:
      - 6881:6881
      - 6881:6881/udp
      - 8080:8080
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - $PWD/qbittorrentee:/config
      - $PWD/downloads:/downloads
```
