docker-compose.yml
```yml
services:
  samba:
    image: xiami110/samba
    container_name: samba
    restart: always
    ports:
      - 137-139:137-139
      - 445:445
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - $PWD:/share
```
