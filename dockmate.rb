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
      url "https://github.com/jerilseb/dockmate/releases/download/v0.1.5/dockmate_0.1.5_darwin_arm64.tar.gz"
      sha256 "e27b911200b5ee226e0e3b36a13796aa4671557c37dc73c228e74b7aacd5da59"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jerilseb/dockmate/releases/download/v0.1.5/dockmate_0.1.5_linux_amd64.tar.gz"
      sha256 "f69064046ef17b1f9efcbb9b31fe29fc484ed678d55430de53f98659944da092"
    end
    on_arm do
      url "https://github.com/jerilseb/dockmate/releases/download/v0.1.5/dockmate_0.1.5_linux_arm64.tar.gz"
      sha256 "543ca07c075ec091d392c1e3dbcd12c791f55ade15664c8e72ee91bd8f2febc4"
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
