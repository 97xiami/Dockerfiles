FROM golang:alpine AS builder
WORKDIR /root
RUN set -xe \
    && apk add git yarn gcc build-base npm \
    && git clone --recurse-submodules https://github.com/cloudreve/Cloudreve.git \
    && cd Cloudreve/assets \
    && yarn install --network-timeout 1000000 \
    && npx -y browserslist@latest --update-db \
    && yarn run build \
    && cd ../ \
    && go get github.com/rakyll/statik \
    && statik -src=assets/build/  -include=*.html,*.js,*.json,*.css,*.png,*.svg,*.ico -f \
    && go build -a -o cloudreve -ldflags " -X 'github.com/cloudreve/Cloudreve/v3/pkg/conf.BackendVersion=$(git describe --tags)' -X 'github.com/cloudreve/Cloudreve/v3/pkg/conf.LastCommit=$(git rev-parse --short HEAD)'" \
    && chmod +x cloudreve \
    && cd /root
    && export ARCH=$(uname -m) \
    && wget https://github.com/P3TERX/Aria2-Pro-Core/releases/download/1.36.0_2021.08.22/aria2-1.36.0-static-linux-$ARCH.tar.gz \
    && tar -zxvf aria2-1.36.0-static-linux-$ARCH.tar.gz \
    && chmod +x aria2c

FROM alpine:latest
MAINTAINER xiami110
WORKDIR /root
COPY --from=builder /root/Cloudreve/cloudreve /root/main
COPY --from=builder /root/aria2c /root/aria2c
COPY conf /root/aria2
CMD [ "./main", "-c", "/root/cloudreve/conf.ini" ]
ENTRYPOINT [ "./aria2c", "-c", "/root/aria2/aria2.conf" ]
