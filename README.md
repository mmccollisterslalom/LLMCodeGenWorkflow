# LLM-Powered Code Review and Test Identification

This package enables automated code repository reviews and test identification using LLMs. It leverages:

- **Repomix** to bundle repository content into a single AI-friendly file.
- **LLM (Python CLI Utility)** with **Ollama** and **Mistral** to perform code analysis and generate insights.
- **Mise** to ensure a repeatable and streamlined setup workflow.

## Prerequisites

Ensure your system meets the following requirements:

### Install Dependencies

1. **Install Repomix** (for creating an AI-friendly bundle):

   ```sh
   pip install repomix
   ```

2. **Install LLM CLI** (for running LLM-based tasks):

   ```sh
   pip install llm
   ```

3. **Install LLM-Ollama Plugin** (for integrating with Ollama models):

   ```sh
   llm install llm-ollama
   ```

4. **Install Ollama and Mistral Model**:
   Follow the installation guide at [Ollama](https://ollama.ai/), then run:

   ```sh
   ollama pull mistral
   ```

5. **Install Mise** (for repeatable workflows):

   ```sh
   curl https://mise.run | sh
   ```

## Setting Up LLM Task List

The following tasks automate code review and test identification:

| Task Command                 | Description                                                                       |
| ---------------------------- | --------------------------------------------------------------------------------- |
| `LLM:clean_bundles`          | Generate LLM bundle output file using Repomix.                                    |
| `LLM:copy_buffer_bundle`     | Copy generated LLM bundle from `output.txt` to system clipboard.                 |
| `LLM:generate_code_review`   | Generate a code review output from repository content.                           |
| `LLM:generate_github_issues` | Generate GitHub issues from repository content.                                  |
| `LLM:generate_missing_tests` | Generate missing tests for code in repository content.                           |
| `LLM:generate_readme`        | Generate `README.md` from repository content.                                    |

## Setting Up LLM Prompts

The following prompts guide LLM behavior for each task:

### Code Review

```sh
llm 'Perform a detailed code review' \
  --system 'You are a senior developer. Your job is to do a thorough code review of this code. You should write it up and output markdown. Include line numbers, and contextual info. Your code review will be passed to another teammate, so be thorough. Think deeply before writing the code review. Review every part, and do not hallucinate.'
```

### GitHub Issue Generation

```sh
llm 'Identify top issues in the code' \
  --system 'You are a senior developer. Your job is to review this code and write out the top issues that you see. It could be bugs, design choices, or code cleanliness issues. Be specific and precise. Do Not Hallucinate. Think quietly to yourself, then act - write the issues. The issues will be given to a developer to execute on, so they should be in a format compatible with GitHub issues.'
```

### Missing Tests

```sh
llm 'Identify missing test cases' \
  --system 'You are a senior developer. Your job is to review this code and write out a list of missing test cases and tests that should exist. Be specific and precise. Do Not Hallucinate. Think quietly to yourself, then act - write the issues. The issues will be given to a developer to execute on, so they should be in a format compatible with GitHub issues.'
```

## Defining Mise Tasks

Mise allows defining tasks in `mise.toml` or standalone shell scripts in `mise-tasks/`. The following tasks should be set up in `mise.toml`:

### Example `mise.toml` Configuration

```toml
[tasks.LLM:clean_bundles]
description = "Generate LLM bundle output file using Repomix"
run = "repomix bundle . > output.txt"

[tasks.LLM:copy_buffer_bundle]
description = "Copy generated LLM bundle from output.txt to clipboard"
run = "cat output.txt | pbcopy"

[tasks.LLM:generate_code_review]
description = "Generate code review from repository content"
run = "llm 'Perform a detailed code review' --system \"You are a senior developer. Your job is to do a thorough code review of this code. You should write it up and output markdown. Include line numbers, and contextual info. Your code review will be passed to another teammate, so be thorough. Think deeply before writing the code review. Review every part, and do not hallucinate.\" < output.txt > code_review.md"

[tasks.LLM:generate_github_issues]
description = "Generate GitHub issues from repository content"
run = "llm 'Identify top issues in the code' --system \"You are a senior developer. Your job is to review this code and write out the top issues that you see. It could be bugs, design choices, or code cleanliness issues. Be specific and precise. Do Not Hallucinate. Think quietly to yourself, then act - write the issues. The issues will be given to a developer to execute on, so they should be in a format compatible with GitHub issues.\" < output.txt > github_issues.md"

[tasks.LLM:generate_missing_tests]
description = "Generate missing tests from repository content"
run = "llm 'Identify missing test cases' --system \"You are a senior developer. Your job is to review this code and write out a list of missing test cases and tests that should exist. Be specific and precise. Do Not Hallucinate. Think quietly to yourself, then act - write the issues. The issues will be given to a developer to execute on, so they should be in a format compatible with GitHub issues.\" < output.txt > missing_tests.md"
```

## Running Tasks

Run tasks using:

```sh
mise run <task_name>
```

Examples:

```sh
mise run LLM:clean_bundles
mise run LLM:generate_code_review
mise run LLM:generate_github_issues
mise run LLM:generate_missing_tests
```

Use `mise watch <task_name>` to automatically rerun a task when files change.

## Contributing

Contributions are welcome! Please submit issues or pull requests to improve functionality.

## License

This project is licensed under the MIT License.

