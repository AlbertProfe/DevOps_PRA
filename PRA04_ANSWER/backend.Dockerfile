FROM bellsoft/liberica-openjdk-alpine:21
# FROM openjdk:21-jdk-slim

# parameters
ARG MAINTAINER
ARG SPRING_DIR
ARG SPRING_JAR
ARG SPRING_PORT

LABEL maintainer=$MAINTAINER

COPY $SPRING_DIR/$SPRING_JAR app.jar
EXPOSE $SPRING_PORT
ENTRYPOINT ["java", "-jar", "/app.jar"]
