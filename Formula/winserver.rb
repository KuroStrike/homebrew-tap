class Winserver < Formula
  desc "Windows Server on Apple Silicon Macs, in any hypervisor"
  homepage "https://github.com/KuroStrike/winserver-mac"
  url "https://github.com/KuroStrike/winserver-mac/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "56dc6ac9888424f4deae5ae394950058ef559f23649e1d8b228de50eaf25ecdf"
  license "MIT"
  head "https://github.com/KuroStrike/winserver-mac.git", branch: "main"

  depends_on "cdrtools"
  depends_on :macos
  depends_on "wimlib"

  def install
    # bin/winserver follows its symlink back here to find lib/ and templates/.
    libexec.install "bin", "lib", "templates"
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
    assert_match "winserver 0.1.0", shell_output("#{bin}/winserver version")
  end
end
