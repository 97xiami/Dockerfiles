FROM golang:alpine AS builder
WORKDIR /root
RUN set -xe \
    && apk add git make \
    && git clone --single-branch https://github.com/fatedier/frp.git \
    && cd frp \
    && make \
    && chmod +x bin/frps

FROM alpine:latest
MAINTAINER xiami110
WORKDIR /root
COPY --from=builder /root/frp/bin/frps /usr/bin/frps
COPY frps.ini /etc/frp/frps.ini
RUN set -xe \
    && apk add tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && apk del tzdata
CMD [ "frps", "-c", "/etc/frp/frps.ini" ]
