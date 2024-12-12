# docker run

## first container

![](https://github.com/AlbertProfe/DevOps_PRA/blob/master/Resources/Docker_commands/docker-run.png)

```bash
docker run -d -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --name jenkins jenkins/jenkins:lts
```

This command creates and runs a new Jenkins container:

- `-d`: Runs the container in detached mode (in the background)
- `-p 8080:8080`: Maps port 8080 from the container to port 8080 on the host
- `-p 50000:50000`: Maps port 50000 from the container to port 50000 on the host
- `-v jenkins_home:/var/jenkins_home`: Creates a volume named jenkins_home and mounts it to /var/jenkins_home in the container
- `-v /var/run/docker.sock:/var/run/docker.sock`: Mounts the Docker socket from the host to the container
- `--name jenkins`: Names the container "jenkins"
- `jenkins/jenkins:lts`: Specifies the Jenkins LTS image to use

### docker create

> We can use the `docker create` command instead of `docker run`.

The `docker create` command creates a new container from the specified image without starting it. 

```bash
docker create -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --name jenkins jenkins/jenkins:lts
```

This command will create a new container with the specified configuration but won't start it. The container will be in a "**Created**" state, and you can later start it using the `docker start` command.

Key differences from the original `docker run` command:

1. `docker create` is used instead of `docker run`
2. The `-d` (detach) flag is removed as it's not needed for container creation

After creating the container, you can start it when needed using:

```bash
docker start jenkins
```

This approach allows you to set up the container configuration ahead of time without introducing any side effects from starting the container immediately.

```bash
docker create -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --name jenkins jenkins/jenkins:lts
```

## second container

This setup creates a Jenkins instance with persistent storage and Docker capabilities, accessible via port 9090 on the host machine:

-  `-v jenkins_home:/var/jenkins_home`: Mount the Docker volume named 'jenkins_home' to /var/jenkins_home in the container. This persists Jenkins data.

- `-v /var/run/docker.sock:/var/run/docker.sock`: Mount the Docker socket from the host into the container. This allows Jenkins to interact with the Docker daemon on the host.

- `--name jenkins2`: Assign the name 'jenkins2' to this container.

```bash
docker run -d -p 9090:8080 -p 50000:50000 
-v jenkins_home:/var/jenkins_home 
-v /var/run/docker.sock:/var/run/docker.sock 
--name jenkins2 
jenkins/jenkins:lts
```

## third container

By not mounting any volumes, you ensure that this is a <mark>completely fresh instance</mark> of Jenkins without any existing configuration or data from previous installation

```bash
docker run -d -p 9091:8080 -p 50001:50000 
--name 
jenkins3 
jenkins/jenkins:lts
```

## Links

DockerHub Jenins

https://hub.docker.com/r/jenkins/jenkins

Downloading and running Jenkins in Docker

https://www.jenkins.io/doc/book/installing/docker/#downloading-and-running-jenkins-in-docker
