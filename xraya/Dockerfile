FROM golang:1.17-alpine AS builder
WORKDIR /root
RUN set -xe \
    && apk add git yarn \
    && git clone --single-branch https://github.com/v2rayA/v2rayA \
    && cd v2rayA/gui \
    && yarn \
    && yarn build \
    && cd ../service \
    && cp -r ../web server/router \
    && CGO_ENABLED=0 go build -ldflags="-s -w -X github.com/v2rayA/v2rayA/conf.Version=latest" -o xraya . \
    && chmod +x xraya

FROM xiami110/xray:latest
MAINTAINER xiami110
WORKDIR /root
COPY --from=builder /root/v2rayA/service/xraya /usr/bin/xraya
RUN set -xe \
    && apk add iptables ip6tables tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && apk del tzdata
ENTRYPOINT ["xraya"]
