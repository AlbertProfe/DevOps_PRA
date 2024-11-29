# FROM openjdk:21-jdk-slim
FROM bellsoft/liberica-openjdk-alpine:21

# parameters
ARG SPRING_DIR
ARG SPRING_JAR
ENV ENV_SPRING_DIR=$SPRING_DIR
ENV ENV_SPRING_JAR=$SPRING_JAR

LABEL maintainer="jc-programs"
COPY $ENV_SPRING_DIR/$ENV_SPRING_JAR.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
