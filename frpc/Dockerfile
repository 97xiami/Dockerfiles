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
WORKDIR /frpc
ENV TZ Asia/Shanghai
COPY --from=builder /root/frp/bin/frpc ./frpc
COPY frpc.ini ./frpc.ini
RUN set -xe \
    && apk add --no-cache tzdata
CMD [ "./frpc", "-c", "./frpc.ini" ]
