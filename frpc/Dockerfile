FROM alpine:3.24.2@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6 AS builder
WORKDIR /build

COPY install.sh /build
RUN apk update \
    && apk add --no-cache ca-certificates curl bash \
    && cd /build \
    && chmod +x install.sh \
    && bash install.sh

FROM scratch
COPY --from=builder /build/frpc /usr/bin/
COPY --from=builder /build/frpc.toml /etc/frp/frpc.toml

ENTRYPOINT ["frpc", "-c", "/etc/frp/frpc.toml"]
