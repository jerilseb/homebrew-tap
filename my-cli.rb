class MyCli < Formula
    desc "My CLI"
    homepage "https://github.com/jerilseb/my-cli"
    url "https://github.com/jerilseb/my-cli/releases/download/v1.0.1/mycli-linux-amd64.tar.gz"
    sha256 "203e153de03778368d610aa530963ed45205a1a0d299f27ff9f6d5f747e3498d"

    def install
        bin.install "my-cli"
    end
  end
