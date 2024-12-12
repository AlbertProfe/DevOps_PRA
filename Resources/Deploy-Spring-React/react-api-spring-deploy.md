# Book Management Docker-standalone and Cloud Deployment

This project is a full-stack web application for managing books, consisting of a Spring Boot backend and a React frontend.

The components are containerized using Docker for local deployment and also deployed to cloud services for production use.

## Backend (Spring Boot)

- **Repository**: [BooksPageable](https://github.com/AlbertProfe/BooksPageable)

- **Description**: RESTful API for managing books

- **Key Features**: H2 In-Memory Database, RESTful API, CORS Configuration, Pagination Support

- **Build Tool**: Maven (IntelliJ IDEA)

- **Local Docker Deployment**:
  
  ```bash
  docker run -d --name books-backend -p 8080:8080 books-backend-image
  ```

- **Cloud Deployment**: 
  
  - Dockerhub for image storage
  - Render for hosting: [https://books-backend-icx2.onrender.com/api/books](https://books-backend-icx2.onrender.com/api/books)

## Frontend (React)

- **Repository**: [BooksFrontend](https://github.com/AlbertProfe/BooksFrontend)

- **Description**: User interface for book management

- **Key Features**: React UI, Axios Integration, CRUD Operations, Pagination Controls

- **Build Tool**: npm (Visual Studio Code)

- **Local Docker Deployment**:
  
  ```bash
  docker run -d --name books-frontend -p 90:80 books-frontend-image
  ```

- **Cloud Deployment**: 
  
  - GitHub for source control
  - AWS Amplify for hosting: [https://master.dfzntypm2yg8j.amplifyapp.com/](https://master.dfzntypm2yg8j.amplifyapp.com/)

## Cloud Deployment

1. **Backend (Spring Boot)**:
   
   - Push Docker image to Dockerhub
   - Deploy on Render: [https://books-backend-icx2.onrender.com/api/books](https://books-backend-icx2.onrender.com/api/books)

2. **Frontend (React)**:
   
   - Push code to GitHub
   - Deploy on AWS Amplify: [https://master.dfzntypm2yg8j.amplifyapp.com/](https://master.dfzntypm2yg8j.amplifyapp.com/)

This setup allows for both local development using Docker and production deployment using cloud services, providing flexibility and scalability for the Book Management application.
