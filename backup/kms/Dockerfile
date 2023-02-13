FROM alpine:latest AS builder
WORKDIR /root
RUN set -xe \
    && apk add --no-cache git make build-base \
    && git clone --single-branch https://github.com/Wind4/vlmcsd.git \
    && cd vlmcsd \
    && make \
    && chmod +x bin/vlmcsd

FROM alpine:latest
LABEL MAINTAINER="xiami110"
WORKDIR /vlmcsd
ENV TZ Asia/Shanghai
EXPOSE 1688
COPY --from=builder /root/vlmcsd/bin/vlmcsd ./vlmcsd
RUN set -xe \
    && apk add --no-cache tzdata
CMD [ "./vlmcsd", "-D", "-e" ]
