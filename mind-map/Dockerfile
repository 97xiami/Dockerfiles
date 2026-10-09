FROM alpine:3.24.2@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6 AS builder
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
    && apk add --no-cache git build-base \
    && git clone --single-branch --depth=1 https://github.com/emikulic/darkhttpd \
    && git clone --single-branch --depth=1 https://github.com/wanglin2/mind-map \
    && cd darkhttpd \
    && make darkhttpd \
    && strip darkhttpd

FROM scratch
COPY --from=builder /src/darkhttpd/darkhttpd /
COPY --from=builder /src/mind-map/index.html /mind-map/index.html
COPY --from=builder /src/mind-map/dist /mind-map/dist
EXPOSE 80
ENTRYPOINT ["/darkhttpd", "/mind-map"]
CMD ["--port", "80"]
