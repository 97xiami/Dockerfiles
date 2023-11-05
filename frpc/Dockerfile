FROM golang:alpine AS builder
WORKDIR /build
RUN apk update \
    && apk add git make \
    && git clone --single-branch --depth=1 https://github.com/fatedier/frp \
    && cd frp \
    && make \
    && chmod +x bin/frpc

FROM alpine:latest
COPY --from=builder /build/frp/bin/frpc /usr/bin/frpc
ENTRYPOINT ["frpc", "-c", "/etc/frp/frpc.toml"]
