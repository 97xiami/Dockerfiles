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
    && go build -ldflags="-s -w" -o xraya . \
    && chmod +x xraya

FROM xiami110/xray:latest
EXPOSE 2017
COPY --from=builder /root/v2rayA/xraya /usr/bin/
RUN set -xe \
    && apk add iptables ip6tables
ENTRYPOINT ["xraya"]
