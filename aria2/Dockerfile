FROM alpine:3.24@sha256:a2d49ea686c2adfe3c992e47dc3b5e7fa6e6b5055609400dc2acaeb241c829f4
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
