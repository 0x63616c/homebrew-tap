cask "quantum" do
  version "0.3.1"
  sha256 "0a95ec18f4e590f1b9a83cc2a475e32e98c0a9eda3fe5bbe0107b03dd1be2c32"

  url "https://github.com/0x63616c/quantum/releases/download/v#{version}/Voxelite.dmg"
  name "Quantum"
  desc "3D voxel editor for people and agents"
  homepage "https://quantum.worldwidewebb.co/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Voxelite.app"
  binary "#{appdir}/Voxelite.app/Contents/MacOS/voxelite-mcp", target: "quantum-mcp"

  zap trash: [
    "~/Library/Application Support/quantum",
    "~/Library/Application Support/voxelite",
    "~/Library/Caches/co.worldwidewebb.voxelite",
    "~/Library/HTTPStorages/co.worldwidewebb.voxelite",
    "~/Library/Preferences/co.worldwidewebb.voxelite.plist",
    "~/Library/Saved Application State/co.worldwidewebb.voxelite.savedState",
  ]
end
