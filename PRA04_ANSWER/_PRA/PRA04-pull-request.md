# PRA04

## Explanation

I want to build scripts to automate all the process using .env variables to 
- preparing resources to create both dockers: `copy-resources-sh`
    - backend
    - frontend
- creating backend docker: `docker-build-backend.sh`
- creating frontend docker: `docker-build-frontend.sh`

To load variables from .env file I created some util files:
- remove-comments.sed  
    remove all shell comments, after # char, but keeping strings. Code based on [this post](https://sleeplessbeastie.eu/2012/11/07/how-to-remove-comments-from-a-shell-script/)

    Example cleaning of comments and empty lines:
    ```
    bash util/clean-env-file.sh util/to-test.sh
    ```

    Example of loading env vars:
    ```
    bash util/test-load-env.sh
    ```



## Tasks

1. [x] Install Docker CLI
2. [x] Create a DockerHub Account
3. [ ] Create Dockerfiles
4. [ ] Build and Run Docker Containers
5. [ ] H2 Database Configuration
6. [ ] Implement Book API with Spring Boot
7. [ ] Consume API with React using Axios

