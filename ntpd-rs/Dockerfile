# syntax=docker/dockerfile:1

FROM alpine:3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b AS libcap
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

FROM rust:1.97.0-alpine@sha256:ec9c91e77119ce498cd1e87d96d77e0f75b2cee21655a29bc2bf75a51a2b20a4 AS builder
WORKDIR /build
ARG APP_VERSION="v1.9.0"
ARG APP_COMMIT="46ec9bb4d5b6cb24f814f5543d85b9138afb4cba"

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN apk add --no-cache ca-certificates git upx \
    && git init \
    && git remote add origin https://github.com/pendulum-project/ntpd-rs.git \
    && git fetch --depth=1 origin "$APP_COMMIT" \
    && git checkout FETCH_HEAD \
    && sed -i "s/^debug = 2/strip = \"symbols\"\ncodegen-units = 1/" Cargo.toml \
    && rm -rf .cargo \
    && cargo build --locked --release --bin ntp-daemon \
    && upx -q --best --lzma target/release/ntp-daemon -o /build/ntp-daemon

FROM scratch
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /build/ntp-daemon /ntp-daemon
COPY ntp.toml /ntp.toml

USER 0
RUN --mount=type=bind,from=libcap,source=/build/setcap,target=/setcap \
    ["/setcap", "cap_sys_time=+ep", "/ntp-daemon"]

USER 65534
EXPOSE 123/udp
ENTRYPOINT ["/ntp-daemon"]
CMD ["-c", "/ntp.toml"]
