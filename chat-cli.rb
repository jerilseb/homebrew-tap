# typed: false
# frozen_string_literal: true

# Maintained by hand. chat-cli is a Rust crate, so there is no GoReleaser
# pipeline to regenerate this file: bump the version, urls and sha256s from the
# release workflow's job summary when tagging a version.
class ChatCli < Formula
  desc "TUI chat client for OpenAI completions, OpenAI responses and Anthropic messages"
  homepage "https://github.com/jerilseb/chat-cli"
  version "0.1.0"
  license "MIT"

  on_macos do
    # Apple silicon only.
    on_arm do
      url "https://github.com/jerilseb/chat-cli/releases/download/v0.1.0/chat-cli_0.1.0_darwin_arm64.tar.gz"
      sha256 "80e7390c5eaa0e96ececd29a3e816fd2fd01a83ee8bd8d04e4461787801792df"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jerilseb/chat-cli/releases/download/v0.1.0/chat-cli_0.1.0_linux_amd64.tar.gz"
      sha256 "432bf039261d216cca9f88bc9d5d1ca1ae70886a971cf5b8de93d9248b828052"
    end
    on_arm do
      url "https://github.com/jerilseb/chat-cli/releases/download/v0.1.0/chat-cli_0.1.0_linux_arm64.tar.gz"
      sha256 "57cde5d34e02abbac1a5b62ce56bb1969fe61e0adf410c10c90de9e469da444f"
    end
  end

  def install
    bin.install "chat-cli"
    doc.install "README.md", ".env.example"
    # `license` above only records which one it is; this ships the notice.
    prefix.install "LICENSE"
  end

  test do
    assert_match "chat-cli #{version}", shell_output("#{bin}/chat-cli --version")

    # Everything below is offline and passes its key explicitly. `--models` and
    # `--probe` are the only commands that go to the network, and what answers
    # an API endpoint from the machine running this is not something a formula
    # test should have an opinion about.
    #
    # The key variables are deleted rather than merely left unset, so the "no
    # key" case below tests what it says it does even on a machine that exports
    # one.
    ENV.delete("OPENAI_API_KEY")
    ENV.delete("ANTHROPIC_API_KEY")
    ENV.delete("CHAT_API_KEY")
    key = "sk-test-0123456789"

    # The default wire format, and an endpoint replacing the vendor's own.
    config = shell_output("#{bin}/chat-cli -k #{key} -e http://127.0.0.1:4000/v1 --config")
    assert_match "api type:    completions", config
    assert_match "http://127.0.0.1:4000/v1/chat/completions", config
    # The key is reported as present, never printed back whole.
    refute_match key, config

    # Each --type resolves to its own vendor endpoint and path.
    assert_match "https://api.anthropic.com/v1/messages",
                 shell_output("#{bin}/chat-cli -t messages -k #{key} --config")
    assert_match "https://api.openai.com/v1/responses",
                 shell_output("#{bin}/chat-cli -t responses -k #{key} --config")

    # A vendor endpoint with no key anywhere fails at startup, naming the
    # variable it wanted, rather than after the first prompt.
    assert_match "ANTHROPIC_API_KEY",
                 shell_output("#{bin}/chat-cli -t messages --config 2>&1", 1)

    # An unknown flag is a usage error, not a crash.
    assert_match "unknown flag", shell_output("#{bin}/chat-cli --nope 2>&1", 2)
  end
end
