FROM alpine:3.24@sha256:a2d49ea686c2adfe3c992e47dc3b5e7fa6e6b5055609400dc2acaeb241c829f4 AS builder
WORKDIR /build

COPY install.sh /build
RUN apk update \
    && apk add --no-cache ca-certificates curl bash \
    && cd /build \
    && chmod +x install.sh \
    && bash install.sh

FROM scratch
COPY --from=builder /build/frps /usr/bin/
COPY --from=builder /build/frps.toml /etc/frp/frps.toml

ENTRYPOINT ["frps", "-c", "/etc/frp/frps.toml"]
