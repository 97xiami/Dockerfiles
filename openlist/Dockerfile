FROM alpine:latest

WORKDIR /opt/openlist

ARG S6_OVERLAY_VERSION="v3.2.1.0"
ARG VERSION="v4.1.3"
ARG TARGETPLATFORM
COPY aria2.conf /opt/aria2/config/aria2.conf
COPY root /

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN apk add --no-cache aria2 curl \
    && addgroup -S docker \
    && adduser -S -G docker -s /bin/false docker \
    && curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz | tar -C / -Jxpf - \
    && curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-symlinks-noarch.tar.xz | tar -C / -Jxpf - \
    && curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-symlinks-arch.tar.xz | tar -C / -Jxpf - \
    && case "${TARGETPLATFORM}" in \
        "linux/amd64") \
          curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz | tar -C / -Jxpf -; \
          curl -sSL https://github.com/OpenListTeam/OpenList/releases/download/${VERSION}/openlist-linux-musl-amd64.tar.gz | tar -C /opt/openlist -xvzf -;; \
        "linux/arm64") \
          curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-aarch64.tar.xz | tar -C / -Jxpf -; \
          curl -sSL https://github.com/OpenListTeam/OpenList/releases/download/${VERSION}/openlist-linux-musl-arm64.tar.gz | tar -C /opt/openlist -xvzf -;; \
        *) \
          echo "不支持的CPU架构"; \
          exit 1;; \
      esac \
    && apk del curl \
    && rm -rf /var/cache/apk/* \
    && mkdir /opt/downloads \
    && touch /opt/aria2/aria2.session \
    && chmod 600 /opt/aria2/aria2.session \
    && chmod +x /opt/openlist/openlist \
    && chown -R docker:docker /opt

VOLUME /opt/openlist

EXPOSE 5244

ENTRYPOINT ["/init"]
