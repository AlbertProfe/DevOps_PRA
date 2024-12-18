# Como instalar [docker.io](http://docker.io) en Linux Mint

# Guía de instalación de Docker en Linux Mint

A continuación se detallan los pasos realizados para instalar Docker en un sistema Linux Mint:

1. **Instalar Docker**
    - Ejecutamos el siguiente comando para instalar el paquete `docker.io`:
        
        ```bash
        sudo apt install docker.io
        
        ```
        
    - **Salida**:
        
        ```
        Leyendo lista de paquetes... Hecho
        Se instalarán los siguientes paquetes adicionales:
          bridge-utils containerd pigz runc ubuntu-fan
        Se instalarán los siguientes paquetes NUEVOS:
          bridge-utils containerd docker.io pigz runc ubuntu-fan
        0 actualizados, 6 nuevos se instalarán, 0 para eliminar y 57 no actualizados.
        Se necesita descargar 79,7 MB de archivos.
        ¿Desea continuar? [S/n] S
        
        ```
        
2. **Verificar la instalación de Docker**
    - Para verificar que Docker se instaló correctamente, ejecutamos:
        
        ```bash
        docker --version
        
        ```
        
    - **Salida**:
        
        ```
        Docker version 26.1.3, build 26.1.3-0ubuntu1~24.04.1
        
        ```
        
3. **Iniciar y habilitar el servicio Docker**
    - Iniciamos el servicio Docker y lo habilitamos para que se inicie automáticamente al arrancar el sistema:
        
        ```bash
        sudo systemctl start docker
        sudo systemctl enable docker
        
        ```
        
4. **Añadir el usuario al grupo Docker**
    - Para poder ejecutar Docker sin `sudo`, añadimos el usuario al grupo `docker`:
        
        ```bash
        sudo usermod -aG docker $USER
        
        ```
        
5. **Verificar el estado del servicio Docker**
    - Comprobamos que el servicio Docker esté activo y corriendo:
        
        ```bash
        sudo systemctl status docker
        
        ```
        
    - **Salida**:
        
        ```
        ● docker.service - Docker Application Container Engine
           Active: active (running) since Wed 2024-11-27 20:53:02 CET; 2min 40s ago
        
        ```
        
6. **Ejecutar un contenedor de prueba**
    - Finalmente, ejecutamos el contenedor de prueba `hello-world`:
        
        ```bash
        sudo docker run hello-world
        
        ```
        
    - **Salida**:
        
        ```
        Hello from Docker!
        This message shows that your installation appears to be working correctly.
        
        ```
        

**Nota**: Durante el proceso, se resolvió un error de permisos al ejecutar comandos de Docker sin `sudo` mediante la adición del usuario al grupo `docker`.
