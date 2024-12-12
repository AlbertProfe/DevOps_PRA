# Install docker #2: using the jenkins cli

To install Docker <mark>using the jenkins-cli from the Linux host</mark> and accessing the Jenkins running instance container at port 8080, follow these steps:

1. Ensure Jenkins is running and accessible at http://localhost:8080.

2. Download the jenkins-cli.jar file from your Jenkins instance:
   
   ```bash
   wget http://localhost:8080/jnlpJars/jenkins-cli.jar
   ```

3. Use jenkins-cli to install the Docker plugin:
   
   ```bash
   java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin docker-plugin
   ```

4. Restart Jenkins to apply the changes:
   
   ```bash
   java -jar jenkins-cli.jar -s http://localhost:8080/ safe-restart
   ```

5. After restart, configure the Docker plugin in Jenkins web interface:
   
   - Go to "Manage Jenkins" > "Global Tool Configuration"
   - Add a Docker installation
   - Set up Docker cloud configuration in "Manage Jenkins" > "Manage Nodes and Clouds"

Note that this method installs the Docker plugin, not Docker itself. To use Docker commands, ensure Docker is installed on the host machine and the Jenkins container has access to the Docker socket[4][6].

Citations:
[1] https://faun.pub/how-to-install-docker-in-jenkins-container-4c49ba40b373?gi=76ee7fb73578
[2] https://stackoverflow.com/questions/75472431/unable-to-access-jenkins-on-port-8080-when-running-docker-network-host
[3] https://dev.to/hackmamba/jenkins-in-docker-running-docker-in-a-jenkins-container-1je?comments_sort=top
[4] https://www.reddit.com/r/docker/comments/14ioi3g/can_someone_tell_me_why_my_jenkins_container_isnt/
[5] https://gist.github.com/initcron/a92be9f4928ace6ff725d52ec176f57a
[6] https://kodekloud.com/community/t/access-running-jenkins-container/353228
[7] https://www.jenkins.io/doc/book/installing/docker/
[8] https://www.jenkins.io/doc/book/installing/initial-settings/
