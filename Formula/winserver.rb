class Winserver < Formula
  desc "Windows Server on Apple Silicon Macs, in any hypervisor"
  homepage "https://github.com/KuroStrike/winserver-mac"
  url "https://github.com/KuroStrike/winserver-mac/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "74cf5d40e4f8bf519760e27e9eed79ac8148280c6bbc404bb837bc6db61b4fa1"
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
    assert_match "winserver 0.1.2", shell_output("#{bin}/winserver version")
    assert_path_exists libexec/"examples/ad-lab-seed.ps1"
  end
end
