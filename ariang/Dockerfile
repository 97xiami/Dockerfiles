FROM alpine:latest AS builder
WORKDIR /aria
COPY install.sh /aria

RUN apk update \
    && apk add bash \
    && chmod a+x install.sh \
    && bash install.sh

FROM nginx:stable-alpine
COPY --from=builder /aria/AriaNG/* /usr/share/nginx/html
EXPOSE 6880

ENTRYPOINT ["nginx", "-g", "daemon off;"]
