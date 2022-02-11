FROM golang:alpine as builder
WORKDIR /root
RUN set -xe \
    && apk add git yarn gcc build-base npm \
    && git clone --recurse-submodules https://github.com/cloudreve/Cloudreve.git \
    && cd Cloudreve/assets \
    && yarn config set registry https://registry.yarnpkg.com \
    && yarn config delete registry \
    && yarn cache clean \
    && yarn --update-checksums \
    && npm config set registry http://registry.npmjs.org \
    && npm config delete registry \
    && yarn install --network-timeout 1000000 \
    && yarn run build \
    && cd ../ \
    && go get github.com/rakyll/statik \
    && statik -src=assets/build/  -include=*.html,*.js,*.json,*.css,*.png,*.svg,*.ico -f \
    && go build -a -o cloudreve -ldflags " -X 'github.com/cloudreve/Cloudreve/v3/pkg/conf.BackendVersion=$(git describe --tags)' -X 'github.com/cloudreve/Cloudreve/v3/pkg/conf.LastCommit=$(git rev-parse --short HEAD)'" \
    && chmod +x cloudreve

FROM alpine:latest
LABEL MAINTAINER="xiami110"
WORKDIR /root
COPY --from=builder /root/Cloudreve/cloudreve /root/cloudreve-main
CMD [ "./cloudreve-main", "-c", "/root/cloudreve/config/cloudreve.ini" ]
