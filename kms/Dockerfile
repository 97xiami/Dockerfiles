FROM alpine:3.24.3@sha256:be2656061b536c1883c4034790e21d0a09c5aaaf51968b89368a3c0371ea2c9a AS builder
WORKDIR /build
ARG REPO="Wind4/vlmcsd.git"
ARG APP_COMMIT="70e03572b254688b8c3557f898e7ebd765d29ae1"

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN apk add --no-cache git make build-base \
    && git init \
    && git remote add origin https://github.com/$REPO \
    && git fetch --depth=1 origin "$APP_COMMIT" \
    && git checkout FETCH_HEAD \
    && sed -n '473p' src/kms.c | sed -i '467r /dev/stdin' src/kms.c \
    && sed -i '474d' src/kms.c \
    && make LDFLAGS="-static" vlmcsdmulti

FROM scratch
COPY --from=builder /build/bin/vlmcsdmulti /vlmcsdmulti
EXPOSE 1688/tcp

USER 65534
ENTRYPOINT ["/vlmcsdmulti"]
CMD ["vlmcsd", "-D", "-d", "-e"]
