FROM alpine:latest AS builder
WORKDIR /root
RUN set -xe \
    && apk add git go gcc build-base \
    && git clone --single-branch https://github.com/XTLS/Xray-core.git \
    && cd Xray-core \
    && go build -o xray -trimpath -ldflags "-s -w " ./main \
    && chmod +x xray

FROM alpine:latest
MAINTAINER xiami110
WORKDIR /root
VOLUME /etc/xray
COPY --from=builder /root/Xray-core/xray /usr/bin/xray
COPY config.json /etc/xray/config.json
RUN set -xe \
    && mkdir -p /var/log/xray /usr/share/xray /etc/xray \
    && apk add tzdata ca-certificates \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && wget -O /usr/share/xray/geosite.dat https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat \
    && wget -O /usr/share/xray/geoip.dat https://github.com/v2fly/geoip/releases/latest/download/geoip.dat \
    && apk del tzdata ca-certificates
CMD [ "/usr/bin/xray", "-c", "/etc/xray/config.json" ]
