FROM rust:1.97.0-alpine@sha256:ec9c91e77119ce498cd1e87d96d77e0f75b2cee21655a29bc2bf75a51a2b20a4 AS builder

ARG REPO="pendulum-project/ntpd-rs"
ARG APP_VERSION="v1.9.0"
ARG APP_COMMIT="46ec9bb4d5b6cb24f814f5543d85b9138afb4cba"

RUN apk add --no-cache ca-certificates git \
    && git init code \
    && cd code \
    && git remote add origin https://github.com/$REPO.git \
    && git fetch --depth=1 origin "$APP_COMMIT" \
    && git checkout FETCH_HEAD \
    && cd .. \
    && mv code /build

WORKDIR /build
COPY config.toml /build/.cargo/config.toml

RUN cargo build --locked --release --no-default-features --features="aws-lc,rustcrypto" \
    && cp target/release/ntp-ctl /build/ntp-ctl \
    && cp target/release/ntp-daemon /build/ntp-daemon \
    && cp target/release/ntp-metrics-exporter /build/ntp-metrics-exporter

FROM alpine:3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b
COPY --from=builder /build/ntp-ctl /usr/local/bin/ntp-ctl
COPY --from=builder /build/ntp-daemon /usr/local/bin/ntp-daemon
COPY --from=builder /build/ntp-metrics-exporter /usr/local/bin/ntp-metrics-exporter
COPY ntp.toml /ntp.toml

RUN apk add --no-cache ca-certificates tzdata \
    && addgroup -S ntpd-rs \
    && adduser -S ntpd-rs -G ntpd-rs

USER ntpd-rs
EXPOSE 123/udp
ENTRYPOINT ["ntp-daemon"]
CMD ["-c", "/ntp.toml"]
