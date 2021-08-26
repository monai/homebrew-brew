class Mfcuk2 < Formula
  desc "MiFare Classic Universal toolKit"
  homepage "https://github.com/xLinkOut/mfcuk"
  url "https://github.com/xLinkOut/mfcuk.git", using: :git, revision: "2071bb05d6253a5a917105eea8dd993d6acb438d"
  version "0.3.8-next"
  license "GPL-2.0"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libnfc"
  depends_on "libusb-compat"

  conflicts_with "mfcuk", because: "both install `mfcuk` binaries"

  def install
    inreplace "src/mfcuk.c", "clear_screen\(\);", ""

    system "autoreconf", "--install", "--symlink"
    system "./configure", "--prefix=#{prefix}"

    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/mfcuk", "-h"
  end
end
