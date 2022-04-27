FROM golang:alpine AS builder
WORKDIR /root
RUN set -xe \
    && apk add git make \
    && git clone --single-branch https://github.com/fatedier/frp.git \
    && cd frp \
    && make \
    && chmod +x bin/frps

FROM alpine:latest
LABEL MAINTAINER="xiami110"
WORKDIR /frps
ENV TZ Asia/Shanghai
COPY --from=builder /root/frp/bin/frps ./frps
COPY frps.ini /frps/frps.ini
RUN set -xe \
    && apk add --no-cache tzdata
CMD [ "./frps", "-c", "./frps.ini" ]
