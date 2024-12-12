# Book Management Docker-standalone

> This project is a full-stack web application for managing books, consisting of two main components: a backend built with Spring Boot and a frontend built with React.
> 
> Both components are containerized using Docker, allowing for easy deployment and management.

## Backend (Spring Boot)

- **Repository**: [BooksPageable](https://github.com/AlbertProfe/BooksPageable)

- **Description**: The backend serves as a RESTful API for managing books.

- **Key Features**:
  
  - **H2 In-Memory Database**: Utilizes an H2 database for data storage, which is lightweight and suitable for development purposes.
  - **RESTful API**: Provides endpoints to perform CRUD (Create, Read, Update, Delete) operations on book data.
  - **CORS Configuration**: Configured to allow cross-origin requests from the frontend.
  - **Pagination Support**: Implements pagination for efficient data retrieval, allowing users to navigate through large datasets.
  - **Build Tool**: Built using `Maven` within<mark> IntelliJ IDEA.</mark>

- **Running Environment**:
  
  - Runs in a Docker container on port 8080.
  
  - Container Name: `books-backend`

- Example Command to Run:
  
  ```bash
  docker run -d --name books-backend -p 8080:8080 books-backend-image
  ```

## Frontend (React)

- **Repository**: [BooksFrontend](https://github.com/AlbertProfe/BooksFrontend)

- **Description**: The frontend provides a user interface for interacting with the book management system.

- **Key Features**:
  
  - **User Interface**: Built with React, it offers a dynamic and responsive UI for managing books.
  - **Axios Integration**: Uses Axios for making HTTP requests to the backend API to fetch and manipulate book data.
  - **CRUD Operations**: Allows users to create, read, update, and delete books through the interface.
  - **Pagination Controls**: Implements pagination controls to navigate through book listings easily.
  - **Build Tool**: Built using `npm` within <mark>Visual Studio Code.</mark>

- **Running Environment**:
  
  - Runs in a Docker container on port 90.
  
  - Container Name: `books-frontend`

- Example Command to Run:
  
  ```bash
  docker run -d --name books-frontend -p 90:80 books-frontend-image
  ```

## Docker Setup

### Running Containers

The following Docker containers are currently running:

```bash
albert@albert-VirtualBox:~$ sudo docker ps
CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES
79bcfc400b67 books-backend "java -jar books.jar" 46 seconds ago Up 45 seconds 0.0.0.0:8080->8080/tcp, :::8080->8080/tcp peaceful_chaplygin
2fe6368ade9a books-frontend "/docker-entrypoint.…" 14 minutes ago Up 14 minutes 0.0.0.0:90->80/tcp, [::]:90->80/tcp eloquent_margulis
```

## Optional Networking

To enhance communication between the frontend and backend containers, you can create a custom Docker network:

1. Create a custom network:
   
   ```bash
   docker network create books-network
   ```

2. Connect both containers to this network:
   
   ```bash
   docker network connect books-network peaceful_chaplygin
   
   docker network connect books-network eloquent_margulis
   ```

## CORS Configuration

<mark>CORS (Cross-Origin Resource Sharing)</mark> is configured in the Spring Boot application to allow the React frontend to communicate with the backend API without encountering CORS-related issues.
