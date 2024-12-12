# Docker Images and Containers

### Image

An image is a read-only template containing instructions for creating a Docker container: <mark>it's like a snapshot of a container.</mark>

Example:

```bash
jenkins/jenkins:lts
```

## Container

A container is a runnable instance of an image. It's a lightweight, standalone, executable package that includes everything needed to run an application.

Example:

```bash
docker run -d -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --name jenkins \
  jenkins/jenkins:lts
```

<img src="https://miro.medium.com/v2/resize:fit:331/1*rCo_Q1-f7V5zYoKAQed_Mw.png" title="" alt="" data-align="center">

## Container States

1. **Created**: Container is created but not started.
2. **Running**: Container is actively executing processes.
3. **Paused**: Container processes are temporarily stopped.
4. **Exited**: Container has completed its execution or was stopped.
5. **Dead**: Container failed to start or be removed completely.

## Docker Commands and Container States

### docker run

Creates and starts a new container instance.

```bash
docker run -d --name jenkins jenkins/jenkins:lts
```

State Transition: Created → Running

## docker pause

Suspends all processes in the specified containers.

```bash
`docker pause jenkins`
```

State: Running → Paused

*Key Differences*

- `docker start`: Restarts a stopped container, resuming processes.
- `docker pause`: Suspends processes in a running container without termination.



### docker stop

Stops a running container.

```bash
docker stop jenkins
```

State Transition: Running → Exited

### docker start

Restarts an existing stopped container.

```bash
docker start jenkins
```

State Transition: Exited → Running

*Key Differenced*

- `docker start`: Restarts an existing stopped container.
- `docker run`: Creates a new container instance.

## Docker Stop vs Docker Kill

The main difference between `docker stop` and `docker kill` lies in how they terminate containers:

**Docker Stop**

- Sends a SIGTERM signal first, allowing for graceful shutdown

- Gives the container a chance to clean up and save data

- Has a default timeout of 10 seconds before forcefully terminating

- Preferred for normal container shutdown

**Docker Kill**

- Sends a SIGKILL signal immediately

- Forcefully terminates the container without allowing cleanup

- Used when containers are unresponsive or need immediate termination

*When to Use*

- **Docker Stop**: Use for normal container shutdown to allow proper cleanup and data saving

- **Docker Kill**: Use when containers are locked up or not responding to stop commands

It's generally recommended to use `docker stop` first, and only resort to `docker kill` if the container doesn't respond or you need immediate termination[

### Key Differences: Docker Stop vs Docker Kill

| Aspect              | Docker Stop           | Docker Kill             |
| ------------------- | --------------------- | ----------------------- |
| Signal              | SIGTERM, then SIGKILL | SIGKILL                 |
| Graceful Shutdown   | Yes                   | No                      |
| Cleanup Opportunity | Yes                   | No                      |
| Speed               | Slower (up to 10s)    | Immediate               |
| Use Case            | Normal shutdown       | Unresponsive containers |
