FROM alpine:latest AS builder
WORKDIR /root
RUN set -xe \
    && apk add git yarn npm \
    && git clone --recurse-submodules https://github.com/cloudreve/Cloudreve.git \
    && cd Cloudreve/assets \
    && yarn config get registry \
    && npm config get registry \
    && yarn install \
    && npx -y browserslist@latest --update-db
RUN set -xe \
    && cd /root/Cloudreve \
    && go get github.com/rakyll/statik \
    && statik -src=assets/build/  -include=*.html,*.js,*.json,*.css,*.png,*.svg,*.ico -f
RUN set -xe \
    && cd /root/Cloudreve \
    && go build -a -o cloudreve -ldflags " -X 'github.com/cloudreve/Cloudreve/v3/pkg/conf.BackendVersion=$(git describe --tags)' -X 'github.com/cloudreve/Cloudreve/v3/pkg/conf.LastCommit=$(git rev-parse --short HEAD)'" \
    && chmod +x cloudreve

FROM alpine:latest
MAINTAINER xiami110
WORKDIR /root
COPY --from=builder /root/Cloudreve/cloudreve /usr/bin/cloudreve
CMD [ "cloudreve" ]
