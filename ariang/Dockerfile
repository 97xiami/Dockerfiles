FROM alpine:3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b AS builder
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
