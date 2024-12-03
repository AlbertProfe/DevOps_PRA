## Git

In the Jenkins GUI, the Git section under Global Tool Configuration indicates that Git is installed and configured. 

1. Name: A user-defined name for this Git installation (e.g., "Default Git").

2. Path to Git executable: The location of the Git executable on the Jenkins server. If left blank, Jenkins will use the Git installation found in the system PATH.

## Maven

To configure Maven installations in Jenkins with the "Install automatically" option, follow these steps:

- Go to "Manage Jenkins" > "Global Tool Configuration".
- Scroll down to the "Maven" section and click on "Add Maven".
- Enter a name for this Maven installation, such as "Maven 3.9.6" or "M3". 
- Check the "Install automatically" box: Jenkins will handle the download and installation of Maven.
- By default, Jenkins will install Maven from the official Apache repository
  - Use the dropdown menu to select the specific version of Maven you wish to install, such as 3.9.6

## JDK

To install Java 21 in Jenkins automatically:

Download URL for Java 21

- **URL**: `https://jdk.java.net/21/`
- **URL**: `https://download.java.net/java/GA/jdk21.0.1/415e3f918a1f4062a0074a2794853d0d/12/GPL/openjdk-21.0.1_linux-x64_bin.tar.gz`

This URL points to the official Java Development Kit (JDK) 21 download page.

Subdirectory of Extracted Archive

- **Subdirectory**: `java-21`
- **Subdirectory**: `jdk-21.0.1`
