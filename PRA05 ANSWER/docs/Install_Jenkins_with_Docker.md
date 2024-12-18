# Creación y configuración de un contenedor Jenkins con Docker

Vamos a crear un nuevo contenedor de Jenkins. Asegúrate de montar un volumen persistente y darle los permisos correctos para que Jenkins pueda acceder a su directorio de datos (`/var/jenkins_home`) y al socket de Docker (`/var/run/docker.sock`) si es necesario.

## Montar volumen persistente para Jenkins

Asegúrate de que el directorio en tu máquina host tiene los permisos correctos para Jenkins. Vamos a crear un volumen o montar un directorio en el contenedor.

## Montar el socket de Docker dentro del contenedor de Jenkins

Esto permitirá que Jenkins ejecute comandos de Docker.

El comando para crear y ejecutar el contenedor de Jenkins será:

```bash
sudo docker run -d \
  -p 8080:8080 \
  --name jenkins \
  -v /ruta/a/tu/volumen/jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --user root \
  jenkins/jenkins:lts
```

## Explicación del comando

- `-p 8080:8080`: Mapea el puerto 8080 del contenedor al puerto 8080 de la máquina host, permitiéndote acceder a Jenkins desde [http://localhost:8080](http://localhost:8080).
- `-v /ruta/a/tu/volumen/jenkins_home:/var/jenkins_home`: Monta un volumen para almacenar los datos persistentes de Jenkins en tu máquina local. Asegúrate de que el directorio `/ruta/a/tu/volumen/jenkins_home` tenga los permisos correctos.
- `-v /var/run/docker.sock:/var/run/docker.sock`: Monta el socket de Docker dentro del contenedor para permitir que Jenkins ejecute comandos Docker.
- `--user root`: Ejecuta el contenedor como root para evitar problemas de permisos.

### Imagen 1

![Docker Jenkins](images/docker_jenkins/1.png)

> **Nota:** Cambia `/ruta/a/tu/volumen/jenkins_home` a la ruta real en tu sistema donde quieres almacenar los datos de Jenkins.

## Verificar permisos del directorio y el socket de Docker

Asegúrate de que los permisos en el directorio de Jenkins y en el socket de Docker sean correctos. 

Para el directorio de Jenkins:

```bash
sudo chown -R 1000:1000 /ruta/a/tu/volumen/jenkins_home
```

Para el socket de Docker, el contenedor Jenkins debería poder acceder a él si lo montamos correctamente, pero si encuentras problemas, asegúrate de que el grupo `docker` tenga acceso a este archivo:

```bash
sudo chmod 666 /var/run/docker.sock

## Verificar si el contenedor de Jenkins está en ejecución

### Imagen 2

![Docker Jenkins](images/docker_jenkins/2.png)

Una vez que el contenedor esté en ejecución, puedes comprobarlo con el siguiente comando:

```bash
sudo docker ps
```

CONTAINER ID   IMAGE                 COMMAND                  CREATED         STATUS         PORTS     NAMES
b75ad49bcf49   jenkins/jenkins:lts   "/usr/bin/tini -- /u…"   2 minutes ago   Up 1 minute     8080/tcp  jenkins

## Acceder a Jenkins

Ahora puedes acceder a Jenkins desde el navegador en [http://localhost:8080](http://localhost:8080). Durante el primer acceso, deberás usar la contraseña inicial que puedes obtener con este comando:

```bash
sudo docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```
Con estos pasos deberías tener Jenkins funcionando correctamente con Docker instalado dentro del contenedor y acceso a sus datos de manera persistente.

## Pasos para instalar Docker dentro de Jenkins

### Acceder al contenedor de Jenkins

Primero, vamos a acceder al contenedor de Jenkins para realizar la instalación de Docker dentro de él. Usa el siguiente comando:

```bash
sudo docker exec -it jenkins bash
```

### Instalar dependencias necesarias

Para instalar Docker dentro del contenedor de Jenkins, necesitamos instalar algunas dependencias como curl y ca-certificates. Ejecuta los siguientes comandos dentro del contenedor:

```bash
    apt-get update
    apt-get install -y ca-certificates curl gnupg lsb-release
```

### Agregar el repositorio de Docker

Ahora, añadimos el repositorio oficial de Docker y su clave GPG:

```bash
curl -fsSL https://download.docker.com/linux/debian/gpg | tee /etc/apt/trusted.gpg.d/docker.asc
echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/docker.asc] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list
```

### Instalar Docker

Para instalar Docker, actualiza la lista de paquetes e instala Docker:
```bash
    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io
```

### Imagen 3

![Docker Jenkins](images/docker_jenkins/3.png)

## Verificar la instalación de Docker

Una vez que Docker esté instalado, verifica su versión para asegurarte de que se haya instalado correctamente:

```bash
docker --version
```
Esto debería devolver la versión de Docker instalada, como por ejemplo:

Docker version 27.03.1, build (un número)

### Imagen 4

![Docker Jenkins](images/docker_jenkins/4.png)

## Agregar el usuario jenkins al grupo Docker

Para permitir que Jenkins ejecute comandos Docker sin necesidad de permisos elevados, agregamos el usuario jenkins al grupo docker:

```bash
usermod -aG docker jenkins
```
## Reiniciar el contenedor de Jenkins

Como hemos realizado cambios en los permisos del usuario, reiniciaremos el contenedor de Jenkins para que los cambios surtan efecto:
```bash
docker restart jenkins  # Importante, sin sudo
```

## Verificar Docker en Jenkins

Ahora volvemos a entrar al contenedor y verificamos si Docker funciona correctamente ejecutando un contenedor de prueba. Por ejemplo, podemos ejecutar el contenedor hello-world de Docker:

```bash
docker run hello-world
```
Si todo está funcionando correctamente, deberías ver un mensaje de Docker confirmando que la instalación fue exitosa.

### Imagen 5

![Docker Jenkins](images/docker_jenkins/5.png)

