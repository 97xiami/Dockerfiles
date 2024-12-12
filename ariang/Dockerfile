FROM alpine:latest AS builder
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
    && git clone --single-branch --depth=1 https://github.com/emikulic/darkhttpd \
    && cd darkhttpd \
    && make darkhttpd \
    && strip darkhttpd \
    && cd /ariang \
    && chmod a+x install.sh \
    && bash install.sh

FROM alpine:latest AS installer
WORKDIR /ariang
COPY install.sh /ariang
RUN apk update \
    && apk add curl bash \
    && chmod a+x install.sh \
    && bash install.sh

# Just the static binary
FROM scratch
COPY --from=builder /src/darkhttpd /darkhttpd
COPY --from=installer /ariang /AriaNg
EXPOSE 6880
ENTRYPOINT ["/darkhttpd", "/AriaNg"]
CMD ["--port", "6880", "--chroot"]
