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
      url "https://github.com/jerilseb/dockmate/releases/download/v0.1.2/dockmate_0.1.2_darwin_arm64.tar.gz"
      sha256 "b1e249924dc0ada71ccf108df6b371d8b821a799a7b231a3731b4b58c43fcf81"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jerilseb/dockmate/releases/download/v0.1.2/dockmate_0.1.2_linux_amd64.tar.gz"
      sha256 "5d939277c141888096696c5f63c9197478cc9b63cad21d63cc2676871881f705"
    end
    on_arm do
      url "https://github.com/jerilseb/dockmate/releases/download/v0.1.2/dockmate_0.1.2_linux_arm64.tar.gz"
      sha256 "bfc760c42d8e39db11446aaf0e38f674f790cc88a45762464af7f8d0a7134f13"
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
