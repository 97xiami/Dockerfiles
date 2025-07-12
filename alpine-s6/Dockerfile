FROM alpine:latest

ARG S6_OVERLAY_VERSION="v3.2.1.0"
ARG TARGETPLATFORM
RUN addgroup -S docker \
    && adduser -S -G docker -s /bin/false docker \
    && case "${TARGETPLATFORM}" in \
      "linux/amd64") \
        FILENAME="s6-overlay-x86_64.tar.xz";; \
      "linux/arm64") \
        FILENAME="s6-overlay-aarch64.tar.xz";; \
      *) \
        echo "不支持的CPU架构"; \
        exit 1;; \
    esac

# Add s6-overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz

ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/${FILENAME} /tmp
RUN tar -C / -Jxpf /tmp/${FILENAME}

# Add s6-overlay-symlinks
ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-symlinks-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-symlinks-noarch.tar.xz

ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-symlinks-arch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-symlinks-arch.tar.xz

ENTRYPOINT ["/init"]
