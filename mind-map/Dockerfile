FROM nginx:stable-alpine

RUN apk update \
    && apk add --no-cache git \
    && git clone --single-branch --depth=1 https://github.com/wanglin2/mind-map \
    && cp mind-map/index.html /usr/share/nginx/html/ \
    && cp mind-map/nginx.conf /usr/share/nginx/html/ \
    && cp -r mind-map/dist /usr/share/nginx/html/ \
    && rm -rf mind-map \
    && apk del git
EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]
