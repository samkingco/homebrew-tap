cask "pester" do
  version "0.4.0"
  sha256 "05443979df68f189383c2a4b3e34169fd954737f66b4825119a7b46a02c87de4"

  url "https://github.com/samkingco/pester/releases/download/v#{version}/Pester-#{version}.dmg"
  name "Pester"
  desc "MacBook notch notifier for coding agents"
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
