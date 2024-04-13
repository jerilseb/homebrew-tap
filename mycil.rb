class Mycli < Formula
    desc "My CLI"
    homepage "https://github.com/jerilseb/my-cli"
    url "https://github.com/user/mycli/archive/v1.0.0.tar.gz"
    sha256 "<SHA256>"

    def install
      system "go", "build", "-o", "bin/mycli"
    end
  end
