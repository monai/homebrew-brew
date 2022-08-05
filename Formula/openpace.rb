class Openpace < Formula
  desc "Cryptographic library for EAC version 2"
  homepage "https://frankmorgner.github.io/openpace/"
  url "https://github.com/frankmorgner/openpace/archive/refs/tags/1.1.2.tar.gz"
  sha256 "a527f25822f5c98cc6b4ea21c666725901bf2849294d2af81b790f650ad48886"
  version "1.1.2"
  license "GPL-3.0"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "help2man" => :build
  depends_on "gengetopt" => :build

  depends_on "openssl@1.1"

  def install
    system "autoreconf", "--verbose", "--install"
    system "./configure", "--prefix=#{prefix}"
    system "make", "-j", "1", "install"

    rm bin/"eactest"
    rm bin/"example"
  end

  test do
    system "pkg-config", "libeac"
  end
end
