ARG APP_VERSION=v1.8.0

FROM rust:1-alpine AS builder

RUN apk update \
    && apk add ca-certificates git \
    && git clone -b ${APP_VERSION} --depth=1 https://github.com/pendulum-project/ntpd-rs \
    && mv ntpd-rs /build

WORKDIR /build
COPY config.toml /build/.cargo/config.toml

ARG NTPDRS_BUILD_FEATURES=""

RUN --mount=type=cache,target=/usr/local/cargo/git/db \
    --mount=type=cache,target=/usr/local/cargo/registry \
    --mount=type=cache,target=/build/target/ \
    cargo build --locked --release --features="${NTPDRS_BUILD_FEATURES}"

FROM scratch

COPY --from=builder /build/target/release/ntp-daemon /ntp-daemon
COPY ntp.toml /ntp.toml

EXPOSE 123/udp

CMD ["/ntp-daemon", "-c", "/ntp.toml"]
