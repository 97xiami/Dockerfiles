FROM alpine:3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b AS builder
WORKDIR /build

COPY install.sh /build
RUN apk update \
    && apk add --no-cache ca-certificates curl bash \
    && cd /build \
    && chmod +x install.sh \
    && bash install.sh

FROM scratch
COPY --from=builder /build/frpc /usr/bin/
COPY --from=builder /build/frpc.toml /etc/frp/frpc.toml

ENTRYPOINT ["frpc", "-c", "/etc/frp/frpc.toml"]
