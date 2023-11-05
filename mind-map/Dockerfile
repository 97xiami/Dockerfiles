FROM nginx:stable-alpine
RUN apk update \
    && apk add git \
    && git clone --single-branch --depth=1 https://github.com/wanglin2/mind-map \
    && mv -r mind-map /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
