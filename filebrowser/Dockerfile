FROM golang:alpine AS builder
WORKDIR /root
RUN set -xe \
    && apk add git npm \
    && git clone https://github.com/filebrowser/filebrowser \
    && cd filebrowser/frontend \
    && npm install \
    && npm run build \
    && cd ../ \
    && go mod download \
    && go build \
    && chmod +x filebrowser

FROM alpine:latest
MAINTAINER xiami110
WORKDIR /root
COPY --from=builder /root/filebrowser/filebrowser /usr/bin/filebrowser
RUN set -xe \
    && filebrowser -d /root/filebrowser/database.db config init \
    && filebrowser -d /root/filebrowser/database.db config set --address 0.0.0.0 \
    && filebrowser -d /root/filebrowser/database.db config set --port 80 \
    && filebrowser -d /root/filebrowser/database.db config set --locale zh-cn \
    && filebrowser -d /root/filebrowser/database.db config set --log /root/log \
    && filebrowser -d /root/filebrowser/database.db config set --root /mnt/data \
    && filebrowser -d /root/filebrowser/database.db config set --branding.name filebrowser \
    && filebrowser -d /root/filebrowser/database.db users add admin password --perm.admin \
    && filebrowser -d /root/filebrowser/database.db config set --auth.method=noauth
CMD ["filebrowser", "-d", "/root/filebrowser/database.db"]
