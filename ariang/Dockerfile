FROM alpine:3.23@sha256:5b10f432ef3da1b8d4c7eb6c487f2f5a8f096bc91145e68878dd4a5019afde11 AS builder
ARG APP_VERSION="1.3.13"
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
