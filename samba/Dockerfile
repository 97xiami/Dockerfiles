FROM alpine:latest

RUN apk update \
    && apk add --no-cache samba samba-common-tools \
    && mkdir /share \
    && adduser -D -H -s /sbin/nologin share \
    && echo "share:password" | chpasswd \
    && (echo "password"; echo "password") | smbpasswd -s -a share

#复制smb.conf配置文件
COPY smb.conf /etc/samba/smb.conf
#共享目录
VOLUME ["/share"]
#暴露端口
EXPOSE 137 138 139 445

ENTRYPOINT ["smbd", "-F", "--debug-stdout", "--no-process-group"]
