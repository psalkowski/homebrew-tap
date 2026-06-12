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
  depends_on macos: :sonoma

  app "ClaudePulse.app"

  uninstall quit: "com.claudepulse.app"

  zap trash: [
    "~/Library/Application Support/ClaudePulse",
    "~/Library/Caches/com.claudepulse.app",
    "~/Library/Preferences/com.claudepulse.app.plist",
  ]

  caveats <<~EOS
    Claude Pulse is ad-hoc signed (not notarized), so macOS Gatekeeper blocks the
    first launch ("Apple could not verify..."). Homebrew always quarantines casks
    (the --no-quarantine flag and HOMEBREW_CASK_OPTS no longer disable it), so
    after install run this once to allow it:

      xattr -dr com.apple.quarantine /Applications/ClaudePulse.app

    Then open it normally. (Alternatively: launch it once, click Done, then
    System Settings -> Privacy & Security -> Open Anyway.)
  EOS
end
