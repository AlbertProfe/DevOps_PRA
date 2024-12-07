# Usamos la imagen base de Liberica OpenJDK 21 (una variante más ligera de Alpine)
FROM bellsoft/liberica-openjdk-alpine:21

# Copiamos el archivo JAR de la aplicación al contenedor
COPY target/BooksPageable-0.0.1-SNAPSHOT.jar app.jar

# Exponemos el puerto en el que la aplicación Spring Boot correrá (por defecto 8080)
EXPOSE 8080

# Comando de entrada para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "/app.jar"]