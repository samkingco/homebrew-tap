cask "pester" do
  version "0.3.1"
  sha256 "c48dcede8992f105203e5400d3bf0dfd8544d00d999a9700adeaad2183df8b30"

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
