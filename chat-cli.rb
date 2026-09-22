# typed: false
# frozen_string_literal: true

# Maintained by hand. chat-cli is a Rust crate, so there is no GoReleaser
# pipeline to regenerate this file: bump the version, urls and sha256s from the
# release workflow's job summary when tagging a version.
class ChatCli < Formula
  desc "TUI chat client for OpenAI completions, OpenAI responses and Anthropic messages"
  homepage "https://github.com/jerilseb/chat-cli"
  version "0.2.0"
  license "MIT"

  on_macos do
    # Apple silicon only.
    on_arm do
      url "https://github.com/jerilseb/chat-cli/releases/download/v0.2.0/chat-cli_0.2.0_darwin_arm64.tar.gz"
      sha256 "9e3bcf432ee29066d72eb5352d9f3ecd98acf9ee601f8b8ae1435152599ac093"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/jerilseb/chat-cli/releases/download/v0.2.0/chat-cli_0.2.0_linux_amd64.tar.gz"
      sha256 "014ec35882cd75c25655eabdcb4227d3bf2a9d769c7104b03c03e52cab13e528"
    end
    on_arm do
      url "https://github.com/jerilseb/chat-cli/releases/download/v0.2.0/chat-cli_0.2.0_linux_arm64.tar.gz"
      sha256 "a67e6bd30dc286d98cc77e38d75e4e2ba3966bd26dfa7dbeaa416ceb4b73a61c"
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
