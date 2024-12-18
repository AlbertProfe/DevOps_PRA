## MF03-PRA03: Automating Local and Remote Quarto Publishing with Bash

### CIFO La Violeta - DevOps IFCT0116-24 MF03

In this practical exercise, you will create a **bash script to automate both local and remote operations** for <mark>publishing Quarto documentation</mark>.

> This script will handle git operations, Quarto publishing, and create a log file for each execution.

### Objectives

- Create a **bash script** to automate local git operations and Quarto publishing.
- Implement logging functionality to track script executions.
- Ensure the script is flexible and user-friendly.

### Tasks

#### 1. Create the Bash Script

Create a new file named `publish_quarto.sh` in your project root directory similar to the following content:

```bash
#!/bin/bash

# Check if the commit message is provided
if [ -z "$1" ]; then
  echo "Please provide a commit message."
  exit 1
fi

# Commit the changes with the provided message
git add .
git commit -m "$1"

# Push the changes to the main branch
git push origin main

# Publish to GitHub Pages using quarto
quarto publish gh-pages --no-render --no-prompt
```

#### 2. Add logging output

Implement logging functionality to track script executions.

```bash
log_message() {
    local message="$1"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[${timestamp}] ${message}" >> log.txt
}
```

#### 3. Make the Script Executable

Run the following command to make the script executable:

```bash
chmod +x publish_quarto.sh
```

#### 4 Use the Script

To use the script, run it with a commit message as an argument:

```bash
./publish_quarto.sh "Your commit message here"
```

### Reference Documentation

- [Bash Scripting Tutorial](https://linuxconfig.org/bash-scripting-tutorial-for-beginners)
- [Quarto CLI Documentation](https://quarto.org/)

### Submission Guidelines

- Fork the existing repository (if applicable) or create a new one on GitHub.
- Create a new branch named `MF03-PRA03-YourNameAndSurname` from the latest commit.
- Add the `publish_quarto.sh` script to your repository.
- Commit your changes with clear, descriptive messages.
- Push your branch to your forked repository.
- Create a pull request to the original repository (if applicable) with a summary of your changes and title: `MF03-PRA03-YourNameAndSurname-AutomatingQuartoPublishingWithBash`
  - Example: `MF03-PRA03-EmmaMoskovitz-AutomatingQuartoPublishingWithBash`
- **Create** a `PRA03_ANSWER` folder to save the answer, docs and images.

### Evaluation Criteria

- Correct implementation of the bash script with all required functionalities.
- Proper error handling and logging mechanisms.
- Clear and informative commit messages.
- Adherence to bash scripting best practices.
- Successful automation of local git operations and Quarto publishing.

By completing this exercise, you will have created a powerful tool to streamline your Quarto documentation <mark>workflow</mark>, **automating both local and remote operations** while maintaining a log of all actions performed.

### MF03-PRA03
Links:
<https://github.com/emiralya8/Pract01Quarto/commits/gh-pages/>
<https://github.com/emiralya8/Pract01Quarto/commit/0f4559b6ea388b4557d5edc6ab307b10fdb5fda7>
