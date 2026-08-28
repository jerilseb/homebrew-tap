# typed: false
# frozen_string_literal: true

# Maintained by hand. jsonl is a Rust crate, so unlike the other formulae here
# there is no GoReleaser pipeline to regenerate this file: bump the urls and
# sha256s from the release workflow's job summary when tagging a version.
class Jsonl < Formula
  desc "Terminal viewer for JSONL (newline-delimited JSON) files"
  homepage "https://github.com/jerilseb/jsonl"

  on_macos do
    # Apple silicon only.
    on_arm do
      url "https://github.com/jerilseb/jsonl/releases/download/v0.1.6/jsonl_0.1.6_darwin_arm64.tar.gz"
      sha256 "939f904ae78f869506fedab624224a83bed0a5c0c80a5cdb0d2e866df5248555"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jerilseb/jsonl/releases/download/v0.1.6/jsonl_0.1.6_linux_amd64.tar.gz"
      sha256 "9932b07e15932088db2c6623fd6aa8af72a3a83747b1782c7d165b1179190bf9"
    end
    on_arm do
      url "https://github.com/jerilseb/jsonl/releases/download/v0.1.6/jsonl_0.1.6_linux_arm64.tar.gz"
      sha256 "090271abb3bae5eb7255352423826cad914cce56653d34f8f0de70d77943f723"
    end
  end

  def install
    bin.install "jsonl"
  end

  test do
    assert_match "jsonl #{version}", shell_output("#{bin}/jsonl --version")

    (testpath/"events.jsonl").write <<~JSONL
      {"level":"info","msg":"server started"}
      {"level":"warn","msg":"slow query","ms":1423.5}
    JSONL

    # The viewer draws on a terminal, so with output piped it should say so
    # rather than fail somewhere inside raw-mode setup.
    output = shell_output("#{bin}/jsonl #{testpath}/events.jsonl 2>&1", 1)
    assert_match "not a terminal", output
  end
end
