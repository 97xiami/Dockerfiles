FROM golang:alpine AS builder
WORKDIR /root
RUN set -xe \
    && apk add git make \
    && git clone --single-branch https://github.com/fatedier/frp.git \
    && cd frp \
    && make \
    && chmod +x bin/frpc

FROM alpine:latest
MAINTAINER xiami110
WORKDIR /root
COPY --from=builder /root/frp/bin/frpc /usr/bin/frpc
COPY frpc.ini /root/frpc/frpc.ini
RUN set -xe \
    && apk add tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && apk del tzdata
CMD [ "frpc", "-c", "/root/frpc/frpc.ini" ]
