cask "claude-pulse" do
  version "0.3.0"
  sha256 "298bce39d8b4279fda335883eabd69c241c34cfa920bee146f8258db0a8f0d21"

  url "https://github.com/psalkowski/claude-pulse/releases/download/v#{version}/ClaudePulse-#{version}.dmg",
      verified: "github.com/psalkowski/claude-pulse/"
  name "Claude Pulse"
  desc "Menubar app and widget showing Claude Code usage limits"
  homepage "https://github.com/psalkowski/claude-pulse"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: ">= :sonoma"

  app "ClaudePulse.app"

  zap trash: [
    "~/Library/Application Support/ClaudePulse",
    "~/Library/Caches/com.claudepulse.app",
    "~/Library/Preferences/com.claudepulse.app.plist",
  ]

  caveats <<~EOS
    Claude Pulse is ad-hoc signed (not notarized). If it was installed with
    quarantine enabled, macOS blocks the first launch ("Apple could not
    verify..."): allow it via System Settings -> Privacy & Security -> Open
    Anyway, or run:
      xattr -dr com.apple.quarantine /Applications/ClaudePulse.app
    To skip quarantine at install time:
      HOMEBREW_CASK_OPTS=--no-quarantine brew reinstall --cask claude-pulse
  EOS
end
