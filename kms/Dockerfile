FROM alpine:3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b AS builder
WORKDIR /build
ARG REPO="Wind4/vlmcsd.git"
ARG APP_COMMIT="70e03572b254688b8c3557f898e7ebd765d29ae1"

RUN apk add --no-cache git make build-base tree \
    && git init \
    && git remote add origin https://github.com/$REPO \
    && git fetch --depth=1 origin "$APP_COMMIT" \
    && git checkout FETCH_HEAD \
    && sed -n '473p' src/kms.c | sed -i '467r /dev/stdin' src/kms.c \
    && sed -i '474d' src/kms.c \
    && make LDFLAGS="-static" vlmcsdmulti

FROM scratch
COPY --from=builder /build/vlmcsd/bin/vlmcsdmulti /vlmcsdmulti
EXPOSE 1688/tcp

USER 65534
ENTRYPOINT ["/vlmcsdmulti"]
CMD ["vlmcsd", "-D", "-d", "-e"]
