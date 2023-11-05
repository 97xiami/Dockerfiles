FROM golang:alpine AS builder
WORKDIR /build
RUN apk update \
    && apk add git make \
    && git clone --single-branch https://github.com/fatedier/frp.git \
    && cd frp \
    && make \
    && chmod +x bin/frpc

FROM alpine:latest
COPY --from=builder /build/frp/bin/frpc /usr/bin/frpc
ENTRYPOINT ["frpc", "-c", "/etc/frp/frpc.toml"]
