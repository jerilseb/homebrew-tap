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
      url "https://github.com/jerilseb/jsonl/releases/download/v0.1.3/jsonl_0.1.3_darwin_arm64.tar.gz"
      sha256 "b1f2268ba4d83e4167562893416e1bb1bd854f374b78efd63b9f4e527dc61974"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jerilseb/jsonl/releases/download/v0.1.3/jsonl_0.1.3_linux_amd64.tar.gz"
      sha256 "794b802653e598b14b88d753f63543b7a94055df54011961cd9de609cf5075bc"
    end
    on_arm do
      url "https://github.com/jerilseb/jsonl/releases/download/v0.1.3/jsonl_0.1.3_linux_arm64.tar.gz"
      sha256 "0d746cc68dad995ef9b16ae030eece8d98f1c1187759307351d7bf6fa5f3ecbf"
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
