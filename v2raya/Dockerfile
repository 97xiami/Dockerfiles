FROM golang:alpine AS builder

ARG VERSION
ARG BUILD_DATE

LABEL build_version="version:- ${VERSION} Build-date:- ${BUILD_DATE}"

ENV TITLE=v2rayA

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
    && CGO_ENABLE=0 go build -ldflags="-s -w -X github.com/v2rayA/v2rayA/conf.Version=${V2RAYA_VERSION}" -o v2raya . \
    && chmod +x v2raya

FROM v2fly/v2fly-core
COPY --from=builder /build/service/v2raya /usr/bin/
RUN wget -O /usr/local/share/v2ray/LoyalsoldierSite.dat https://raw.githubusercontent.com/mzz2017/dist-v2ray-rules-dat/master/geosite.dat
RUN apk add --no-cache iptables ip6tables
EXPOSE 2017
VOLUME /etc/v2raya
ENTRYPOINT ["v2raya"]
