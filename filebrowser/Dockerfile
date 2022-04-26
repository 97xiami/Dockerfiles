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
WORKDIR /filebrowser
COPY --from=builder /root/filebrowser/filebrowser ./filebrowser
RUN set -xe \
    && ./filebrowser -d ./filebrowser.db config init \
    && ./filebrowser -d ./filebrowser.db config set --address 0.0.0.0 \
    && ./filebrowser -d ./filebrowser.db config set --port 80 \
    && ./filebrowser -d ./filebrowser.db config set --locale zh-cn \
    && ./filebrowser -d ./filebrowser.db config set --log /filebrowser/log \
    && ./filebrowser -d ./filebrowser.db config set --root /mnt/data \
    && ./filebrowser -d ./filebrowser.db config set --branding.name filebrowser \
    && ./filebrowser -d ./filebrowser.db users add admin password --perm.admin \
    && ./filebrowser -d ./filebrowser.db config set --auth.method=noauth
CMD ["./filebrowser", "-d", "./filebrowser.db"]
