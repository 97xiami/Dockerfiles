FROM golang:alpine AS build
WORKDIR /build
RUN apk update \
    && apk add git gcc build-base \
    && git clone --single-branch --depth=1 https://github.com/XTLS/Xray-core \
    && cd Xray-core \
    && go mod download \
    && go build -o /build/xray -trimpath -ldflags "-s -w " ./main \
    && chmod +x /build/xray

FROM alpine:latest
COPY --from=build /build/xray /usr/bin/
RUN apk update \
    && apk add --no-cache iptables ip6tables ca-certificates \
    && mkdir -p /etc/xray/ssl /usr/local/share/xray \
    && wget -O /usr/local/share/xray/geoip.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat \
    && wget -O /usr/local/share/xray/geosite.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat \
    && wget -O /etc/xray/config.json https://raw.githubusercontent.com/v2fly/v2ray-examples/master/VLESS-TCP-TLS/config_client.json
VOLUME /etc/xray
ENTRYPOINT ["xray"]
