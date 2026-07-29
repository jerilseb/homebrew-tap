# homebrew-tap

Homebrew formulae for my command-line tools.

## Install

Add the tap once:

```sh
brew tap jerilseb/tap
```

Then install anything from it:

```sh
brew install jerilseb/tap/spacer
```

Or skip the tap step and install directly:

```sh
brew install jerilseb/tap/<formula>
```

## Formulae

| Formula | Version | Description | Platforms |
| --- | --- | --- | --- |
| [`bash-generator`](https://github.com/jerilseb/bash-generator) | 1.0.9 | Generate Bash commands by saying what you want | Linux (x86_64) |
| [`jsonl`](https://github.com/jerilseb/jsonl) | 0.1.3 | Terminal viewer for JSONL (newline-delimited JSON) files | macOS (Apple silicon), Linux (x86_64, arm64) |
| [`my-cli`](https://github.com/jerilseb/my-cli) | 1.0.4 | A simple CLI for testing purposes | macOS, Linux (x86_64, arm64) |
| [`spacer`](https://github.com/jerilseb/spacer) | 1.0.0 | A CLI app for cleaning up large files | macOS, Linux (x86_64, arm64) |

### bash-generator

Describe what you want in plain language and get the Bash command back.

```sh
brew install jerilseb/tap/bash-generator
```

> Currently ships a Linux x86_64 build only.

### jsonl

Opens a JSONL file with every line collapsed to one row; click a line, or press
Enter, to expand it into pretty-printed, syntax-colored JSON.

```sh
brew install jerilseb/tap/jsonl
```

> The Linux builds are statically linked against musl, so they run on any
> distro regardless of its glibc version. macOS is Apple silicon only.

### my-cli

A small CLI used for testing the release and packaging pipeline.

```sh
brew install jerilseb/tap/my-cli
```

### spacer

Finds and cleans up large files to reclaim disk space.

```sh
brew install jerilseb/tap/spacer
```

## Upgrading

```sh
brew update
brew upgrade jerilseb/tap/spacer
```

## Uninstalling

```sh
brew uninstall spacer
brew untap jerilseb/tap   # removes the tap entirely
```

## Notes

Most formulae in this tap are generated automatically by [GoReleaser](https://goreleaser.com)
when a new version of a tool is released, so please don't edit those `.rb` files by
hand — changes will be overwritten by the next release. `jsonl` is the exception: it
is a Rust crate with no GoReleaser pipeline, so its formula is maintained by hand.
Its binaries are built by a GitHub Actions workflow on the release tag, which prints
the `url`/`sha256` values to paste in as its job summary.

Issues and feature requests belong in each tool's own repository, linked in the
table above.
