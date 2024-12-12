FROM alpine:latest AS builder
WORKDIR /aria
COPY install.sh /aria

RUN apk update \
    && apk add --no-cache ca-certificates curl bash \
    && chmod a+x install.sh \
    && bash install.sh

FROM nginx:stable-alpine
COPY --from=builder /aria/ /usr/share/nginx/html/

ENTRYPOINT ["nginx", "-g", "daemon off;"]
