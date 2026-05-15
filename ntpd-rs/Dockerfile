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
    && cp target/release/ntp-daemon /build

FROM gcr.io/distroless/static:debug-nonroot

COPY --from=builder --chown=65532:65532 /build/ntp-daemon /ntp-daemon
COPY --chown=65532:65532 ntp.toml /ntp.toml

ENV TZ=Asia/Shanghai
EXPOSE 123/udp
USER nonroot
ENTRYPOINT ["/ntp-daemon"]
CMD ["-c", "/ntp.toml"]
