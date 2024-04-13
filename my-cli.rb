class MyCli < Formula
    desc "My CLI"
    homepage "https://github.com/jerilseb/my-cli"
    url "https://github.com/jerilseb/my-cli/releases/download/v1.0.1/mycli-linux-amd64.tar.gz"
    sha256 "a25c833611457c558b949fd3ffe610fd2afb8574cbb65f2f09295560338e3a45"

    def install
        bin.install "my-cli"
    end
  end
