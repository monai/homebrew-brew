cask "propertree" do
  version :latest
  sha256 :no_check

  url "https://github.com/corpnewt/ProperTree.git"
  name "ProperTree"
  desc "Cross platform GUI plist editor written in Python"
  homepage "https://github.com/corpnewt/ProperTree"

  preflight do
    system "#{staged_path}/Scripts/buildapp.command"
  end

  app "#{staged_path}/ProperTree.app"
  binary "#{appdir}/ProperTree.app/Contents/MacOS/ProperTree.command", target: "propertree"
end
