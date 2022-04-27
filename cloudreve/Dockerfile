FROM golang:alpine AS builder
WORKDIR /root
RUN set -xe \
    && apk add git yarn gcc build-base npm \
    && git clone --recurse-submodules https://github.com/cloudreve/Cloudreve.git \
    && cd Cloudreve/assets \
    && yarn --update-checksums \
    && yarn install --network-timeout 600000 \
    && yarn run build \
    && cd ../ \
    && go get github.com/rakyll/statik \
    && statik -src=assets/build/  -include=*.html,*.js,*.json,*.css,*.png,*.svg,*.ico -f \
    && go build -a -o cloudreve -ldflags " -X 'github.com/cloudreve/Cloudreve/v3/pkg/conf.BackendVersion=$(git describe --tags)' -X 'github.com/cloudreve/Cloudreve/v3/pkg/conf.LastCommit=$(git rev-parse --short HEAD)'" \
    && chmod +x cloudreve

FROM alpine:latest
LABEL MAINTAINER="xiami110"
WORKDIR /cloudreve
ENV TZ Asia/Shanghai
EXPOSE 5212
VOLUME ["/cloudreve/uploads", "/cloudreve/avatar"]
COPY --from=builder /root/Cloudreve/cloudreve ./cloudreve
COPY conf.ini ./conf.ini
RUN set -xe \
    && apk add --no-cache tzdata
CMD [ "./cloudreve", "-c", "./conf.ini" ]
