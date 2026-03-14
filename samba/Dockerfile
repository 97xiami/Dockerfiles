FROM alpine:latest
RUN set -eu && \
    apk add --no-cache samba && \
    adduser -D -s /sbin/nologin share && \
    echo "share:password" | chpasswd && \
    (echo "password"; echo "password") | smbpasswd -s -a share && \
    mkdir /share | chmod 0770 /share | chown share:share /share && \
    rm -rf /tmp/* /var/cache/apk/*

COPY --chmod=664 smb.conf /etc/samba/smb.conf

VOLUME /share
EXPOSE 445

HEALTHCHECK --interval=60s --timeout=15s CMD smbclient --configfile=/etc/samba/smb.conf -L \\localhost -U % -m SMB3

ENTRYPOINT ["smbd", "-F", "--debug-stdout", "--no-process-group"]
