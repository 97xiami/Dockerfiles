FROM alpine:latest AS builder
WORKDIR /build
RUN apk update \
    && apk add --no-cache git make build-base pkgconf qt5-qtbase-dev \
    && git clone --single-branch https://github.com/c0re100/qBittorrent-Enhanced-Edition \
    && cd qBittorrent-Enhanced-Edition \
    && ./configure --disable-gui --disable-debug \
    && make \
    && chmod +x qbittorrent-nox

FROM alpine:latest
COPY --from=builder /build/qBittorrent-Enhanced-Edition/qbittorrent-nox /usr/bin/qbittorrent-nox
ENV QBT_WEBUI_PORT=8080
EXPOSE 16888/tcp 16888/udp 8080/tcp
VOLUME [/qbittorrent /downloads]
ENTRYPOINT ["qbittorrent-nox"]