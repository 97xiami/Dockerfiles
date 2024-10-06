FROM alpine:latest AS builder
WORKDIR /qbittorrentee

COPY install.sh /qbittorrentee/

RUN apk update \
    && apk add --no-cache ca-certificates curl bash \
    && cd /qbittorrentee \
    && chmod a+x install.sh \
    && bash install.sh

FROM alpine:latest
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY qBittorrent.conf /usr/local/qbittorrent/defaults/qBittorrent.conf
COPY --from=builder /qbittorrentee/qbittorrent-nox /usr/local/bin/qbittorrent-nox
ENV WEBUIPORT=8080
VOLUME /downloads /config
EXPOSE 8080 6881 6881/udp

RUN apk add --no-cache bash \
    && chmod +x docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
