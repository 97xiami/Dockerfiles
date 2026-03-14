FROM eclipse-temurin:25

RUN apt-get update && apt-get install -y screen && rm -rf /var/lib/apt/lists/*

WORKDIR /app
ARG VERSION="v155.3"
ADD https://github.com/Anuken/Mindustry/releases/download/${VERSION}/server-release.jar /app/
COPY start.sh /app/

EXPOSE 6567 6567/UDP

RUN chmod +x start.sh
CMD ["./start.sh"]
