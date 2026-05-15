FROM alpine:3.23@sha256:5b10f432ef3da1b8d4c7eb6c487f2f5a8f096bc91145e68878dd4a5019afde11 AS builder
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
