FROM golang:alpine AS builder
WORKDIR /build
RUN apk update \
    && apk add git make \
    && git clone --single-branch https://github.com/fatedier/frp.git \
    && cd frp \
    && make \
    && chmod +x bin/frps

FROM alpine:latest
COPY --from=builder /build/frp/bin/frps /usr/bin/frps
ENTRYPOINT ["frps", "-c", "/etc/frp/frps.toml"]
