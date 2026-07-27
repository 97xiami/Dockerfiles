FROM eclipse-temurin:25@sha256:201fbb8886b2d273218aa3a192f0afbf7b5ff65ee8cc6ef47f5dce2171f013ea

RUN apt-get update && \
    apt-get install -y screen tzdata && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apk/*

WORKDIR /app
ARG APP_VERSION="v159.7"
ARG APP_COMMIT="c9686eb5d0ae5dd47ee02c40f99f7d5018ccbc8c"
ADD https://github.com/Anuken/Mindustry/releases/download/${APP_VERSION}/server-release.jar /app/
COPY start.sh /app/

ENV TZ=Asia/Shanghai
EXPOSE 6567 6567/UDP

RUN chmod +x start.sh
CMD ["./start.sh"]
