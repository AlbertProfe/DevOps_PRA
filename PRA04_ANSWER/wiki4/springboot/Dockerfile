# Use a Java 21 base image
FROM openjdk:21-jdk-slim

# Maintainer information
MAINTAINER albertprofe

# Copy the application JAR file to the container
COPY BooksPageable-0.0.4-SNAPSHOT.jar books.jar

# Set the entry point to run the JAR file
ENTRYPOINT ["java", "-jar", "books.jar"]
