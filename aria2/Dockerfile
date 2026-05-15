FROM alpine:3.23@sha256:5b10f432ef3da1b8d4c7eb6c487f2f5a8f096bc91145e68878dd4a5019afde11
ARG APP_VERSION="1.37.0-r1"
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
