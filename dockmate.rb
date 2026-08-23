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
      url "https://github.com/jerilseb/dockmate/releases/download/v0.1.3/dockmate_0.1.3_darwin_arm64.tar.gz"
      sha256 "81a84c0c2c554c31fc726923beae17edc1c57aadd88e10dc4a1764d50f1e4612"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jerilseb/dockmate/releases/download/v0.1.3/dockmate_0.1.3_linux_amd64.tar.gz"
      sha256 "c11a9b41f72c37183a6266191e0d266ef186844cda501503ee7130260797be49"
    end
    on_arm do
      url "https://github.com/jerilseb/dockmate/releases/download/v0.1.3/dockmate_0.1.3_linux_arm64.tar.gz"
      sha256 "006bddb5f8ace5e6a94ef7d35e9c0686f808175d7135b54188414d3227c594f7"
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
