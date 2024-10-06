docker-compose.yml
```yml
services:
  frps:
    image: xiami110/frps
    container_name: frps
    restart: always
    ports:
      - 7000:7000
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - $PWD/frp/frps.toml:/etc/frp/frps.toml
```
