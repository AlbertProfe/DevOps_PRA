## MF04-PRA04: Docker Setup and Containerization for Spring Boot and React Applications

### CIFO La Violeta - DevOps IFCT0116-24 MF04

This practical exercise will guide you <mark>through setting up Docker</mark>, creating containers for **Spring Boot and React applications**, and managing them effectively.

> The Spring Boot application will serve a REST API for Book objects, which will be consumed by the React frontend using Axios.

## Objectives

- Install Docker CLI
- Create a DockerHub account
- Create Dockerfiles for Spring Boot and React applications
- Build and run Docker containers
- Implement a Book API with Spring Boot
- Consume the API with React using Axios

### Tasks

#### 1. Install Docker CLI

To install Docker CLI on Ubuntu:

```bash
sudo apt-get update
sudo apt-get install docker-ce-cli
```

Verify the installation:

```bash
docker --version
```

#### 2. Create a DockerHub Account

Visit [Docker Hub](https://hub.docker.com/) and sign up for a new account.

#### 3. Create Dockerfiles

##### Spring Boot Dockerfile

Create a file named `Dockerfile` in your Spring Boot project root (examples):

```dockerfile
FROM openjdk:21-jdk-slim
MAINTAINER yourname
COPY /resources/spring-boot-app.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
```

##### React Dockerfile

Create a file named `Dockerfile` in your React project root:

```dockerfile
FROM node:14
WORKDIR /app
COPY /resources/react-app/package*.json ./
RUN npm install
COPY /resources/react-app .
EXPOSE 3000
CMD ["npm", "start"]
```

#### 4. Build and Run Docker Containers

For Spring Boot:

```bash
docker build -t spring-boot-app .
docker run -p 8080:8080 spring-boot-app
```

For React:

```bash
docker build -t react-app .
docker run -p 3000:3000 react-app
```

#### 5. H2 Database Configuration

For in-memory H2 (examples):

```properties
spring.datasource.url=jdbc:h2:mem:testdb
spring.datasource.driverClassName=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=password
spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
```

For local H2 (optional):

```properties
spring.datasource.url=jdbc:h2:file:/data/demo
spring.datasource.driverClassName=org.h2.Driver
spring.datasource.username=sa
spring.datasource.password=password
spring.jpa.database-platform=org.hibernate.dialect.H2Dialect
```

## 6. Implement Book API with Spring Boot

Create a `Book` entity:

```java
@Entity
public class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String title;
    private String author;
    private String isbn;

    // Constructors, getters, and setters
}
```

Create a `BookRepository`:

```java
@Repository
public interface BookRepository extends JpaRepository<Book, Long> {
}
```

Create a `BookController`:

```java
@RestController
@RequestMapping("/api/books")
public class BookController {
    @Autowired
    private BookRepository bookRepository;

    @GetMapping
    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }

    @PostMapping
    public Book createBook(@RequestBody Book book) {
        return bookRepository.save(book);
    }

    // Additional CRUD operations
}
```

## 7. Consume API with React using Axios

Install Axios in your React project:

```bash
npm install axios
```

Create a component to fetch and display books:

```jsx
import React, { useState, useEffect } from 'react';
import axios from 'axios';

function BookList() {
    const [books, setBooks] = useState([]);

    useEffect(() => {
        axios.get('http://localhost:8080/api/books')
            .then(response => {
                setBooks(response.data);
            })
            .catch(error => {
                console.error("Error fetching books:", error);
            });
    }, []);

    return (
        <div>
            <h1>Book List</h1>
            <ul>
                {books.map(book => (
                    <li key={book.id}>{book.title} by {book.author}</li>
                ))}
            </ul>
        </div>
    );
}

export default BookList;
```

## Additional Notes

- Ensure CORS is configured in your Spring Boot application to allow requests from your React app.
- The Spring Boot application will publish a REST API endpoint that the React application will consume using Axios.
- The data exchanged between the backend and frontend will be Book objects, representing the books in your application.
- This setup allows for a clear separation of concerns: the Spring Boot backend handles data persistence and business logic, while the React frontend focuses on presentation and user interaction.

### Submission Guidelines

- Fork the repository or create a new one on GitHub.
- Create a branch named `MF04-PRA04-YourNameAndSurname`.
- Implement the required changes and add Dockerfiles.
- Commit with clear messages.
- Push your branch and create a pull request titled `MF04-PRA04-YourNameAndSurname-DockerSetup`.
  - Example: `MF04-PRA04-EmmaMoskovitz-AutomatingQuartoPublishingWithBash`
- **Create** a `PRA04_ANSWER` folder to save the answer, docs and images.

### Evaluation Criteria

- Successful Docker CLI installation and DockerHub account creation.
- Correct implementation of Dockerfiles for both Spring Boot and React.
- Proper configuration of H2 database.
- Adherence to Docker best practices.
- Clear documentation and commit messages.

By completing this exercise, you'll gain practical experience in containerizing applications using Docker, an essential skill in modern DevOps practices[1][3][4][5].

Citations:
[1] https://medium.com/%40Simplilearn/how-to-install-docker-on-ubuntu-a-step-by-step-guide-updated-simplilearn-14ebf64d4eee
[2] https://stackoverflow.com/questions/38675925/is-it-possible-to-install-only-the-docker-cli-and-not-the-daemon/43594065
[3] https://docs.docker.com/desktop/setup/install/windows-install/
[4] https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04
[5] https://docs.docker.com/engine/install/