# Dockerize React app

## Step 0: create the build

If you used `create-react-app` to set up your project, you can build it using the following command (with Vite projects works as well):

```bash
npm run build
```

**Verify the Build**

After running the build command, you should see a `build`/ `dist` folder in your project directory. This folder contains the optimized and minified files ready for deployment.

After running the build command, you should see a `dist` folder in your project directory. This folder contains the optimized and minified files ready for deployment.

## Step 1: Structure Your Project

Ensure your project directory structure includes the `dist` folder within the build context. Here is an example structure:

```dockerfile
/home/albert/MyProjects/Sandbox/docker-sandbox
├── app3.dockerfile
├── books-frontend
    └── dist
        ├── index.html
        ├── assets
        │   ├── index-kQJbKSsj.css
        │   └── index-CO1OO85Z.js
        └── ... other files ...
```

## Step 2: dockerfile

Here is an example of what the `Dockerfile` should contain:

```dockerfile
# Use an official lightweight Nginx image
FROM nginx:alpine

# Set the working directory to /usr/share/nginx/html
WORKDIR /usr/share/nginx/html

# Copy the static files from the dist directory to the container
COPY books-frontend/dist .

# Expose port 80 for the web server
EXPOSE 80

# Command to run when the container starts
CMD ["nginx", "-g", "daemon off;"]
```

## Step 3: build and run

Navigate to the root directory of your project and run the following command to build the Docker image:

```bash
docker build -f app3.dockerfile -t books-frontend .
```

Once the image is built, you can run a container based on this image using the following command:

```bash
docker run -d -p 80:80 books-frontend
```

## Step 4: manage the docker images

![](https://raw.githubusercontent.com/AlbertProfe/DevOps_PRA/6e2d40fa94eddec7ca2c12578b3df339c39ceedf/Resources/React_projects/docker_cli_screenshots/2024-11-27-18-27-00-image.png)

![](https://raw.githubusercontent.com/AlbertProfe/DevOps_PRA/6e2d40fa94eddec7ca2c12578b3df339c39ceedf/Resources/React_projects/docker_cli_screenshots/2024-11-27-18-28-12-image.png)

![](https://raw.githubusercontent.com/AlbertProfe/DevOps_PRA/6e2d40fa94eddec7ca2c12578b3df339c39ceedf/Resources/React_projects/docker_cli_screenshots/2024-11-27-18-27-52-image.png)
