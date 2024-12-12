FROM alpine:latest AS builder
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
