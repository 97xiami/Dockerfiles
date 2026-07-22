FROM rust:1.97.0-alpine@sha256:ec9c91e77119ce498cd1e87d96d77e0f75b2cee21655a29bc2bf75a51a2b20a4 AS builder

ARG REPO="pendulum-project/ntpd-rs"
ARG APP_VERSION="test"
ARG APP_COMMIT="test"

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

RUN cargo build --locked --release --no-default-features --features="aws-lc,rustcrypto" --bin ntp-daemon \
    && cp target/release/ntp-daemon /build/ntp-daemon

FROM scratch
COPY --from=builder /build/ntp-daemon /ntp-daemon
COPY ntp.toml /ntp.toml

EXPOSE 123/udp
ENTRYPOINT ["/ntp-daemon"]
CMD ["-c", "/ntp.toml"]
