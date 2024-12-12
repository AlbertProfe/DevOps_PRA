docker# Use a Java 17 base image
FROM openjdk:17-jdk-slim

# Maintainer information
MAINTAINER albertprofe

# Copy the application JAR file to the container
COPY restaurant-0.0.1-SNAPSHOT.jar restVaadin.jar

# Set the entry point to run the JAR file
ENTRYPOINT ["java", "-jar", "restVaadin.jar"]
