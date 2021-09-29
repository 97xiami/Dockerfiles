FROM alpine:latest AS builder
WORKDIR /root
RUN set -xe \
    && apk add git go make \
    && git clone --single-branch https://github.com/fatedier/frp.git \
    && cd frp \
    && make \
    && chmod +x bin/frps

FROM alpine:latest
MAINTAINER xiami110
ENV TZ Asia/Shanghai
WORKDIR /root
VOLUME /etc/frp

COPY --from=builder /root/frp/bin/frps /usr/bin
COPY frps.ini /etc/frp/frps.ini
CMD /usr/bin/frps -c /etc/frp/frps.ini
