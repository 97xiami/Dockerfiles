docker-compose.yml
```yml
services:
  frpc:
    image: xiami110/frpc
    container_name: frpc
    restart: always
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - $PWD/frp/frpc.toml:/etc/frp/frpc.toml
```
