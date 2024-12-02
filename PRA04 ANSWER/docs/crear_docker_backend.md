# Crear archivo Docker en Backend

**Crear un Docker para el Backend de BooksPageable**

1. **Verificar el JDK instalado**
    
    Antes de continuar, verifica la versión del JDK en tu entorno. Para este proyecto, se utiliza **JDK 21 Amazon Corretto**, ya que en Ubuntu no está disponible la versión 23.
    
    **Nota:** Asegúrate de configurar correctamente la variable `PATH` para apuntar al JDK instalado.
    

**Instalar Maven:**

```bash
bash
Copiar código
sudo apt-get install maven

```

**Verificar la instalación de Maven:**

```bash
bash
Copiar código
mvn -version

```

**Construir el proyecto:**

Ejecuta el siguiente comando en la raíz del proyecto para generar el archivo `.jar`:

```bash
bash
Copiar código
mvn clean package

```

El archivo `.jar` se generará en el directorio `target`.



**Crear el archivo Dockerfile**

En la raíz del proyecto, crea un archivo llamado `Dockerfile` con el siguiente contenido:

```
dockerfile
Copiar código
# Usar la imagen base de Liberica OpenJDK 21 (ligera y optimizada)
FROM bellsoft/liberica-openjdk-alpine:21

# Copiar el archivo JAR de la aplicación al contenedor
COPY target/BooksPageable-0.0.1-SNAPSHOT.jar app.jar

# Exponer el puerto en el que la aplicación correrá (por defecto 8080)
EXPOSE 8080

# Comando de entrada para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "/app.jar"]

```



**Construir y ejecutar la imagen Docker**

**Construir la imagen:**

En la raíz del proyecto, ejecuta este comando para construir la imagen Docker:

```bash
bash
Copiar código
docker build -t books-pageable .

```

**Ejecutar el contenedor:**

Una vez creada la imagen, ejecuta el siguiente comando para iniciar el contenedor:

```bash
bash
Copiar código
docker run -p 8080:8080 books-pageable

```

- **Verificar la aplicación**
    
    Si todo está configurado correctamente, podrás acceder a la aplicación desde el navegador en la dirección:
    
    `http://localhost:8080`
    
    ¡Tu aplicación ahora está corriendo dentro de un contenedor Docker!
