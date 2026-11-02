# syntax=docker/dockerfile:1

FROM alpine:3.24.3@sha256:be2656061b536c1883c4034790e21d0a09c5aaaf51968b89368a3c0371ea2c9a AS libcap
WORKDIR /build
ARG LIBCAP_VERSION="v1.2.78"
ARG LIBCAP_COMMIT="06F4A09B9813579cbbfBC4138464f79870D8021d"

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN apk add --no-cache git make build-base bash linux-headers \
    && git init \
    && git remote add origin https://git.kernel.org/pub/scm/libs/libcap/libcap.git \
    && git fetch --depth=1 origin "$LIBCAP_COMMIT" \
    && git checkout FETCH_HEAD \
    && make -C libcap \
    && gcc -static -I libcap/include progs/setcap.c libcap/libcap.a -o setcap

FROM rust:1.99.0-alpine@sha256:0cce0a5e0e8ba67b455257a3a02a1d99005f382748789d6464460028810f1627 AS builder
WORKDIR /build
ARG APP_VERSION="v1.9.0"
ARG APP_COMMIT="46ec9bb4d5b6cb24f814f5543d85b9138afb4cba"

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN apk add --no-cache ca-certificates git \
    && git init \
    && git remote add origin https://github.com/pendulum-project/ntpd-rs.git \
    && git fetch --depth=1 origin "$APP_COMMIT" \
    && git checkout FETCH_HEAD \
    && sed -i "s/^debug = 2/strip = \"symbols\"\ncodegen-units = 1/" Cargo.toml \
    && rm -rf .cargo \
    && cargo build --locked --release --bin ntp-daemon \
    && cp target/release/ntp-daemon /build/ntp-daemon

FROM scratch
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder --chown=1000:1000 --chmod=500 build/ntp-daemon /ntp-daemon
COPY --chown=1000:1000 --chmod=400 ntp.toml /ntp.toml

USER 0
RUN --mount=type=bind,from=libcap,source=/build/setcap,target=/setcap \
    ["/setcap", "cap_sys_time=+ep", "/ntp-daemon"]

USER 1000:1000
EXPOSE 123/udp
ENTRYPOINT ["/ntp-daemon"]
CMD ["-c", "/ntp.toml"]
