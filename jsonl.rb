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
      url "https://github.com/jerilseb/jsonl/releases/download/v0.1.4/jsonl_0.1.4_darwin_arm64.tar.gz"
      sha256 "205728711b6e3514d596de8b696f1ba2c5289897e3444bab98d79672c26e271f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jerilseb/jsonl/releases/download/v0.1.4/jsonl_0.1.4_linux_amd64.tar.gz"
      sha256 "9cf5f72199b768b333c3fe126281e97afe1fd945c3fef2852dd09f176478ea3c"
    end
    on_arm do
      url "https://github.com/jerilseb/jsonl/releases/download/v0.1.4/jsonl_0.1.4_linux_arm64.tar.gz"
      sha256 "44c03136f07cb64d62944ad7dd8adeeb7e4be282d01bc3ba7fbc385877b13760"
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
