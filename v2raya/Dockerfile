FROM golang:alpine AS xray
WORKDIR /xray
RUN apk update \
    && apk add git gcc build-base \
    && git clone --single-branch --depth=1 https://github.com/XTLS/Xray-core \
    && cd Xray-core \
    && go mod download \
    && go build -o /xray/xray -trimpath -ldflags "-s -w " ./main \
    && chmod +x /xray/xray

FROM golang:alpine AS v2raya
WORKDIR /v2raya
RUN apk update \
    && apk add git yarn \
    && git clone --single-branch https://github.com/v2rayA/v2rayA \
    && cd v2rayA \
    && V2RAYA_VERSION=$(git describe --abbrev=0 --tags) \
    && cd gui \
    && yarn \
    && yarn build \
    && cd ../service \
    && cp -r ../web server/router \
    && CGO_ENABLE=0 go build -ldflags="-s -w -X github.com/v2rayA/v2rayA/conf.Version=${V2RAYA_VERSION}" -o /v2raya/v2raya . \
    && chmod +x /v2raya/v2raya

FROM alpine:latest
COPY --from=xray /v2raya/xray /usr/bin/
COPY --from=v2raya /v2raya/v2raya /usr/bin/
RUN apk update \
    && apk add --no-cache iptables ip6tables ca-certificates \
    && mkdir -p /etc/xray /usr/local/share/xray \
    && wget -O /usr/local/share/xray/geoip.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat \
    && wget -O /usr/local/share/xray/geosite.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat \
    && wget -O /etc/xray/config.json https://raw.githubusercontent.com/v2fly/v2ray-examples/master/VLESS-TCP-TLS/config_client.json \
    && wget -O /usr/local/share/xray/LoyalsoldierSite.dat https://raw.githubusercontent.com/mzz2017/dist-v2ray-rules-dat/master/geosite.dat
EXPOSE 2017
VOLUME /etc/v2raya
ENTRYPOINT ["v2raya"]
