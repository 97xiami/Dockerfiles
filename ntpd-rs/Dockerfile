FROM rust:1.95.0-alpine AS builder

ARG APP_VERSION="v1.8.0"

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

FROM alpine:3.23
WORKDIR /app
COPY --from=builder /build/ntp-ctl ./ntp-ctl
COPY --from=builder /build/ntp-daemon ./ntp-daemon
COPY --from=builder /build/ntp-metrics-exporter ./ntp-metrics-exporter
COPY  ntp.toml ./ntp.toml

RUN apk add --no-cache libcap \
    && rm -rf /var/cache/apk/* \
    && addgroup -S ntpd-rs \
    && adduser -S -G ntpd-rs -H ntpd-rs \
    && setcap cap_sys_time+ep ./ntp-ctl \
    && setcap cap_sys_time+ep ./ntp-daemon \
    && setcap cap_sys_time+ep ./ntp-metrics-exporter \
    && chown -R ntpd-rs:ntpd-rs ./

USER ntpd-rs
ENV TZ=Asia/Shanghai
EXPOSE 123/udp
ENTRYPOINT ["./ntp-daemon"]
CMD ["-c", "./ntp.toml"]
