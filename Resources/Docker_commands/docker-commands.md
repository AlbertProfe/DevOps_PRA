# Docker commands

## Overview

The Dockerfile instructions FROM, LABEL, MAINTAINER, COPY, and ENTRYPOINT serve different purposes in building Docker images:

`FROM`

Specifies the base image for subsequent instructions[6]. It's typically the first instruction in a Dockerfile and sets the starting point for the build process.

 `LABEL`

Adds metadata to an image in the form of key-value pairs[6]. It's used to organize and provide additional information about the image, such as version, description, or author[2]. For example:

```dockerfile
LABEL version="1.0.2"
LABEL org.opencontainers.image.authors="moby@example.com"
```

`MAINTAINER (Deprecated)`

The MAINTAINER instruction is deprecated and should not be used[4]. Instead, use the LABEL instruction to specify the author:

```dockerfile
LABEL org.opencontainers.image.authors="moby@example.com"
```

`COPY`

Copies files and directories from the build context to the image[6]. It's used to add application code, configuration files, and other necessary resources to the image.

`ENTRYPOINT`

Specifies the default executable for the image. It defines the command that will run when a container is started from the image. ENTRYPOINT can be used in combination with CMD to set default arguments for the specified command.

`CMD`

The CMD instruction in Docker specifies the default command to be executed when a container starts from an image. It serves several key purposes:

1. Defines the default executable for the container[3].
2. Provides a sensible default behavior that can be easily overridden[3].
3. Sets default arguments for the ENTRYPOINT process[2].

CMD can be written in two formats:

1. Shell syntax: `CMD executable parameter1 parameter2`
2. JSON array format (preferred): `CMD ["executable", "parameter1", "parameter2"]`

Key points about CMD:

- Only the last CMD instruction in a Dockerfile is effective if multiple are present[1].
- It can be overridden by providing command-line arguments when running the container with `docker run`[3][5].
- When used with ENTRYPOINT, CMD specifies the default parameters for the ENTRYPOINT process[2].

Example usage in a Dockerfile:

```dockerfile
FROM ubuntu:latest
CMD ["echo", "Hello World"]
```

This sets the default behavior of the container to print "Hello World" when started, but allows users to easily override this command if needed.

**Basic dockerifle with doocker core-commands**

```dockerfile
# Use a Java 17 base image
FROM openjdk:17-jdk-slim

# Maintainer information
MAINTAINER albertprofe

# Copy the application JAR file to the container
COPY restaurant-0.0.1-SNAPSHOT.jar restVaadin.jar

# Set the entry point to run the JAR file
ENTRYPOINT ["java", "-jar", "restVaadin.jar"]
```

Basic command to start:

```bash
docker login
docker build -t restvaadinapp .
docker run -p 8080:8080 restvaadinapp
```

Table basic commands and flags:

| Command        | Flag            | Description                                                          |
| -------------- | --------------- | -------------------------------------------------------------------- |
| `docker build` | `-t, --tag`     | Assigns a name and optionally a tag (e.g., `name:tag`) to the image. |
| `docker build` | `-f, --file`    | Specifies the Dockerfile to use if it's not named `Dockerfile`.      |
| `docker build` | `--build-arg`   | Passes build-time variables to the Dockerfile.                       |
| `docker build` | `--no-cache`    | Ignores cached layers and forces a fresh build.                      |
| `docker build` | `--target`      | Builds a specific stage in a multi-stage Dockerfile.                 |
| `docker build` | `-q, --quiet`   | Suppresses output, showing only the final image ID.                  |
| `docker run`   | `-d, --detach`  | Runs the container in detached mode (in the background).             |
| `docker run`   | `-p, --publish` | Maps container ports to host ports (e.g., `8080:80`).                |
| `docker run`   | `--name`        | Assigns a name to the container for easier reference.                |
| `docker run`   | `-e, --env`     | Sets environment variables inside the container.                     |
| `docker run`   | `--rm`          | Automatically removes the container when it exits.                   |
| `docker run`   | `-v, --volume`  | Mounts host directories or volumes into the container.               |
| `docker run`   | `--network`     | Connects the container to a specified network.                       |
| `docker run`   | `--cpus`        | Limits the number of CPUs available to the container.                |
| `docker run`   | `--memory`      | Sets a memory limit for the container.                               |

