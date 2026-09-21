FROM eclipse-temurin:25@sha256:e787e08ef76f4c16866108cd7f9fcd96a68eef3ac6cc76866897d4d02d5a2262

RUN apt-get update && \
    apt-get install -y screen tzdata && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apk/*

WORKDIR /app
ARG APP_VERSION="v160.5"
ARG APP_COMMIT="067c720a8817c1c9fb586c03898a7d948caaed56"
ADD https://github.com/Anuken/Mindustry/releases/download/${APP_VERSION}/server-release.jar /app/
COPY start.sh /app/

ENV TZ=Asia/Shanghai
EXPOSE 6567 6567/UDP

RUN chmod +x start.sh
CMD ["./start.sh"]
