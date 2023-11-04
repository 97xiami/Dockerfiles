FROM golang:alpine AS v2ray
WORKDIR /build
RUN apk update \
    && apk add git gcc build-base \
    && git clone --single-branch https://github.com/v2fly/v2ray-core \
    && cd v2ray-core \
    && go mod download \
    && CGO_ENABLE=0 go build -o /build/v2ray -trimpath -ldflags "-s -w " ./main \
    && chmod +x /build/v2ray

FROM golang:alpine AS v2raya
WORKDIR /build
RUN apk update \
    && apk add git yarn \
    && git clone --single-branch https://github.com/v2rayA/v2rayA -b main \
    && cd v2rayA \
    && V2RAYA_VERSION=$(git describe --abbrev=0 --tags) \
    && cd gui \
    && yarn \
    && yarn build \
    && cd ../service \
    && cp -r ../web server/router \
    && CGO_ENABLE=0 go build -ldflags="-s -w -X github.com/v2rayA/v2rayA/conf.Version=${V2RAYA_VERSION}" -o /build/v2raya . \
    && chmod +x /build/v2raya

FROM alpine:latest
COPY --from=v2ray /build/v2ray /usr/bin/
COPY --from=v2raya /build/v2raya /usr/bin/
RUN apk add --no-cache iptables ip6tables ca-certificates \
    && mkdir -p /etc/v2ray /usr/local/share/v2ray \
    && wget -O /usr/local/share/v2ray/geoip.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat \
    && wget -O /usr/local/share/v2ray/geosite.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat \
    && wget -O /etc/v2ray/config.json https://raw.githubusercontent.com/v2fly/v2ray-examples/master/VLESS-TCP-TLS/config_client.json \
    && wget -O /usr/local/share/v2ray/LoyalsoldierSite.dat https://raw.githubusercontent.com/mzz2017/dist-v2ray-rules-dat/master/geosite.dat
EXPOSE 2017
VOLUME /etc/v2raya
ENTRYPOINT ["v2raya"]
