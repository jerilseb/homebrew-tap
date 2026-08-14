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
      url "https://github.com/jerilseb/dockmate/releases/download/v0.1.0/dockmate_0.1.0_darwin_arm64.tar.gz"
      sha256 "6766453a78ad77366ebe3ec0029d0f90e4a6694b741bc3ccfc1e8eeafa13250b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jerilseb/dockmate/releases/download/v0.1.0/dockmate_0.1.0_linux_amd64.tar.gz"
      sha256 "62c16a5147ffbf36d521dea0cd20cf5f471a8fbcccabcc59b24d07d562cb75fe"
    end
    on_arm do
      url "https://github.com/jerilseb/dockmate/releases/download/v0.1.0/dockmate_0.1.0_linux_arm64.tar.gz"
      sha256 "ab9a49a30be5f60bba95d8deb9a445dbb13a80377bcd9e2a30c94aa8f2dc9b24"
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
