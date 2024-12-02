# Crear archivo Docker en Frontend

El frontend se construye utilizando Node.js y Vite para la creación de la aplicación, y Nginx para servir los archivos estáticos.

### **1.1. Crear el Dockerfile**

En la raíz del proyecto **BooksFrontend**, crea un archivo llamado `Dockerfile` con el siguiente contenido:

```
dockerfile
Copiar código
# Usa una imagen base de Node.js para construir la aplicación
FROM node:18 AS build

# Define el directorio de trabajo
WORKDIR /app

# Copia el package.json y el package-lock.json (o yarn.lock)
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia el código fuente del frontend
COPY . .

# Construye la aplicación Vite
RUN npm run build

# Usa una imagen base de Nginx para servir los archivos estáticos
FROM nginx:alpine

# Copia los archivos generados en la fase anterior al contenedor Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Expone el puerto 80 para servir la aplicación
EXPOSE 80

# Comando para iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]

```

---


### **1.2. Construir la imagen Docker**

Ejecuta los siguientes comandos en la raíz del proyecto **BooksFrontend** para construir y ejecutar el contenedor:

1. **Construir la imagen Docker:**
    
    ```bash
    bash
    
    docker build -t books-frontend .
    
    ```
    
2. **Ejecutar el contenedor:**
    
    ```bash
    bash
    
    docker run -d --name books-frontend -p 80:80 books-frontend
    
    ```
    
    Esto ejecutará la aplicación en el puerto `80`. Podrás acceder a ella desde tu navegador en `http://localhost`.
    
3. **Verificar los contenedores en ejecución:**

    bash

    docker ps

