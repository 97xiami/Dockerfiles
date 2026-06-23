FROM alpine:3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b
ARG APP_VERSION="1.37.0-r2"
RUN apk update \
    && apk add --no-cache aria2=${APP_VERSION} \
    && mkdir /downloads /config \
    && touch /config/aria2.session

#复制smb.conf配置文件
COPY aria2.conf /config/aria2.conf
#共享目录
VOLUME ["/config", "/downloads"]
#暴露端口
EXPOSE 6800

ENTRYPOINT ["aria2c", "--conf-path", "/config/aria2.conf"]
