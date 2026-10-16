cask "claude-pulse" do
  version "0.8.0"
  sha256 "cb5ae4a74b907363539b2e5aca339876f691956c461c079c1d0efaa4138c041c"

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

  # User-level install: Sparkle self-updates without an admin prompt, which
  # /Applications requires on managed (MDM) Macs.
  app "ClaudePulse.app", target: "#{Dir.home}/Applications/ClaudePulse.app"

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

      xattr -dr com.apple.quarantine ~/Applications/ClaudePulse.app

    Then open it normally. (Alternatively: launch it once, click Done, then
    System Settings -> Privacy & Security -> Open Anyway.)
  EOS
end
