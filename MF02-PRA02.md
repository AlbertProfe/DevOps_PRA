## MF02-PRA02: Automating Quarto Documentation Publishing with GitHub Actions

### CIFO La Violeta - DevOps IFCT0116-24 MF02

In this practical exercise, you will automate the process of committing, deploying, and publishing your Quarto documentation to GitHub Pages using GitHub Actions. This will eliminate the need to manually run the `quarto publish` command locally each time you update your documentation.

### Objectives

- Automate the commit and push process using GitHub Actions.
- Set up a GitHub Action workflow to render and publish your Quarto site automatically.

### Tasks

#### 1. Complete a Local Publish

Before setting up automation, ensure you've completed a local publish of your Quarto project. This step is necessary to generate the `_publish.yml` configuration file required by GitHub Actions.

```bash
quarto publish gh-pages
```

#### 2. Create a `publish.yml` GitHub Action

Add a `publish.yml` file to your project to automate the publishing process. Save this file in `.github/workflows/`.

```yaml
name: Quarto Publish

on:
  push:
    branches:
      - main
  workflow_dispatch:

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

This action will trigger every time you push changes to the `main` branch or manually dispatch the workflow[2][5][6].

### Reference Documentation

- [GitHub Pages - Quarto](https://quarto.org/docs/publishing/github-pages.html)

### Submission Guidelines

- Fork the existing repository (if applicable) or create a new one on GitHub.
- Create a new branch named `MF02-PRA02-YourNameAndSurname` from the latest commit.
- Implement the required changes and tests.
- Commit your changes with clear, descriptive messages.
- Push your branch to your forked repository.
- Create a pull request to the original repository (if applicable) with a summary of your changes and title: `MF02-PRA02-YourNameAndSurname-AutomatingQuartoPublishing`
  - Example: `MF02-PRA02-EmmaMoskovitz-AutomatingQuartoPublishing`

### Evaluation Criteria

- Successful automation of the commit and push process using GitHub Actions.
- Correct setup of the `publish.yml` file.
- Proper execution of the Quarto site rendering and publishing workflow.
- Code clarity and documentation quality.
- Adherence to best practices for GitHub Actions and Quarto.

By following these steps, you will streamline your documentation workflow, ensuring that updates are automatically published without manual intervention.

Citations:
[1] https://www.youtube.com/watch?v=5zYrgRylkH0
[2] https://quarto.org/docs/publishing/github-pages.html
[3] https://github.com/quarto-dev/quarto-actions
[4] https://github.com/quarto-dev/quarto-cli/discussions/7776
[5] https://quarto.org/docs/publishing/ci.html
[6] https://thedatasavvycorner.com/blogs/03-quarto-github-actions
[7] https://www.youtube.com/watch?v=arzBRW5XIkg
[8] https://github.com/quarto-dev/quarto-actions/blob/main/examples/example-01-basics.md
[9] https://github.com/marketplace/actions/quarto-render

### Practica MF02-PRA02:
<https://github.com/emiralya8/Pract01Quarto/commit/6e063ec9a99e8f3f322063289918d07e55e9a3f4>
<https://github.com/emiralya8/Pract01Quarto>
