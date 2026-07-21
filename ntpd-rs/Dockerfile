FROM rust:1.97.0-alpine@sha256:ec9c91e77119ce498cd1e87d96d77e0f75b2cee21655a29bc2bf75a51a2b20a4 AS builder

ARG APP_VERSION="v1.9.0"

RUN apk add --no-cache ca-certificates git tzdata\
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
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
COPY --from=builder /build/ntp-daemon /ntp-daemon
COPY ntp.toml /ntp.toml

ENV TZ=Asia/Shanghai
EXPOSE 123/udp
ENTRYPOINT ["/ntp-daemon"]
CMD ["-c", "/ntp.toml"]
