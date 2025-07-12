FROM xiami110/alpine-s6:latest

WORKDIR /opt/openlist

ARG OPENLIST_VERSION="v4.0.8"
ARG TARGETPLATFORM
RUN apk add --no-cache aria2 \
    && mkdir -p /opt/aria2/downloads /opt/aria2/config \
    && touch /opt/aria2/aria2.session \
    && case "${TARGETPLATFORM}" in \
        "linux/amd64") \
          curl -sSL https://github.com/OpenListTeam/OpenList/releases/download/${OPENLIST_VERSION}/openlist-linux-musl-amd64.tar.gz | tar -C /opt/openlist -xvzf -;; \
        "linux/arm64") \
          curl -sSL https://github.com/OpenListTeam/OpenList/releases/download/${OPENLIST_VERSION}/openlist-linux-musl-arm64.tar.gz | tar -C /opt/openlist -xvzf -;; \
        *) \
          echo "不支持的CPU架构"; \
          exit 1;; \
      esac \
    && chmod +x /opt/openlist/openlist

COPY aria2.conf /opt/aria2/config
COPY root /

VOLUME /opt/openlist/data/
VOLUME /opt/aria2/downloads
VOLUME /opt/aria2/config

EXPOSE 5244
