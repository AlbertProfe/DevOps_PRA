## MF01-PRA01: Publishing and Managing Quarto Documentation

### CIFO La Violeta - DevOps IFCT0116-24 MF01

In this practical exercise, you will enhance your skills in creating, managing, and publishing documentation using Quarto. You will set up a local Quarto website, customize its content, and publish it to **GitHub Pages**.

### Objectives

- Create a local **Markdown Quarto website**
- Modify the website by adding call-outs, new pages, basic formatting, and layout
- Implement Website Navigation
- Include Mermaid diagrams
- Configure the `_quarto.yml` file
- Set up a Git repository and link it to a GitHub remote repository
- **Publish** the website to GitHub Pages

### Project Base

- **Reference Documentation:** 
  - [Quarto Markdown: basics](https://albertprofe.dev/markup/markup-quarto-basics.html)
  - [Welcome to Quarto®](https://quarto.org/)
  - [Creating a Website](https://quarto.org/docs/websites/)
  - [Website Navigation](https://quarto.org/docs/websites/website-navigation.html)
  - [GitHub Pages]([GitHub Pages – Quarto](https://quarto.org/docs/publishing/github-pages.html))
  - [Page Layout]([Page Layout – Quarto](https://quarto.org/docs/output-formats/page-layout.html))
  - [Markdown Basics]([Markdown Basics – Quarto](https://quarto.org/docs/authoring/markdown-basics.html))
  - [Mermaid, Diagramming and charting tool](https://mermaid.js.org/)

### Tasks

#### 1\. Create a Local Markdown Quarto Website

- Install **Quarto** if you haven't already. Follow the installation instructions on the [Creating a Website](https://quarto.org/docs/websites/).

- Create a new Quarto project using the command:
  
  ```bash
  quarto create-project my-quarto-site
  ```

- Navigate to the newly created project directory:
  
  ```bash
  cd my-quarto-site
  ```

#### 2\. Modify the Website

- **Add Call-outs:**
  
  - Use call-outs to highlight important information. For example:
    
    ```markdown
    ::: callout
    This is an important note.
    :::
    ```

- **Create New Pages:**
  
  - Add new Markdown files to create additional pages. For example, create a `about.md` file and add it to `_quarto.yml`:
    
    ```markdown
    # About
    This is the about page.
    ```

- **Basic Formatting and Layout:**
  
  - Use Markdown syntax to format your content. For example:
    
    ```markdown
    # Heading
    ## Subheading
    This is a paragraph with *italic* and **bold** text.
    ```
  
  - Customize the layout by editing the `_quarto.yml` file.

#### 3\. Implement Website Navigation

- Configure the navigation menu by editing the `_quarto.yml` file. For example:
  
  ```yml
  nav:
    - Home: index.qmd
    - About: about.qmd
    - Contact: contact.qmd
  ```

#### 4\. Include Mermaid Diagrams

- Install the Mermaid extension for Quarto if you haven't already. Add the following to your `_quarto.yml` file:
  
  ```yml
  extensions:
    - mermaid
  ```

- Include Mermaid diagrams in your Markdown files. For example:
  
  ```markdown
  ``` mermaid
  graph LR
      A[Client] --> B[Load Balancer]
      B --> C[Server1]
      B --> D[Server2]
  ```
  
  ```
  ---
  title: Animal example
  ---
  classDiagram
      note "From Duck till Zebra"
      Animal <|-- Duck
      note for Duck "can fly\ncan swim\ncan dive\ncan help in debugging"
      Animal <|-- Fish
      Animal <|-- Zebra
      Animal : +int age
      Animal : +String gender
      Animal: +isMammal()
      Animal: +mate()
      class Duck{
          +String beakColor
          +swim()
          +quack()
      }
      class Fish{
          -int sizeInFeet
          -canEat()
      }
      class Zebra{
          +bool is_wild
          +run()
      }
  ```

#### 5\. Configure the `_quarto.yml` File

- Customize the site's metadata, theme, and other settings in the `_quarto.yml` file. For example:
  
  ```yml
  title: "My Quarto Site"
  author: "Your Name"
  theme: [journals]
  ```

#### 6\. Set Up a Git Repository and Link to GitHub

- Initialize a Git repository in your project directory:
  
  ```bash
  git init
  ```

- Add all files to the repository:
  
  ```bash
  git add .
  ```

- Commit the changes:
  
  ```bash
  git commit -m "Initial commit"
  ```

- Create a new repository on GitHub and link it to your local repository:
  
  ```bash
  git remote add origin https://github.com/your-username/your-repo-name.git
  git push -u origin main
  ```

#### 7\. Publish the Website to GitHub Pages

- Configure GitHub Pages to serve your Quarto site. Go to your repository settings on GitHub, navigate to the "Pages" section, and select the branch you want to use (e.g., `main`).

- Use the Quarto command to render and deploy your site to GitHub Pages:
  
  ```bash
  quarto publish gh-pages
  ```

### Example Code Structure

Here is an example of how your project structure might look:

```plaintext
my-quarto-site/
├── _quarto.yml
├── index.qmd
├── about.qmd
├── contact.qmd
├── .gitignore
└── .git/
```

And an example `_quarto.yml` file:

```yml
title: "My Quarto Site"
author: "Your Name"
theme: [journals]
nav:
  - Home: index.qmd
  - About: about.qmd
  - Contact: contact.qmd
extensions:
  - mermaid
```

### Submission Guidelines

- Fork the existing repository (if applicable) or create a new one on GitHub.
- Create a new branch named `MF01-PRA01-YourNameAndSurname` from the latest commit.
- Implement the required changes and tests.
- Commit your changes with clear, descriptive messages.
- Push your branch to your forked repository.
- Create a pull request to the original repository (if applicable) with a summary of your changes and title: `MF01-PRA01-YourNameAndSurname-PublishingQuartoDocumentation` 
  - Example: F01-PRA01-EmmaMoskovitz-PublishingQuartoDocumentation

### Evaluation Criteria

- Correct setup and configuration of the Quarto website
- Proper use of call-outs, new pages, basic formatting, and layout
- Effective implementation of Website Navigation
- Inclusion of Mermaid diagrams
- Correct configuration of the `_quarto.yml` file
- Successful setup of a Git repository and GitHub remote repository
- Successful publication of the website to GitHub Pages
- Code clarity and documentation quality
- Adherence to best practices for Quarto and GitHub Pages

Remember to focus on creating a well-structured and visually appealing Quarto website that demonstrates good documentation practices. Good luck!

### Desenvolupament MF01-PRA01

- adjunt imatges
