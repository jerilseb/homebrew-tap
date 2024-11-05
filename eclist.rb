# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Eclist < Formula
  desc "List EC2 instances"
  homepage "https://github.com/jerilseb/eclist"
  version "1.0.0"

  on_macos do
    on_intel do
      url "https://github.com/jerilseb/eclist/releases/download/v1.0.0/eclist_1.0.0_darwin_amd64.tar.gz"
      sha256 "f6016d37a8330c58ae427ec7e90f46154f53e84e1bf99fc8e78443a8deb5ed5a"

      def install
        bin.install "eclist"
      end
    end
    on_arm do
      url "https://github.com/jerilseb/eclist/releases/download/v1.0.0/eclist_1.0.0_darwin_arm64.tar.gz"
      sha256 "7865982ef913ceeae4dd41d45ff4501482ba40c14e41629a9ae2494ee159fb88"

      def install
        bin.install "eclist"
      end
    end
  end

  on_linux do
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/jerilseb/eclist/releases/download/v1.0.0/eclist_1.0.0_linux_amd64.tar.gz"
        sha256 "df5dd9ae4cb80b382d750832180c0316120d8a7456a971143cb84c41eef69b33"

        def install
          bin.install "eclist"
        end
      end
    end
    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/jerilseb/eclist/releases/download/v1.0.0/eclist_1.0.0_linux_arm64.tar.gz"
        sha256 "b0bd40240985449100149d5cdc4c1813186fdffe330ce71e4bf5232597c5e5e6"

        def install
          bin.install "eclist"
        end
      end
    end
  end
end