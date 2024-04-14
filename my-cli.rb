class MyCli < Formula
    desc "My CLI"
    homepage "https://github.com/jerilseb/my-cli"
    version "1.0.1"

    if OS.linux?
        if Hardware::CPU.intel?
            url "https://github.com/jerilseb/my-cli/releases/download/v1.0.1/mycli-linux-amd64.tar.gz"
            sha256 "203e153de03778368d610aa530963ed45205a1a0d299f27ff9f6d5f747e3498d"
        else
            odie "Only amd64 is supported"
        end
    else
        odie "Only Linux is supported"
    end

    def install
        bin.install "mycli"
    end
  end
