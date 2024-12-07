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
