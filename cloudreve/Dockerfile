FROM alpine:latest AS builder
WORKDIR /root
RUN set -xe \
    && apk add git yarn npm go \
    && git clone --recurse-submodules https://github.com/cloudreve/Cloudreve.git \
    && cd Cloudreve/assets \
    && yarn install \
    && npx -y browserslist@latest --update-db \
    && yarn run build \
    && cd ../ \
    && go get github.com/rakyll/statik \
    && statik -src=assets/build/  -include=*.html,*.js,*.json,*.css,*.png,*.svg,*.ico -f \
    && go build -a -o cloudreve -ldflags " -X 'github.com/cloudreve/Cloudreve/v3/pkg/conf.BackendVersion=$(git describe --tags)' -X 'github.com/cloudreve/Cloudreve/v3/pkg/conf.LastCommit=$(git rev-parse --short HEAD)'" \
    && chmod +x cloudreve

FROM alpine:latest
MAINTAINER xiami110
WORKDIR /root
COPY --from=builder /root/Cloudreve/cloudreve /usr/bin/cloudreve
CMD [ "cloudreve" ]
