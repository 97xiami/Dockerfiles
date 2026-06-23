FROM alpine:3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b AS builder
WORKDIR /build

RUN apk update \
    && apk add git make build-base tree \
    && git clone --single-branch --depth=1 https://github.com/Wind4/vlmcsd \
    && cd vlmcsd \
    && sed -n '473p' src/kms.c | sed -i '467r /dev/stdin' src/kms.c \
    && sed -i '474d' src/kms.c \
    && make LDFLAGS="-static" vlmcsdmulti

FROM scratch
COPY --from=builder /build/vlmcsd/bin/vlmcsdmulti /vlmcsdmulti
EXPOSE 1688/tcp

ENTRYPOINT ["/vlmcsdmulti"]
CMD ["vlmcsd", "-D", "-d", "-e"]
