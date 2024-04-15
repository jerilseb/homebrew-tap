# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class MyCli < Formula
  desc "A simple CLI for testing purposes"
  homepage "https://github.com/jerilseb/my-cli"
  version "1.0.4"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/jerilseb/my-cli/releases/download/v1.0.4/my-cli_1.0.4_darwin_amd64.tar.gz"
      sha256 "e44fdad0557b3cb5d019a1b6c9727e8ff24bbd551c551dbcb6e6204eb07dd656"

      def install
        bin.install "mycli"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/jerilseb/my-cli/releases/download/v1.0.4/my-cli_1.0.4_darwin_arm64.tar.gz"
      sha256 "78a708d912cf1821a04d7e65f1b0894e4aafbcb1f7d99119b1b726313ac884ec"

      def install
        bin.install "mycli"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/jerilseb/my-cli/releases/download/v1.0.4/my-cli_1.0.4_linux_amd64.tar.gz"
      sha256 "4309bf9188b061c11cda56c577e6fc9dd54e7ca95f7eb17ed2f8455283517a2f"

      def install
        bin.install "mycli"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/jerilseb/my-cli/releases/download/v1.0.4/my-cli_1.0.4_linux_arm64.tar.gz"
      sha256 "63c2fb1aa61ee67a114a0d028e0a38df3fac83c9455e8f014f79c57ecb7a2ab5"

      def install
        bin.install "mycli"
      end
    end
  end
end
