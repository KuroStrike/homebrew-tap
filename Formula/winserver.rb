class Winserver < Formula
  desc "Windows Server on Apple Silicon Macs, in any hypervisor"
  homepage "https://github.com/KuroStrike/winserver-mac"
  url "https://github.com/KuroStrike/winserver-mac/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "758763010f3617249c6ce6697d6beee02bf5ec61ad53d26588120fad7f344b22"
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
      winserver works with QEMU, VMware Fusion, Parallels or VirtualBox.
      QEMU is not installed by default. For the QEMU backend:
        brew install qemu
      For `winserver fetch arm64`:
        brew install aria2 cabextract
      Then check your setup with:
        winserver doctor
    EOS
  end

  test do
    assert_match "winserver 0.2.0", shell_output("#{bin}/winserver version")
    assert_path_exists libexec/"examples/ad-lab-seed.ps1"
  end
end
