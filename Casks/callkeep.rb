cask "callkeep" do
  version "1.0.17"
  sha256 "7e1ec9f68f9076915bc8fe7af148f3848fc38fbc30246ce0aae8b17fe0660953"

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
