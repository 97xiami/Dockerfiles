FROM alpine:latest

WORKDIR /opt/openlist

ARG S6_OVERLAY_VERSION="v3.2.1.0"
ARG OPENLIST_VERSION="v4.0.8"
ARG TARGETPLATFORM
RUN apk add --no-cache aria2 curl \
    && addgroup -S docker \
    && adduser -S -G docker -s /bin/false docker \
    && curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz | tar -C / -Jxpf - \
    && curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-symlinks-noarch.tar.xz | tar -C / -Jxpf - \
    && curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-symlinks-arch.tar.xz | tar -C / -Jxpf - \
    && case "${TARGETPLATFORM}" in \
        "linux/amd64") \
          curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz | tar -C / -Jxpf -; \
          curl -sSL https://github.com/OpenListTeam/OpenList/releases/download/${OPENLIST_VERSION}/openlist-linux-musl-amd64.tar.gz | tar -C /opt/openlist -xvzf -;; \
        "linux/arm64") \
          curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-aarch64.tar.xz | tar -C / -Jxpf -; \
          curl -sSL https://github.com/OpenListTeam/OpenList/releases/download/${OPENLIST_VERSION}/openlist-linux-musl-arm64.tar.gz | tar -C /opt/openlist -xvzf -;; \
        *) \
          echo "不支持的CPU架构"; \
          exit 1;; \
      esac

COPY aria2.conf /opt/aria2/config
COPY root /

VOLUME /opt/openlist

EXPOSE 5244

ENTRYPOINT ["/init"]
