# Despliegue de una Aplicación Spring Boot en AWS ECS usando Jenkins y Docker
## 1. Crear credenciales en AWS

Primero crearemos las credenciales de acceso en AWS para permitir que Jenkins interactúe con los servicios de AWS. Se crearon las Access Key ID y Secret Access Key en el IAM de AWS.

## 2. Crear repositorio en ECR público

Creamos un repositorio público en Amazon Elastic Container Registry (ECR) para almacenar las imágenes Docker generadas. El repositorio se llamó test/jenkins con la URI public.ecr.aws/t6o5r2l4/test/jenkins.

## 3. Instalar plugin AWS Credentials en Jenkins

Para que Jenkins pueda interactuar con AWS, instalamos el plugin AWS Credentials. Este plugin facilita la configuración de credenciales de AWS en Jenkins y permite que las tareas de Jenkins puedan autenticarse con los servicios de AWS.

## 4. Configurar la pipeline en Jenkins para hacer push a ECR

Configuramos la pipeline en Jenkins para automatizar el proceso de construcción y despliegue. La pipeline hace lo siguiente:

    Realiza un checkout del código del repositorio en GitHub.
    Ejecuta Maven para construir el proyecto Spring Boot.
    Construye una imagen Docker a partir del código generado.
    Etiqueta y sube la imagen a Amazon ECR usando el comando docker push.

El código de la pipeline en Jenkins se encuentra en el archivo pipeline_jenkins_to_docker y una explicación detallada de cada paso se encuentra en pipeline_explicación.
Ejemplo de pipeline configurada en Jenkins:

## 5. Verificar que se ha subido correctamente la imagen al repositorio de ECR

Después de ejecutar la pipeline en Jenkins, verificamos que la imagen Docker se subiera correctamente al repositorio público de Amazon ECR.

Pasos para verificar:

    Ingresar a la consola de AWS.
    Navegar hasta Amazon ECR.
    Seleccionar el repositorio test/jenkins y comprobar que la imagen se subió correctamente con la etiqueta testjenkins-1.

## 6. Crear un cluster en ECS

Creamos un Cluster en Amazon ECS (Elastic Container Service) para gestionar las tareas de contenedores. En este caso, utilizaremos una configuración básica para asegurar que el servicio estuviera disponible y pudiera ser escalable.

Pasos para crear el cluster:

    Crear un nuevo Cluster seleccionando la opción adecuada (por ejemplo, Fargate si se utiliza sin instancias EC2) y asignando los parámetros básicos como nombre del cluster y tipo de red.

## 7. Crear una tarea en ECS asignando el repositorio y la imagen

Creamos una definición de tarea en ECS que asigna la imagen Docker desde ECR y configura los puertos para que el contenedor pueda recibir tráfico externo. La imagen se configuró con la etiqueta testjenkins-1 y el puerto 8080 fue expuesto, ya que la aplicación Spring Boot está configurada para ejecutarse en este puerto.

Pasos para crear la tarea:

    En ECS, crear una nueva Definición de Tarea.
    Configurar el contenedor para usar la imagen de ECR y asignar el puerto 8080.
    Crear un nuevo Task Definition con la imagen adecuada y las configuraciones necesarias.

## 8. Crear un servicio en ECS, asignando la tarea, los puertos y habilitar los puertos en el VPC de Security

Creamos un servicio en ECS utilizando la tarea definida previamente. Asignamos los puertos adecuados para asegurar que el tráfico entrante pueda acceder a la aplicación. Además, se habilitaron los puertos necesarios en el Security Group del VPC para asegurar el acceso público a la aplicación.

Pasos para crear el servicio:

    Crear un Servicio en ECS asociado a la tarea.
    Configurar el Security Group para abrir el puerto 8080.
    Seleccionar la VPC y las subredes adecuadas.

## 9. Comprobación de despliegue correcto mediante IP pública

Una vez desplegado el servicio, verificamos que la aplicación estuviera accesible mediante la IP pública asignada al servicio ECS.

Pasos para verificar el despliegue:

    Obtener la IP pública de la tarea en ECS.
    Acceder a la aplicación desde un navegador utilizando la dirección http://<IP-pública>:8080.
    Comprobar que la aplicación Spring Boot responde correctamente a las solicitudes.


