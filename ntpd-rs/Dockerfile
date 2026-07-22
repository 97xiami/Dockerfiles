FROM rust:1.97.0-alpine@sha256:ec9c91e77119ce498cd1e87d96d77e0f75b2cee21655a29bc2bf75a51a2b20a4 AS builder
WORKDIR /build
ARG REPO="pendulum-project/ntpd-rs.git"
ARG APP_VERSION="v1.9.0"
ARG APP_COMMIT="46ec9bb4d5b6cb24f814f5543d85b9138afb4cba"

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN apk add --no-cache ca-certificates git \
    && git init \
    && git remote add origin https://github.com/$REPO \
    && git fetch --depth=1 origin "$APP_COMMIT" \
    && git checkout FETCH_HEAD \
    && sed -i "s/^debug = 2/#debug = 2/" Cargo.toml \
    && cargo build --locked --release \
    && cp target/release/ntp-ctl /build/ntp-ctl \
    && cp target/release/ntp-daemon /build/ntp-daemon \
    && cp target/release/ntp-metrics-exporter /build/ntp-metrics-exporter

FROM alpine:3.24.1@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b
COPY --from=builder /build/ntp-ctl /usr/local/bin/ntp-ctl
COPY --from=builder /build/ntp-daemon /usr/local/bin/ntp-daemon
COPY --from=builder /build/ntp-metrics-exporter /usr/local/bin/ntp-metrics-exporter
COPY ntp.toml /ntp.toml

RUN apk add --no-cache ca-certificates libcap \
    && addgroup -S ntpd-rs \
    && adduser -S ntpd-rs -G ntpd-rs \
    && chown ntpd-rs:ntpd-rs /usr/local/bin/ntp-ctl /usr/local/bin/ntp-daemon /usr/local/bin/ntp-metrics-exporter \
    && setcap cap_sys_time=+ep /usr/local/bin/ntp-daemon \
    && mkdir /var/run/ntpd-rs \
    && chown ntpd-rs:ntpd-rs /var/run/ntpd-rs \
    && chmod 750 /var/run/ntpd-rs

USER ntpd-rs
EXPOSE 123/udp
ENTRYPOINT ["ntp-daemon"]
CMD ["-c", "/ntp.toml"]
