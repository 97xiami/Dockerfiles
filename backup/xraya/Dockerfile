FROM golang:alpine AS builder
WORKDIR /root
RUN set -xe \
    && apk add git yarn \
    && git clone --single-branch https://github.com/v2rayA/v2rayA -b master \
    && cd v2rayA/gui \
    && yarn \
    && yarn build \
    && cd ../service \
    && cp -r ../web server/router \
    && CGO_ENABLED=0 go build -ldflags="-s -w -X github.com/v2rayA/v2rayA/conf.Version=latest" -o xraya . \
    && chmod +x xraya

FROM xiami110/xray:latest
WORKDIR /xraya
ENV TZ Asia/Shanghai
EXPOSE 2017
COPY --from=builder /root/v2rayA/service/xraya ./xraya
RUN set -xe \
    && apk add --no-cache iptables ip6tables tzdata
ENTRYPOINT ["./xraya", "--v2ray-bin=/xray/xray"]