```bash
# Build a Docker image from the current directory's Dockerfile
# -t: Tag the image with the name 'myapp' and version '1.0'
docker build -t myapp:1.0 .

# Run a new container from the 'myapp' image
# -d: Run the container in detached mode (in the background)
# --name: Assign the name 'myapp_container' to the container
# -p: Map port 8080 on the host to port 80 in the container
docker run -d --name myapp_container -p 8080:80 myapp:1.0

# List all running containers
docker ps

# Show logs from 'myapp_container'
# -f: Follow log output in real-time
docker logs -f myapp_container

# Display real-time statistics for all running containers
docker stats

# Stop the 'myapp_container'
docker stop myapp_container

# Remove the stopped 'myapp_container'
docker rm myapp_container

# Remove the 'myapp' image
docker rmi myapp:1.0

# Clean up unused Docker resources (containers, networks, images)
docker system prune -f
```

## Mapping Multiple Ports

When you want to map multiple ports, you simply specify the `-p` option multiple times in your `docker run` command. Here is an example:

```bash
`docker run -d --name my_container -p 8080:80 -p 8443:443 nginx`
```

## Explanation

- **`-d`**: Runs the container in detached mode (in the background).
- **`--name my_container`**: Assigns the name `my_container` to the running container.
- **`-p 8080:80`**: Maps port 80 in the container to port 8080 on the host. This is typically used for HTTP traffic.
- **`-p 8443:443`**: Maps port 443 in the container to port 8443 on the host. This is commonly used for HTTPS traffic

## Steps to Add a User to the Docker Group

1. **Create the Docker Group (if it doesn't exist)**:- Run the following command to create the `docker` group if it hasn't been created already:bash
   
    `sudo groupadd docker`

2. **Add Your User to the Docker Group**:- Add your user to the `docker` group using the following command. Replace `${USER}` with your username if you're not using an environment variable:bash
   
    `sudo usermod -aG docker ${USER}`

3. **Apply Changes**:- Log out and log back in so that your group membership is re-evaluated.
   
   - Alternatively, you can use the following command to apply the changes without logging out:bash
     
     `newgrp docker`

4. **Verify Docker Access**:
   
   - Test your Docker setup by running a simple command like `docker ps` without `sudo`:bash
     
     `docker ps`
   
   - If this command runs successfully without errors, your setup is complete.

## Removing

The main difference between `docker rm` and `docker rmi` is:

1. `docker rm` is used to remove containers.
2. `docker rmi` is used to remove images.

`docker rmi` is an alias for `docker image rm. Both commands remove one or more images from the host node. When using `docker rmi` or ``docker image rm`:

- If an image has multiple tags, using the tag as a parameter only removes that tag.
- If the tag is the only one for the image, both the image and the tag are removed.
- You can remove an image using its short or long ID, tag, or digest.
- Using the `-f` flag with the image's ID will untag and remove all images that match the specified ID.

To remove images based on a name pattern, you can use:

```bash
docker rmi $(docker images --format '{{.Repository}}:{{.Tag}}' | grep 'imagename')
```

This command lists all images, filters those containing 'imagename', and removes them.

## Tag & push

> These commands are  used when you want to share your local Docker image on Docker Hub or another container registry. 



The tagging step prepares the image with the correct naming convention, and the push step uploads it to the remote repository.

### Example

Upload images to: https://hub.docker.com/repositories/w3564

1. `docker tag books-backend:latest w3564/books-backend:latest`

This command creates a new tag for an existing image. It takes the local image `books-backend:latest` and creates a new tag `w3564/books-backend:latest. This new tag includes the Docker Hub username `**w3564`**, which is necessary for pushing to Docker Hub.

2. `docker push w3564/books-backend:latest`

This command pushes the newly tagged image to Docker Hub. It uploads the image `w3564/books-backend:latest` to the Docker Hub repository associated with the username `w3564`.



> Remember that you need to be logged in to Docker Hub (using `docker login`) with the appropriate credentials for the `w3564` account before you can successfully push the image.
