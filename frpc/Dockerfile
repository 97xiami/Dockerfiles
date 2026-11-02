FROM alpine:3.24.3@sha256:be2656061b536c1883c4034790e21d0a09c5aaaf51968b89368a3c0371ea2c9a AS builder
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
