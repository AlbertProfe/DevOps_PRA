# Use an official lightweight Nginx image
FROM nginx:alpine

# Set the working directory to /usr/share/nginx/html
WORKDIR /usr/share/nginx/html

# Copy the static files from the dist directory to the container
COPY dist .


# Exponer el puerto 80 (puerto de Nginx)
EXPOSE 80

# Usar Nginx como servidor para servir la app
CMD ["nginx", "-g", "daemon off;"]
