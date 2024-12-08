FROM bellsoft/liberica-openjdk-alpine:21
# FROM openjdk:21-jdk-slim
COPY backend/BooksPageable-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app.jar"]
