FROM eclipse-temurin:25

RUN apt-get update && apt-get install -y screen && rm -rf /var/lib/apt/lists/*

WORKDIR /app

ADD https://github.com/Anuken/Mindustry/releases/download/v155.4/server-release.jar /app/

EXPOSE 6567 6567/UDP

CMD ["screen", "-dmS", "server", "java", "-jar", "-XX:+HeapDumpOnOutOfMemoryError", "server-release.jar"]
