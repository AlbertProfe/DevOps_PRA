FROM openjdk:21-slim

WORKDIR /app

COPY target/*.jar app.jar

EXPOSE 8088

CMD ["java", "-jar", "app.jar", "--server.port=8088"]