FROM alpine:latest AS builder
WORKDIR /build
RUN apk update \
    && apk add --no-cache git make build-base \
    && git clone --single-branch https://github.com/Wind4/vlmcsd \
    && cd vlmcsd \
    && make \
    && chmod +x bin/vlmcs bin/vlmcsd

FROM alpine:latest
COPY --from=builder /build/vlmcsd/bin/vlmcs /usr/bin/
COPY --from=builder /build/vlmcsd/bin/vlmcsd /usr/bin/
EXPOSE 1688/tcp
ENTRYPOINT ["vlmcsd", "-D", "-d", "-e"]
