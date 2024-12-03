# Realizar Docker Compose Backend-Frontend

Para realizar el docker compose, primero de todo deberemos descargarlo.

*# Instalar el plugin de Docker Compose*

sudo apt update
sudo apt install docker-compose-plugin

*# Usar con*

docker compose version

Docker Compose version v2.29.7

Una vez descargado, en el directorio donde tenemos los dos projectos, tanto el backend como el frontend con sus respectivas configuraciones para la build de docker, crearemos un archivo yml llamado docker-compose.yml.


en este YML añadiremos la configuracion:

version: '3.8'
services:
  backend:
    build: 
      context: /home/alex/projects/BooksPageable
      dockerfile: Dockerfile
    ports:
      - "8080:8080"
    networks:
      - library-network

  frontend:
    build: 
      context: /home/alex/projects/BooksFrontend
      dockerfile: Dockerfile
    ports:
      - "5173:80"
    networks:
      - library-network
    depends_on:
      - backend

networks:
  library-network:
    driver: bridge



Entonces, para levantar tu proyecto, ejecutarás:

```bash
bash

docker compose up --build

```

Antes de ejecutarlo, asegúrate de:

1. Estar en el directorio que contiene el `docker-compose.yml`
2. Haber empaquetado tu backend:

```bash
bash

cd /home/alex/projects/BooksPageable
mvn clean package -DskipTests

```

1. Haber compilado tu frontend:

```bash
bash

cd /home/alex/projects/BooksFrontend
npm install
npm run build

```

Luego, desde el directorio donde tengas el `docker-compose.yml`, ejecuta:

```bash
bash

docker compose up --build

```

Para detener y eliminar el Docker Compose actual, ejecuta:

```bash
bash

docker compose down

```

Esto detendrá y eliminará los contenedores, redes y volúmenes creados por el compose.

Si quieres eliminar también las imágenes creadas, puedes usar:

```bash
bash

docker compose down --rmi all

```

Para volverlo a levantar:

1. Navega al directorio donde está el archivo `docker-compose.yml`
2. Ejecuta:

```bash
bash
Copy
docker compose up

```

O si quieres reconstruir las imágenes:

bash

docker compose up --build
