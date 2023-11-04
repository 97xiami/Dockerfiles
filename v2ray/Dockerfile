FROM golang:alpine AS builder
WORKDIR /build
RUN set -xe \
    && apk add git gcc build-base \
    && git clone --single-branch https://github.com/v2fly/v2ray-core \
    && cd v2ray-core \
    && go mod download \
    && CGO_ENABLE=0 go build -o /build/v2ray -trimpath -ldflags "-s -w " ./main \
    && chmod +x /build/v2ray

FROM alpine:latest
COPY --from=builder /build/v2ray /usr/bin/v2ray
RUN set -xe \
    && mkdir -p /etc/v2ray /usr/local/share/v2ray \
    && apk add --no-cache ca-certificates \
    && wget -O /usr/local/share/v2ray/geoip.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat \
    && wget -O /usr/local/share/v2ray/geosite.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat \
    && wget -O /etc/v2ray/config.json https://raw.githubusercontent.com/v2fly/v2ray-examples/master/VLESS-TCP-TLS/config_client.json
ENTRYPOINT ["v2ray"]
