FROM alpine:latest

ARG S6_OVERLAY_VERSION="v3.2.1.0"
ARG TARGETPLATFORM
RUN addgroup -S docker \
    && adduser -S -G docker -s /bin/false docker \
    && curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz | tar -C / -Jxpf - \
    && curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-symlinks-noarch.tar.xz | tar -C / -Jxpf - \
    && curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-symlinks-arch.tar.xz | tar -C / -Jxpf - \
    && case "${TARGETPLATFORM}" in \
        "linux/amd64") \
          curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz | tar -C / -Jxpf -;; \
        "linux/arm64") \
          curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-aarch64.tar.xz | tar -C / -Jxpf -;; \
        *) \
          echo "不支持的CPU架构"; \
          exit 1;; \
      esac

ENTRYPOINT ["/init"]
