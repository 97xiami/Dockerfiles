FROM rust:1.96.1-alpine@sha256:a41f7740f8b45d45795624eec13a8b42263cc700f19f7e4e86e04d3dda08a479 AS builder

ARG APP_VERSION="v1.9.0"

RUN apk add --no-cache ca-certificates git \
    && rm -rf /var/cache/apk/* \
    && git clone --depth=1 --branch ${APP_VERSION} --single-branch https://github.com/pendulum-project/ntpd-rs \
    && mv ntpd-rs /build

WORKDIR /build
COPY config.toml /build/.cargo/config.toml

ARG NTPDRS_BUILD_FEATURES=""

RUN --mount=type=cache,target=/usr/local/cargo/git/db \
    --mount=type=cache,target=/usr/local/cargo/registry \
    --mount=type=cache,target=/build/target/ \
    cargo build --locked --release --features="${NTPDRS_BUILD_FEATURES}" \
    && cp target/release/ntp-ctl /build \
    && cp target/release/ntp-daemon /build \
    && cp target/release/ntp-metrics-exporter /build

FROM scratch
COPY --from=builder /build/ntp-daemon /ntp-daemon
COPY ntp.toml /ntp.toml

EXPOSE 123/udp
ENTRYPOINT ["/ntp-daemon"]
CMD ["-c", "/ntp.toml"]
