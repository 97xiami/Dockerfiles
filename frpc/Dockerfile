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
VOLUME /etc/frp
RUN set -xe \
    && apk add tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && apk del tzdata
COPY --from=builder /root/frp/bin/frpc /usr/bin
COPY frpc.ini /etc/frp/frpc.ini
CMD [ "/usr/bin/frpc", "-c", "/etc/frp/frpc.ini" ]
