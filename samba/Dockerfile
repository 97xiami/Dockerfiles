FROM alpine:3.24@sha256:a2d49ea686c2adfe3c992e47dc3b5e7fa6e6b5055609400dc2acaeb241c829f4
ARG APP_VERSION="4.22.10-r0"
RUN set -eu && \
    apk add --no-cache samba=${APP_VERSION} && \
    adduser -D -s /sbin/nologin share && \
    (echo "password"; echo "password") | smbpasswd -s -a share && \
    mkdir /share | chmod 0770 /share | chown share:share /share && \
    rm -rf /tmp/* /var/cache/apk/*

COPY --chmod=664 smb.conf /etc/samba/smb.conf

VOLUME /share
EXPOSE 445

HEALTHCHECK --interval=60s --timeout=10s CMD smbclient --configfile=/etc/samba/smb.conf -L localhost -U % -m SMB3 -t 5 -c "exit" > /dev/null 2>&1

ENTRYPOINT ["smbd", "-F", "--debug-stdout", "--no-process-group"]
