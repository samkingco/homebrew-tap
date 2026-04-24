cask "pester" do
  version "0.3.2"
  sha256 "a18ff8eabb9fcb047c894f37bbff5cbc0f8f269efdc9c8ec2dbb3634ab7f258a"

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
