FROM alpine:latest AS builder
WORKDIR /root
RUN set -xe \
    && apk add --no-cache git go gcc build-base \
    && git clone --single-branch https://github.com/XTLS/Xray-core.git \
    && cd Xray-core \
    && go build -o xray -trimpath -ldflags "-s -w " ./main \
    && chmod +x xray

FROM alpine:latest
MAINTAINER xiami110
ENV TZ Asia/Shanghai
WORKDIR /root
VOLUME /etc/xray

COPY --from=builder /root/Xray-core/xray /usr/bin/xray
RUN set -xe \
    && mkdir -p /var/log/xray /usr/share/xray /etc/xray \
    && apk add --no-cache ca-certificates \
    && wget -O /usr/share/xray/geosite.dat https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat \
    && wget -O /usr/share/xray/geoip.dat https://github.com/v2fly/geoip/releases/latest/download/geoip.dat
COPY config.json /etc/xray/config.json
CMD [ "/usr/bin/xray", "-config", "/etc/xray/config.json" ]
