ARG RUST_VERSION=1

FROM rust:${RUST_VERSION}-alpine AS builder

# Use a shell that exists whenever it encounters errors
SHELL ["/bin/bash", "-xo", "pipefail", "-c"]

# Install OS dependencies
RUN apt update \
    && apt install -y --no-install-recommends \
        ca-certificates git\
    && rm -rf /var/lib/apt/lists/* /tmp/* \
    && git clone --single-branch --depth=1 https://github.com/pendulum-project/ntpd-rs \
    && mv ntpd-rs /build

WORKDIR /build
COPY config.toml /build/.cargo/config.toml

ARG NTPDRS_BUILD_FEATURES=""
ENV NTPDRS_BUILD_FEATURES="${NTPDRS_BUILD_FEATURES}"

# Run the build command.
# Note that this mounts several cache directories to speed up subsequent builds.
# After build, we move the binaries out of the target directory because that directory
# will not be available in the next steps (as it is a cached directory).
RUN --mount=type=cache,target=/usr/local/cargo/git/db \
    --mount=type=cache,target=/usr/local/cargo/registry \
    --mount=type=cache,target=/build/target/ \
    cargo build --locked --release --features="${NTPDRS_BUILD_FEATURES}" \
    && mkdir -p /build/artifacts \
    && cp target/release/ntp-daemon /build/artifacts \
    && cp target/release/ntp-ctl /build/artifacts \
    && cp target/release/ntp-metrics-exporter /build/artifacts

# Setup the final actual runner image stage
FROM alpine

COPY --from=builder /build/artifacts/ntp-daemon /usr/local/bin/ntp-daemon
COPY --from=builder /build/artifacts/ntp-ctl /usr/local/bin/ntp-ctl
COPY --from=builder /build/artifacts/ntp-metrics-exporter /usr/local/bin/ntp-metrics-exporter

CMD ["/usr/local/bin/ntp-daemon"]
