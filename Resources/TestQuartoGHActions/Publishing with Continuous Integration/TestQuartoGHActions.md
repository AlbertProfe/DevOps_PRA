# Publishing with Continuous Integration (CI)

## Summary

Let's summary the process for setting up a GitHub Action to publish a Quarto project. Here’s a breakdown of the steps involved:

1. **Run Locally**: First, you need to run the command `quarto publish gh-pages` locally within your Quarto project. This step is crucial as it generates the necessary `_publish.yml` configuration file that will be used by the GitHub Action for subsequent invocations. This command publishes your content to the `gh-pages` branch of your repository and ensures that everything is set up correctly for future automated publishing.

2. **Create GitHub Action File**: After successfully running the local publish, you should create a YAML file for the GitHub Action. Save this file as `.github/workflows/publish.yml` in your project directory. The content of this file defines the workflow for rendering and publishing your site automatically whenever you push changes to the main branch or manually trigger it from the Actions tab.
   
   Here’s a sample of what your `publish.yml` might look like:
   
   ```yaml
   on:
     workflow_dispatch:
     push:
       branches: main
   
   name: Quarto Publish
   
   jobs:
     build-deploy:
       runs-on: ubuntu-latest
       permissions:
         contents: write
       steps:
         - name: Check out repository
           uses: actions/checkout@v4
   
         - name: Set up Quarto
           uses: quarto-dev/quarto-actions/setup@v2
   
         - name: Render and Publish
           uses: quarto-dev/quarto-actions/publish@v2
           with:
             target: gh-pages
           env:
             GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
   ```

3. **Commit and Push**: Once you have created and saved the `publish.yml` file, commit your changes and push them to your GitHub repository. This action will trigger the workflow defined in your YAML file, which will render your content and publish it to GitHub Pages automatically.

4. **Permissions**: Ensure that GitHub Actions has permission to write to your repository. You can check this under the "Actions" section in your repository settings, where you need to select "Read and write permissions" for workflows.

## Essential Elements of a YAML Workflow File

You can automate processes within your GitHub repository using GitHub Actions workflows. This setup allows for continuous integration and deployment, enhancing your development workflow with automation

Key Components

- **Triggers (`on`)**: Specify when the workflow should run.
- **Jobs**: Define tasks that run in parallel or sequentially.
- **Steps**: Individual commands or actions within a job.
- **Runners (`runs-on`)**: Specify the environment for running jobs, like `ubuntu-latest`.

To create a YAML workflow file, especially for GitHub Actions, you need to include several essential elements. Here’s a summary of the key components:

#### Elements of a YAML Workflow File

1. **Name**:
   
   - Defines the name of the workflow.
   
   - Example:
     
     ```yaml
     name: My Workflow
     ```

2. **Triggers (`on`)**:
   
   - Specifies the events that will trigger the workflow, such as `push`, `pull_request`, or scheduled events.
   
   - Example:
     
     ```yaml
     on:
       push:
         branches: 
           - main
     ```

3. **Jobs**:
   
   - A workflow must contain at least one job that defines the tasks to be executed.
   
   - Each job runs on a specified runner (e.g., `ubuntu-latest`).
   
   - Example:
     
     ```yaml
     jobs:
       build:
         runs-on: ubuntu-latest
     ```

4. **Steps**:
   
   - Each job consists of steps that define individual tasks, which can be actions or scripts.
   
   - Steps can use actions from the GitHub marketplace or run shell commands.
   
   - Example:
     
     ```yaml
     steps:
       - uses: actions/checkout@v3
       - name: Run a script
         run: echo "Hello, world!"
     ```

5. **Environment Variables** (optional):
   
   - You can define environment variables that can be used in your steps.
   
   - Example:
     
     ```yaml
     env:
       MY_VAR: value
     ```

6. **Outputs** (optional):
   
   - Define outputs from jobs that can be used by other jobs in the workflow.
   
   - Example:
     
     ```yaml
     outputs:
       my_output: ${{ steps.step_id.outputs.output_name }}
     ```

7. **Conditions** (optional):
   
   - You can specify conditions under which jobs or steps should run using `if`.
   
   - Example:
     
     ```yaml
     if: github.event_name == 'push'
     ```

<mark>Example Workflow File</mark>

Here’s a complete example of a simple YAML workflow file:

```yaml
name: CI Workflow

on:
  push:
    branches: 
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Set up Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '14'

      - name: Install dependencies
        run: npm install

      - name: Run tests
        run: npm test
```

This example defines a continuous integration (CI) workflow that triggers on pushes to the main branch, checks out the code, sets up Node.js, installs dependencies, and runs tests.

## References

[Publishing with Continuous Integration (CI) – Quarto](https://quarto.org/docs/publishing/ci.html)

[GitHub Pages – Quarto](https://quarto.org/docs/publishing/github-pages.html)

[GitHub Actions documentation - GitHub Docs](https://docs.github.com/en/actions)

[Workflow syntax for GitHub Actions - GitHub Docs](https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions)

[Learn YAML in Y Minutes](https://learnxinyminutes.com/docs/yaml/)

Some engines:

[GitHub - actions/checkout: Action for checking out a repo](https://github.com/actions/checkout)

[GitHub - quarto-dev/quarto-actions](https://github.com/quarto-dev/quarto-actions)

[quarto-actions/publish at main · quarto-dev/quarto-actions · GitHub](https://github.com/quarto-dev/quarto-actions/tree/main/publish)

[quarto-actions/render at main · quarto-dev/quarto-actions · GitHub](https://github.com/quarto-dev/quarto-actions/tree/main/render)
