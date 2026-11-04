cask "callkeep" do
  version "1.0.19"
  sha256 "26d7db44427d3fbc379103e6169348e7cb5523176f267d5a0427630544c7aea0"

  url "https://github.com/0x63616c/callkeep/releases/download/v#{version}/Callkeep-#{version}.zip"
  name "Callkeep"
  desc "Record microphone and computer audio with optional iCloud Drive storage"
  homepage "https://github.com/0x63616c/callkeep"
  auto_updates true

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  app "Callkeep.app"

  zap trash: [
    "~/Library/Preferences/co.calum.callkeep.plist",
    "~/Library/Saved Application State/co.calum.callkeep.savedState",
  ]
end
