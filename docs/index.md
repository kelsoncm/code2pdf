# code2pdf

[![Docker Image](https://img.shields.io/badge/docker-image%20available-blue?logo=docker)](https://hub.docker.com/r/kelsoncm/code2pdf)
[![Latest Tag](https://img.shields.io/github/v/tag/kelsoncm/code2pdf?label=version)](https://github.com/kelsoncm/code2pdf/tags)
[![License](https://img.shields.io/github/license/kelsoncm/code2pdf)](https://github.com/kelsoncm/code2pdf/blob/main/LICENSE)
[![Repo Size](https://img.shields.io/github/repo-size/kelsoncm/code2pdf)](https://github.com/kelsoncm/code2pdf)
[![Last Commit](https://img.shields.io/github/last-commit/kelsoncm/code2pdf)](https://github.com/kelsoncm/code2pdf/commits/main)

A lightweight Docker image (~100MB) that turns a project directory into a PDF document 
by rendering source code files in a clean, readable layout.

This project wraps the Rust-based [code-to-pdf](https://github.com/Tommypop2/code-to-pdf)
tool and is designed to be used as a simple, reproducible container for generating a code
snapshot from any repository or folder.

## Why use it?

- Generate a PDF from an entire source tree in one command
- Respect project ignore rules from `.gitignore` and `.ignore`
- Keep the output portable and easy to share
- Run consistently in Docker without installing local toolchains
- Suitable for technical documentation, code reviews, and archive snapshots

## Quick start

Mount your project into the container at `/code` and let the tool generate the PDF in the current directory.

```bash
docker run --rm -v "$PWD":/code kelsoncm/code2pdf
```

Obtaining help:

```bash
docker run --rm -v "$PWD":/code kelsoncm/code2pdf --help
```

By default, the output PDF is created as `output.pdf` in the working directory used by the container process.

## Example

```bash
docker run --rm -v "$PWD":/code -v "$PWD":/output kelsoncm/code2pdf --out /output/project-code.pdf
```

This pattern is useful when you want the generated PDF to be saved outside the mounted project folder.

## Runtime behavior

The container expects the source directory to be mounted at `/code` and uses that directory as the input walk path. 
The default command is:

```bash
/usr/local/bin/c2pdf .
```

So the usual workflow is simply:

```bash
docker run --rm -v "$PWD":/code kelsoncm/code2pdf
```

## Files respected during execution

The application does not require a dedicated config file, but it follows common project conventions while scanning input files.

### 1. Ignore rules

The generator respects exclusion patterns declared in:

- `.gitignore`
- `.ignore`

This keeps generated PDFs focused on meaningful source files and avoids dumping generated artifacts, dependencies, or build outputs.

### 2. Custom fonts

Custom fonts can be loaded with the `--font` option. You may pass either:

- a system font name, or
- a path to a `.ttf` file

This is useful when you want consistent branding or a specific monospaced style in the exported PDF.

## CLI options

The binary supports the following arguments and flags:

| Flag | Description | Default |
| --- | --- | --- |
| `walk_path` | Positional path to the directory to process | Required; in this image, usually `/code` |
| `--out` | Output PDF path | `output.pdf` |
| `--exclude` | Comma-separated globs to ignore | `pnpm-lock.yaml,Cargo.lock` |
| `--name` | PDF document name | `Project Code` |
| `--include-path` | Include the file path at the top of each page | `true` |
| `--font` | System font name or path to a font file | Embedded default (`Helvetica`) |
| `--font-size` | Font size in points | `12.0` |
| `--margin-top` | Top margin in mm | `20.0` |
| `--margin-bottom` | Bottom margin in mm | `5.0` |
| `--margin-left` | Left margin in mm | `10.0` |
| `--margin-right` | Right margin in mm | `10.0` |
| `--page-text` | Custom text inserted at the top of each page | None |
| `--threads` | Number of Rayon worker threads | Automatic |
| `--image-quality` | Image compression quality from `0.0` to `1.0` | `0.85` |
| `--no-log` | Disable execution logs | `false` |

## Example commands

### Basic usage

```bash
docker run --rm -v "$PWD":/code kelsoncm/code2pdf
```

### Save to a specific output file

```bash
docker run --rm -v "$PWD":/code kelsoncm/code2pdf --out /code/project-code.pdf
```

### Exclude specific files

```bash
docker run --rm -v "$PWD":/code kelsoncm/code2pdf --exclude "target/**,.venv/**,node_modules/**"
```

### Use a custom font

```bash
docker run --rm -v "$PWD":/code -v "$PWD":/fonts kelsoncm/code2pdf --font /fonts/JetBrainsMono-Regular.ttf
```

## Docker image details

This image uses a two-stage build:

1. A Rust builder stage compiles the `c2pdf` binary
2. A slim Debian runtime stage installs only the essentials needed to execute it

This keeps the final runtime image lighter and more predictable than building the binary inside the same layer.

## License

This project is distributed under the terms of the repository license. See the LICENSE file for details.

## Contributing

Contributions are welcome. If you improve the Docker image, CLI behavior, or documentation, please open a pull 
request with a concise description of the change and its purpose.
