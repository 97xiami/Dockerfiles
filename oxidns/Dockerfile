# syntax=docker/dockerfile:1

FROM rust:1.97.0-alpine@sha256:ec9c91e77119ce498cd1e87d96d77e0f75b2cee21655a29bc2bf75a51a2b20a4 AS builder
WORKDIR /build
ARG APP_VERSION="v1.5.1"
ARG APP_COMMIT="5356dc7084b427f5a18cbf72572e4677e69d5b6e"

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN apk add --no-cache ca-certificates tzdata git upx \
    && git init \
    && git remote add origin https://github.com/svenshi/oxidns.git \
    && git fetch --depth=1 origin "$APP_COMMIT" \
    && git checkout FETCH_HEAD \
    && cargo build --locked --release --no-default-features --features="standard" \
    && upx -q --best --lzma target/release/oxidns -o /build/oxidns

FROM --platform=$BUILDPLATFORM node:26.5.0-alpine3.24@sha256:e88a35be04478413b7c71c455cd9865de9b9360e1f43456be5951032d7ac1a66 AS webui
WORKDIR /build
ARG APP_VERSION="v1.5.1"
ARG APP_COMMIT="5356dc7084b427f5a18cbf72572e4677e69d5b6e"

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN apk add --no-cache git \
    && git init \
    && git remote add origin https://github.com/svenshi/oxidns.git \
    && git fetch --depth=1 origin "$APP_COMMIT" \
    && git checkout FETCH_HEAD \
    && cd webui \
    && npm install -g pnpm@latest \
    && pnpm install --frozen-lockfile --ignore-scripts \
    && pnpm rebuild msw sharp unrs-resolver \
    && pnpm build

FROM scratch
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
COPY --from=builder /tmp /tmp
COPY --from=builder /build/oxidns /oxidns
COPY config.yaml /config.yaml
COPY --from=webui /build/webui/out /webui

USER 65534
EXPOSE 53/udp
EXPOSE 9199/tcp
ENTRYPOINT ["/oxidns"]
CMD ["start", "-c", "/config.yaml", "-d", "/"]
