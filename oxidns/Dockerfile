# syntax=docker/dockerfile:1

FROM rust:1.97.1-alpine@sha256:3c38f3f82c2f3d73da3b38e18d279393a04cb43ddded0e35088a8c3324d40900 AS builder
WORKDIR /build
ARG APP_VERSION="v1.5.2"
ARG APP_COMMIT="8183d0fc20192c7d713718ffdde1c6b8b6f3ec91"

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN apk add --no-cache ca-certificates tzdata git \
    && git init \
    && git remote add origin https://github.com/svenshi/oxidns.git \
    && git fetch --depth=1 origin "$APP_COMMIT" \
    && git checkout FETCH_HEAD \
    && cargo build --locked --release --no-default-features --features="standard" \
    && cp target/release/oxidns /build/oxidns

FROM node:26.7.0-alpine3.24@sha256:aadf416b2cdce311a8811ba3f0608a61b77dbf997500e2eafe781b51f6a0b019 AS webui
WORKDIR /build
ARG APP_VERSION="v1.5.2"
ARG APP_COMMIT="8183d0fc20192c7d713718ffdde1c6b8b6f3ec91"

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
COPY --from=builder --chown=1000:1000 --chmod=500 /build/oxidns /oxidns
COPY --chown=1000:1000 --chmod=400 config.yaml /config.yaml
COPY --from=webui --chown=1000:1000 /build/webui/out /webui

USER 1000:1000
EXPOSE 53/udp
EXPOSE 9199/tcp
ENTRYPOINT ["/oxidns"]
CMD ["start", "-c", "/config.yaml", "-d", "/"]
