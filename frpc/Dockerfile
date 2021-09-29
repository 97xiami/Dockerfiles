FROM alpine:latest AS builder
WORKDIR /root
RUN set -xe \
    && apk add git go make \
    && git clone --single-branch https://github.com/fatedier/frp.git \
    && cd frp \
    && make \
    && chmod +x bin/frpc

FROM alpine:latest
MAINTAINER xiami110
ENV TZ Asia/Shanghai
VOLUME /etc/frp

COPY --from=builder /root/frp/bin/frpc /usr/bin
COPY frpc.ini /etc/frp/frpc.ini
CMD /usr/bin/frpc -c /etc/frp/frpc.ini
