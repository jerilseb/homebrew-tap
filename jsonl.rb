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
      url "https://github.com/jerilseb/jsonl/releases/download/v0.1.0/jsonl_0.1.0_darwin_arm64.tar.gz"
      sha256 "d511c1f3e9af3fa2d18bf376ef2313fd149084096b5143c0bf8406ba8efec40f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jerilseb/jsonl/releases/download/v0.1.0/jsonl_0.1.0_linux_amd64.tar.gz"
      sha256 "f170d53197a0c042d3b30ea5e69a7883e406195c8fc8bb47fefe34545de6e98d"
    end
    on_arm do
      url "https://github.com/jerilseb/jsonl/releases/download/v0.1.0/jsonl_0.1.0_linux_arm64.tar.gz"
      sha256 "0b9c273567ace24e293411d078e00326eda5ca76b8e8332c6dd5771fc032aebf"
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
