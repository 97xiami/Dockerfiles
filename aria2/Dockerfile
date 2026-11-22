FROM alpine:3.24.4@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf
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
