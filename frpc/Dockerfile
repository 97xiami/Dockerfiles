FROM alpine:3.24.4@sha256:f59abe656b692d901e184be3445e084786602108599d2a51d229c0f5a48c71bf AS builder
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
