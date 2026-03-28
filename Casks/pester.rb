cask "pester" do
  version "0.2.0"
  sha256 "973cb6a4d8a141c0f30f4097c1da644e2c05179b5df9fcd1c2699c5f2ae94f0e"

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
