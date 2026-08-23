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
      url "https://github.com/jerilseb/dockmate/releases/download/v0.1.4/dockmate_0.1.4_darwin_arm64.tar.gz"
      sha256 "931ff30e0f8cfd79a6558d0a42396ca1c1d6f4c9682a0ea10cc848c0854aa743"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jerilseb/dockmate/releases/download/v0.1.4/dockmate_0.1.4_linux_amd64.tar.gz"
      sha256 "79fa006c3e1a981533c941b97bc8f0acabbc8c34a5a0bbed597ef7d2bb05962a"
    end
    on_arm do
      url "https://github.com/jerilseb/dockmate/releases/download/v0.1.4/dockmate_0.1.4_linux_arm64.tar.gz"
      sha256 "9a056419dcadb60458cad006e97a96eca854aa023fec2c26b2369b2f8daa9ab3"
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
