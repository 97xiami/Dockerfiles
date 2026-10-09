FROM alpine:3.24.2@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6 AS builder
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
