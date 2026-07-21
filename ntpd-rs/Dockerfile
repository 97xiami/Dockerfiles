FROM rust:1.97.0-alpine@sha256:ec9c91e77119ce498cd1e87d96d77e0f75b2cee21655a29bc2bf75a51a2b20a4 AS builder

ARG APP_VERSION="v1.9.0"

RUN apk add --no-cache ca-certificates git libcap \
    && git clone --depth=1 --branch ${APP_VERSION} --single-branch https://github.com/pendulum-project/ntpd-rs \
    && mv ntpd-rs /build

WORKDIR /build
COPY config.toml /build/.cargo/config.toml

ARG NTPDRS_BUILD_FEATURES=""

RUN --mount=type=cache,target=/usr/local/cargo/git/db \
    --mount=type=cache,target=/usr/local/cargo/registry \
    --mount=type=cache,target=/build/target/ \
    cargo build --locked --release --features="${NTPDRS_BUILD_FEATURES}" --bin ntp-daemon \
    && cp target/release/ntp-daemon /build/ntp-daemon \
    && setcap 'cap_net_bind_service=+ep' /build/ntp-daemon \
    && tar --xattrs -cf /build/ntp-daemon.tar -C /build ntp-daemon

FROM scratch
ADD --chown 65534:65534 /build/ntp-daemon.tar /
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY ntp.toml /ntp.toml

ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
EXPOSE 123/udp
USER 65534
ENTRYPOINT ["/ntp-daemon"]
CMD ["-c", "/ntp.toml"]
