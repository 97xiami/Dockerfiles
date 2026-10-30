# syntax=docker/dockerfile:1

FROM rust:1.99.0-alpine@sha256:0cce0a5e0e8ba67b455257a3a02a1d99005f382748789d6464460028810f1627 AS builder
WORKDIR /build
ARG APP_VERSION="v1.6.1"
ARG APP_COMMIT="f9019c6f823731f7bd090102aa31327dafdecbf4"

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN apk add --no-cache ca-certificates tzdata git \
    && git init \
    && git remote add origin https://github.com/svenshi/oxidns.git \
    && git fetch --depth=1 origin "$APP_COMMIT" \
    && git checkout FETCH_HEAD \
    && cargo build --locked --release --no-default-features --features="standard" \
    && cp target/release/oxidns /build/oxidns

FROM node:26.10.0-alpine3.24@sha256:0b36e8c136b94cd4fcf02188228e76c31ad5872eef3fec8cbd2eee500cfd9e80 AS webui
WORKDIR /build
ARG APP_VERSION="v1.6.1"
ARG APP_COMMIT="f9019c6f823731f7bd090102aa31327dafdecbf4"

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
