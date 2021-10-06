FROM golang:alpine AS builder
WORKDIR /root
RUN set -xe \
    && apk add git gcc build-base \
    && git clone https://github.com/drakkan/sftpgo.git \
    && cd sftpgo \
    && go build -tags nogcs,nos3,noazblob,nobolt,nomysql,nopgsql,nometrics,novaultkms,noawskms,nogcpkms -trimpath -ldflags "-s -w -X github.com/drakkan/sftpgo/v2/version.commit=`git describe --always --dirty` -X github.com/drakkan/sftpgo/v2/version.date=`date -u +%FT%TZ`" -o sftpgo \
    && chmod +x sftpgo

FROM alpine
MAINTAINER xiami110
WORKDIR /root
COPY --from=builder /root/sftpgo/sftpgo /usr/bin/sftpgo
COPY --from=builder /root/sftpgo/templates /root/templates
COPY --from=builder /root/sftpgo/static /root/static
CMD [ "sftpgo", "serve" ]
