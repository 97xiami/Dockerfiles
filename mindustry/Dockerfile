FROM eclipse-temurin:25@sha256:c42fecf62f32725c65cfea284c012526d6fb31cc78123c740ebdc1cfd2dced12

RUN apt-get update && \
    apt-get install -y screen tzdata && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apk/*

WORKDIR /app
ARG APP_VERSION="v160.1"
ARG APP_COMMIT="84cdf2bbfeeee981ff9922f5872b16433591da7b"
ADD https://github.com/Anuken/Mindustry/releases/download/${APP_VERSION}/server-release.jar /app/
COPY start.sh /app/

ENV TZ=Asia/Shanghai
EXPOSE 6567 6567/UDP

RUN chmod +x start.sh
CMD ["./start.sh"]
