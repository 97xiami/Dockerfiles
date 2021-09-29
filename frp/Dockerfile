FROM alpine:latest AS builder
WORKDIR /root
RUN set -xe \
    && apk add git go make \
    && git clone --single-branch https://github.com/fatedier/frp.git \
    && cd frp \
    && make \
    && chmod +x bin/frp*

FROM alpine:latest
MAINTAINER xiami110
ENV TZ Asia/Shanghai
ENV FRP frps
WORKDIR /root
VOLUME /etc/frp

COPY --from=builder /root/frp/bin/frp* /usr/bin/
COPY frp.ini /etc/frp/frp.ini
CMD [ "/usr/bin/\$FRP", "-c", "/etc/frp/frp.ini" ]
