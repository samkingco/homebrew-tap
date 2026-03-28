cask "pester" do
  version "0.3.0"
  sha256 "330dbfb2f045b509d0d267d738ab5de30e7590680a452be4b22c8301c1db82d0"

  url "https://github.com/samkingco/pester/releases/download/v#{version}/Pester-#{version}.dmg"
  name "Pester"
  desc "Menubar notifier for Claude Code permission prompts"
  homepage "https://github.com/samkingco/pester"

  depends_on macos: ">= :sonoma"

  app "Pester.app"

  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Pester.app"]
  end

  uninstall quit: "co.samking.pester"

  caveats <<~EOS
    To set up Claude Code hooks, run:
      /Applications/Pester.app/Contents/Resources/setup-hooks.sh
  EOS
end
