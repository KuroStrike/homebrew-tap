class Winserver < Formula
  desc "Windows Server on Apple Silicon Macs, in any hypervisor"
  homepage "https://github.com/KuroStrike/winserver-mac"
  url "https://github.com/KuroStrike/winserver-mac/archive/refs/tags/v0.3.2.tar.gz"
  sha256 "2e2355cd74730170ef13bd156eff76421ce17f9ea1891797158100ece02bb286"
  license "MIT"
  head "https://github.com/KuroStrike/winserver-mac.git", branch: "main"

  depends_on "cdrtools"
  depends_on :macos
  depends_on "wimlib"

  def install
    # bin/winserver follows its symlink back here to find lib/, templates/ and examples/.
    libexec.install "bin", "lib", "templates", "examples"
    bin.install_symlink libexec/"bin/winserver"
  end

  def caveats
    <<~EOS
      winserver works with QEMU or UTM, and optionally VirtualBox,
      VMware Fusion or Parallels Pro. Install the hypervisor you want:
        brew install qemu
        brew install --cask utm
      With UTM, macOS asks once to let your terminal control UTM.
      For `winserver fetch arm64`:
        brew install aria2 cabextract
      Then check your setup with:
        winserver doctor
    EOS
  end

  test do
    assert_match "winserver 0.3.2", shell_output("#{bin}/winserver version")
    assert_path_exists libexec/"examples/ad-lab-seed.ps1"
  end
end
