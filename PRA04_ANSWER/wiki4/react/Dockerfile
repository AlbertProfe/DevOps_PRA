# Use an official lightweight Nginx image
FROM nginx:alpine

# Set the working directory to /usr/share/nginx/html
WORKDIR /usr/share/nginx/html

# Copy the static files from the dist directory to the container
COPY ./dist .

# Expose port 80 for the web server
EXPOSE 80

# Command to run when the container starts
CMD ["nginx", "-g", "daemon off;"]
