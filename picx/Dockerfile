FROM node:lts-alpine as builder
WORKDIR /build
RUN apk update \
    && apk add git \
    && git clone --single-branch --depth=1 https://github.com/XPoet/picx \
    && cd picx \
    && npm install \
    && npm run build

FROM nginx:stable-alpine
COPY --from=builder /build/picx/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx","-g", "daemon off;"]
