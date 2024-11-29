# FROM openjdk:21-jdk-slim
FROM bellsoft/liberica-openjdk-alpine:21

# parameters
ARG springFolder
ARG springJar
ENV env_springFolder=$springFolder
ENV env_springJar=$springJar

LABEL maintainer="jc-programs"
COPY $env_springFolder/$env_springJar.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
