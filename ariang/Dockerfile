FROM alpine:3.24@sha256:a2d49ea686c2adfe3c992e47dc3b5e7fa6e6b5055609400dc2acaeb241c829f4 AS builder
ARG APP_VERSION="1.3.14"
WORKDIR /src
ENV CFLAGS=" \
  -static                                 \
  -O2                                     \
  -flto                                   \
  -D_FORTIFY_SOURCE=2                     \
  -fstack-clash-protection                \
  -fstack-protector-strong                \
  -pipe                                   \
  -Wall                                   \
  -Werror=format-security                 \
  -Werror=implicit-function-declaration   \
  -Wl,-z,defs                             \
  -Wl,-z,now                              \
  -Wl,-z,relro                            \
  -Wl,-z,noexecstack                      \
"

RUN apk update \
    && apk add --no-cache git build-base curl bash \
    && mkdir AriaNg \
    && cd AriaNg \
    && curl -L -o AriaNg.zip https://github.com/mayswind/AriaNg/releases/download/${APP_VERSION}/AriaNg-${APP_VERSION}.zip \
    && unzip AriaNg.zip -d ${PWD} \
    && rm AriaNg.zip \
    && cd /src \
    && git clone --single-branch --depth=1 https://github.com/emikulic/darkhttpd \
    && cd darkhttpd \
    && make darkhttpd \
    && strip darkhttpd

FROM scratch
COPY --from=builder /src/darkhttpd/darkhttpd /
COPY --from=builder /src/AriaNg /AriaNg
EXPOSE 6880
ENTRYPOINT ["/darkhttpd", "/AriaNg"]
CMD ["--port", "6880"]
