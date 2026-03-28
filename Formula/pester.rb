class Pester < Formula
  desc "Menubar notifier for Claude Code permission prompts"
  homepage "https://github.com/samkingco/pester"
  url "https://github.com/samkingco/pester/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "82e4f1a5e2f0472a41d621cc821e5304d50d8583b02b5d7547bdc7124d24bd7c"
  license "MIT"

  depends_on :macos
  depends_on xcode: ["15.0", :build]

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"

    # Install CLI
    bin.install ".build/release/pester-cli"

    # Assemble .app bundle
    version_str = version.to_s
    app_dir = prefix/"Pester.app/Contents"
    (app_dir/"MacOS").mkpath
    (app_dir/"Resources").mkpath

    cp ".build/release/Pester", app_dir/"MacOS/Pester"

    # Inject version into Info.plist
    inreplace "Resources/Info.plist", "VERSION_PLACEHOLDER", version_str
    cp "Resources/Info.plist", app_dir/"Info.plist"

    cp "Resources/AppIcon.icns", app_dir/"Resources/AppIcon.icns"
    cp_r "Resources/AppIcon.icon", app_dir/"Resources/AppIcon.icon"

    # Install hooks setup script
    libexec.install "scripts/setup-hooks.sh"
  end

  def post_install
    # Create pending directory
    mkdir_p "#{Dir.home}/.pester/pending"

    # Link app to ~/Applications
    app_target = Pathname.new("#{Dir.home}/Applications/Pester.app")
    app_source = prefix/"Pester.app"
    if app_target.exist? || app_target.symlink?
      app_target.rmtree
    end
    ln_s app_source, app_target
  end

  def post_uninstall
    app_target = Pathname.new("#{Dir.home}/Applications/Pester.app")
    app_target.delete if app_target.symlink?
  end

  def caveats
    <<~EOS
      To set up Claude Code hooks, run:
        #{libexec}/setup-hooks.sh

      Pester.app has been linked to ~/Applications.
      You may need to launch it manually the first time.
    EOS
  end

  test do
    assert_match "pester-cli", shell_output("#{bin}/pester-cli --help 2>&1", 1)
  end
end
