# typed: false
# frozen_string_literal: true

# Maintained by hand. dockmate is a Rust crate, so unlike the other formulae
# here there is no GoReleaser pipeline to regenerate this file: bump the urls
# and sha256s from the release workflow's job summary when tagging a version.
class Dockmate < Formula
  desc "Terminal UI for managing Docker containers, images, volumes and networks"
  homepage "https://github.com/jerilseb/dockmate"

  on_macos do
    # Apple silicon only.
    on_arm do
      url "https://github.com/jerilseb/dockmate/releases/download/v0.1.1/dockmate_0.1.1_darwin_arm64.tar.gz"
      sha256 "3562014daa578a784ae4399740d7b2a1086a8a13d398c3ed13884740eb48c7e1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jerilseb/dockmate/releases/download/v0.1.1/dockmate_0.1.1_linux_amd64.tar.gz"
      sha256 "bcee6466b9bf8f70dff0d04d740d9707719b1ade68b7dfc04a26f4b452917924"
    end
    on_arm do
      url "https://github.com/jerilseb/dockmate/releases/download/v0.1.1/dockmate_0.1.1_linux_arm64.tar.gz"
      sha256 "e9cfd41d49920b9a8da6864f6a962019be6198fd82ef69bc77fc17a4fe650f80"
    end
  end

  def install
    bin.install "dockmate"
  end

  test do
    assert_match "dockmate #{version}", shell_output("#{bin}/dockmate --version")

    # dockmate needs a daemon to show anything, and the test machine may or may
    # not have one. Point it at a socket that certainly is not there, so the
    # assertion holds either way: it must fail with the daemon error rather
    # than hanging or dying inside terminal setup.
    output = shell_output("DOCKER_HOST=unix://#{testpath}/absent.sock #{bin}/dockmate 2>&1", 1)
    assert_match "docker daemon", output
  end
end
