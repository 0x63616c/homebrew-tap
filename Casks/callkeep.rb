cask "callkeep" do
  version "1.0.10"
  sha256 "b8293da8bbd093e8e92b9848bf8729bf9fd0af53360a13fd906fc383ab0a3e6a"

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
