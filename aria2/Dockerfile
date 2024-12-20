FROM alpine:latest

RUN apk update \
    && apk add --no-cache aria2 \
    && mkdir /downloads /config \
    && touch /config/aria2.session

#复制smb.conf配置文件
COPY aria2.conf /config/aria2.conf
#共享目录
VOLUME ["/config", "/downloads"]
#暴露端口
EXPOSE 6800

ENTRYPOINT ["aria2c", "--conf-path", "/config/aria2.conf"]
