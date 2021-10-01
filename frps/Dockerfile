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
WORKDIR /root
VOLUME /etc/frps
COPY --from=builder /root/frp/bin/frps /usr/bin/frps
COPY frps.ini /etc/frps/frps.ini
RUN set -xe \
    && apk add tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && apk del tzdata
CMD [ "/usr/bin/frps", "-c", "/etc/frps/frps.ini" ]
