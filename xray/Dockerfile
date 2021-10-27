FROM golang:alpine AS builder
WORKDIR /root
RUN set -xe \
    && apk add git gcc build-base \
    && git clone --single-branch https://github.com/XTLS/Xray-core.git \
    && cd Xray-core \
    && go build -o xray -trimpath -ldflags "-s -w " ./main \
    && chmod +x xray

FROM alpine:latest
MAINTAINER xiami110
WORKDIR /root
COPY --from=builder /root/Xray-core/xray /usr/bin/xray
COPY config.json /root/xray/config.json
COPY up-geo.sh /root/xray/up-geo.sh
RUN set -xe \
    && mkdir -p /usr/share/xray \
    && apk add tzdata ca-certificates \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && wget -O /usr/share/xray/geosite.dat https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat \
    && wget -O /usr/share/xray/geoip.dat https://github.com/v2fly/geoip/releases/latest/download/geoip.dat \
    && apk del tzdata ca-certificates \
    && chmod +x /root/xray/up-geo.sh \
    && echo "30 6 * * * sh /root/xray/up-geo.sh" >> /var/spool/cron/crontabs/root \
    && crond
CMD [ "xray", "-c", "/root/xray/config.json" ]
