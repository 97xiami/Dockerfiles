FROM golang:alpine AS builder
WORKDIR /root
RUN set -xe \
    && apk add git gcc build-base \
    && git clone --single-branch https://github.com/XTLS/Xray-core.git \
    && cd Xray-core \
    && go build -o xray -trimpath -ldflags "-s -w " ./main \
    && chmod +x xray

FROM alpine:latest
LABEL MAINTAINER="xiami110"
WORKDIR /xray
ENV TZ Asia/Shanghai
VOLUME ["/xray/config", "/xray/ssl"]
COPY --from=builder /root/Xray-core/xray ./xray
COPY config.json ./config/config.json
COPY up-geo.sh ./up-geo.sh
RUN set -xe \
    && mkdir -p /usr/share/xray \
    && apk add --no-cache tzdata ca-certificates \
    && wget -O /usr/share/xray/geoip.dat https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geoip.dat \
    && wget -O /usr/share/xray/geosite.dat https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geosite.dat \
    && chmod +x ./up-geo.sh
CMD [ "./xray", "-c", "./config/config.json" ]
