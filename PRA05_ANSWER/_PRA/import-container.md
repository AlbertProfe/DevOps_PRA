# Paso 1

Log in to your remote host, then run the following command to load it to your remote machine’s Docker daemon:

```
docker load -i ./jenkins.tar
```

se crea la imagen `jenkins-image`
pero la vamos a renombrar a `pra05/jenkins-image`

```
docker image tag jenkins-image:latest pra05/jenkins-image:latest
docker rmi jenkins-image
```


Use docker create to reinitialize your Docker container image with its original run flags from your source machine. For instance, my Nginx Docker container originally had port 80 mapped to my host machine’s port 8080:

```
docker create --name jenkins-home -p 9090:8080 -p 50000:50000 pra05/jenkins-image
```

Run your newly imported Docker container:

```
docker start jenkins-home
```

Confirm that your imported image is working properly by listing all the active containers in the system:

```
docker ps
```


# Paso 2
Create a new Docker container using your exported image file:

```
docker create --name jenkins-home \ 
    -v jenkins_home:/var/jenkins_home \
    -p 9090:8080 -p 50000:50000 pra05/jenkins-image
```

Run the docker-volume.sh script with your original .tar file to load it to your new system’s Docker daemon:

```
docker-volumes.sh jenkins-home load jenkins-volume.tar
```

Start your new Docker container by running the following command:

```
docker start jenkins-home
```

Test if your container is loading your volume properly by looking at its internal config data:

```
docker inspect -f '{{ .Mounts }}' jenkins-home
```
