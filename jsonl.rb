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
      url "https://github.com/jerilseb/jsonl/releases/download/v0.1.5/jsonl_0.1.5_darwin_arm64.tar.gz"
      sha256 "7ee9694ef353cb799602b41888c2f89b16e4da98ad2f8d17a52b76705a8973b5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jerilseb/jsonl/releases/download/v0.1.5/jsonl_0.1.5_linux_amd64.tar.gz"
      sha256 "3ce164546df62921cd1311b5f661a83113e8b9fc8b897a56cc002c3da77926d9"
    end
    on_arm do
      url "https://github.com/jerilseb/jsonl/releases/download/v0.1.5/jsonl_0.1.5_linux_arm64.tar.gz"
      sha256 "1845eed7107250909b57c8775359f4bc118208125e222b9f87393f6fc4939897"
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
