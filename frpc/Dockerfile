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
VOLUME /etc/frp
COPY --from=builder /root/frp/bin/frpc /usr/bin/frpc
COPY frpc.ini /etc/frp/frpc.ini
RUN set -xe \
    && apk add tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && apk del tzdata
CMD [ "/usr/bin/frpc", "-c", "/etc/frp/frpc.ini" ]
