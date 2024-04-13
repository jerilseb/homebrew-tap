class MyCli < Formula
    desc "My CLI"
    homepage "https://github.com/jerilseb/my-cli"
    url "https://github.com/jerilseb/my-cli/releases/download/v1.0.0/mycli-linux.tar.gz"
    sha256 "a25c833611457c558b949fd3ffe610fd2afb8574cbb65f2f09295560338e3a45"

    def install
      system "go", "build", "-o", bin/"my-cli"
    end
  end
