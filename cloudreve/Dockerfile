FROM golang:alpine AS builder
WORKDIR /root
RUN set -xe \
    && apk add git yarn gcc build-base npm zip \
    && git clone --recurse-submodules https://github.com/cloudreve/Cloudreve.git \
    && cd Cloudreve/assets \
    && yarn install --network-timeout 600000 \
    && yarn run build \
    && find . -name "*.map" -type f -delete \
    && cd ../ \
    && zip -r - assets/build >assets.zip \
    && go build -a -o cloudreve -ldflags " -X 'github.com/cloudreve/Cloudreve/v3/pkg/conf.BackendVersion=$(git describe --tags)' -X 'github.com/cloudreve/Cloudreve/v3/pkg/conf.LastCommit=$(git rev-parse --short HEAD)'" \
    && chmod +x cloudreve

FROM alpine:latest
LABEL MAINTAINER="xiami110"
WORKDIR /cloudreve
ENV TZ Asia/Shanghai
EXPOSE 5212
VOLUME ["/cloudreve/avatar", "/cloudreve/config", "/cloudreve/db", "/cloudreve/uploads"]
COPY --from=builder /root/Cloudreve/cloudreve ./cloudreve
COPY conf.ini ./config/conf.ini
RUN set -xe \
    && apk add --no-cache tzdata
CMD [ "./cloudreve", "-c", "./config/conf.ini" ]
