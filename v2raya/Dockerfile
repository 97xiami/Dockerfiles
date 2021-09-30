FROM alpine:latest AS builder
WORKDIR /root
RUN set -xe \
    && apk add git go yarn \
    && git clone --single-branch https://github.com/v2rayA/v2rayA \
    && cd v2rayA/gui \
    && yarn \
    && yarn build \
    && cd ../service \
    && cp -r ../web server/router \
    && go build -ldflags="-s -w" -o v2raya . \
    && chmod +x v2raya

FROM v2fly/v2fly-core
COPY --from=builder /root/v2rayA/service/v2raya /usr/bin/
RUN wget -O /usr/local/share/v2ray/LoyalsoldierSite.dat https://raw.githubusercontent.com/mzz2017/dist-v2ray-rules-dat/master/geosite.dat
RUN apk add --no-cache iptables ip6tables
EXPOSE 2017
VOLUME /etc/v2raya
ENTRYPOINT ["v2raya"]
