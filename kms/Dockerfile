FROM alpine:latest AS builder
WORKDIR /root
RUN set -xe \
    && apk add --no-cache git make build-base \
    && git clone --single-branch https://github.com/Wind4/vlmcsd.git \
    && cd vlmcsd \
    && make \
    && chmod +x bin/vlmcsd

FROM alpine:latest
MAINTAINER xiami110
WORKDIR /root
COPY --from=builder /root/vlmcsd/bin/vlmcsd /usr/bin/vlmcsd
RUN set -xe \
    && apk add tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && apk del tzdata
CMD [ "vlmcsd", "-D", "-e" ]
