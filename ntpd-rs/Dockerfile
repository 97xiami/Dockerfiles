# syntax=docker/dockerfile:1

FROM alpine:3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b AS libcap
WORKDIR /build
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN apk add --no-cache git make build-base bash linux-headers \
    && git clone https://git.kernel.org/pub/scm/libs/libcap/libcap.git \
    && cd libcap \
    && make -C libcap \
    && gcc -static -I libcap/include progs/setcap.c libcap/libcap.a -o setcap

FROM rust:1.97.0-alpine@sha256:ec9c91e77119ce498cd1e87d96d77e0f75b2cee21655a29bc2bf75a51a2b20a4 AS builder
WORKDIR /build
ARG REPO="pendulum-project/ntpd-rs.git"
ARG APP_VERSION="v1.9.0"
ARG APP_COMMIT="46ec9bb4d5b6cb24f814f5543d85b9138afb4cba"

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN apk add --no-cache ca-certificates git libcap \
    && git init \
    && git remote add origin https://github.com/$REPO \
    && git fetch --depth=1 origin "$APP_COMMIT" \
    && git checkout FETCH_HEAD \
    && sed -i "s/^debug = 2/strip = \"symbols\"\ncodegen-units = 1/" Cargo.toml \
    && rm -rf .cargo \
    && cargo build --locked --release --bin ntp-daemon \
    && cp target/release/ntp-daemon /build/ntp-daemon

FROM gcr.io/distroless/static-debian13:nonroot@sha256:f7f8f729987ad0fdf6b05eeeae94b26e6a0f613bdf46feea7fc40f7bd72953e6
COPY --from=builder /build/ntp-daemon /usr/local/bin/ntp-daemon
COPY ntp.toml /ntp.toml

COPY --chmod=755 --from=libcap /build/libcap/setcap /setcap

RUN ["/setcap", "cap_sys_time=+ep", "/ntp-daemon"]

EXPOSE 123/udp
ENTRYPOINT ["/ntp-daemon"]
CMD ["-c", "/ntp.toml"]
