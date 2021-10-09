FROM alpine AS git
RUN apk add git \
    && git clone https://github.com/xjasonlyu/avdc-api

FROM xiami110/face
WORKDIR /app
COPY --from=git /avdc-api /app
RUN set -xe \
    && pip install --no-cache-dir -U pip \
    && pip install --no-cache-dir -r requirements.txt \
    && rm -rf requirements.txt \

ENV HTTP_PROXY=""
ENV HTTPS_PROXY=""

ENV AVDC_DATABASE=""
ENV AVDC_TOKEN=""

ENV PORT=5000
ENTRYPOINT exec python -m main -p $PORT
