FROM rust:1.97.0-alpine@sha256:ec9c91e77119ce498cd1e87d96d77e0f75b2cee21655a29bc2bf75a51a2b20a4 AS builder

ARG APP_VERSION="v1.9.0"
ARG APP_COMMIT="46ec9bb4d5b6cb24f814f5543d85b9138afb4cba"

RUN apk add --no-cache ca-certificates git \
    && git clone --depth=1 --branch ${APP_VERSION} --single-branch https://github.com/pendulum-project/ntpd-rs \
    && mv ntpd-rs /build

WORKDIR /build
COPY config.toml /build/.cargo/config.toml

RUN cargo build --locked --release --no-default-features --features="aws-lc,rustcrypto" --bin ntp-daemon \
    && cp target/release/ntp-daemon /build/ntp-daemon

FROM scratch
COPY --from=builder /build/ntp-daemon /ntp-daemon
COPY ntp.toml /ntp.toml

EXPOSE 123/udp
ENTRYPOINT ["/ntp-daemon"]
CMD ["-c", "/ntp.toml"]
