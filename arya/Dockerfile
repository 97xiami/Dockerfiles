FROM node:16-alpine AS builder1

# Create dir for application
WORKDIR /app

RUN apk add git \
    && git clone --depth=1 https://github.com/nicejade/markdown-online-editor.git arya \
    && cd arya \
    && yarn \
    && yarn build

FROM alpine:latest AS builder2
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
    && strip darkhttpd

FROM scratch
COPY --from=builder2 /src/darkhttpd/darkhttpd /
COPY --from=builder1 /app/arya/dist /dist
EXPOSE 8080
ENTRYPOINT ["/darkhttpd", "/dist"]
CMD ["--port", "8080"]
