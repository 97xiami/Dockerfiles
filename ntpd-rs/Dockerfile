FROM rust:1.97.0-alpine@sha256:ec9c91e77119ce498cd1e87d96d77e0f75b2cee21655a29bc2bf75a51a2b20a4 AS builder
WORKDIR /build
ARG REPO="pendulum-project/ntpd-rs.git"
ARG APP_VERSION="v1.9.0"
ARG APP_COMMIT="46ec9bb4d5b6cb24f814f5543d85b9138afb4cba"

RUN apk add --no-cache ca-certificates git \
    && git init \
    && git remote add origin https://github.com/$REPO \
    && git fetch --depth=1 origin "$APP_COMMIT" \
    && git checkout FETCH_HEAD \
    && cargo build --locked --release --no-default-features --features="aws-lc,rustcrypto" --target x86_64-unknown-linux-musl --bin ntp-daemon \
    && cp target/release/ntp-daemon /build/ntp-daemon

FROM scratch
COPY --from=builder /build/ntp-daemon /ntp-daemon
COPY ntp.toml /ntp.toml

USER 65534
EXPOSE 123/udp
ENTRYPOINT ["/ntp-daemon"]
CMD ["-c", "/ntp.toml"]
