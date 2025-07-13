FROM alpine:latest

WORKDIR /opt/qBittorrentee

ARG S6_OVERLAY_VERSION="v3.2.1.0"
ARG VERSION="release-5.1.2.10"
ARG TARGETPLATFORM
COPY qBittorrent.conf /opt/qBittorrentee/qBittorrnet/config/qBittorrent.conf
COPY root /

RUN apk add --no-cache curl \
    && addgroup -S docker \
    && adduser -S -G docker -s /bin/false docker \
    && curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz | tar -C / -Jxpf - \
    && curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-symlinks-noarch.tar.xz | tar -C / -Jxpf - \
    && curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-symlinks-arch.tar.xz | tar -C / -Jxpf - \
    && case "${TARGETPLATFORM}" in \
        "linux/amd64") \
          curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz | tar -C / -Jxpf -; \
          curl -sSL https://github.com/c0re100/qBittorrent-Enhanced-Edition/releases/download/${VERSION}/qbittorrent-enhanced-nox_x86_64-linux-musl_static.zip -o /tmp/1.zip && unzip /tmp/1.zip -d /opt/qBittorrentee;; \
        "linux/arm64") \
          curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-aarch64.tar.xz | tar -C / -Jxpf -; \
          curl -sSL https://github.com/c0re100/qBittorrent-Enhanced-Edition/releases/download/${VERSION}/qbittorrent-enhanced-nox_aarch64-linux-musl_static.zip -o /tmp/1.zip && unzip /tmp/1.zip -d /opt/qBittorrentee;; \
        *) \
          echo "不支持的CPU架构"; \
          exit 1;; \
      esac \
    && apk del curl \
    && rm -rf /var/cache/apk/* /tmp/1.zip \
    && mkdir -p /opt/downloads \
    && chmod +x /opt/qBittorrentee/qbittorrent-nox \
    && chown -R docker:docker /opt

VOLUME /opt/downloads
EXPOSE 8080 6881 6881/udp
ENTRYPOINT ["/init"]
