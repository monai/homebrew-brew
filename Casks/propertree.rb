cask "propertree" do
  version "b2bfde3067f7a717e994c49a55930a2ffb2e6acf"
  sha256 "e2cdccdfef6f9ac6370c321d3fadf632620a76d5dbd5ec0dfcb8e38d0fd48860"

  url "https://github.com/corpnewt/ProperTree/archive/#{version}.zip"
  name "ProperTree"
  desc "Cross platform GUI plist editor written in Python"
  homepage "https://github.com/corpnewt/ProperTree"

  preflight do
    system "#{staged_path}/ProperTree-#{version}/Scripts/buildapp.command"
  end

  app "#{staged_path}/ProperTree-#{version}/ProperTree.app"
  binary "#{appdir}/ProperTree.app/Contents/MacOS/ProperTree.command", target: "propertree"
end
