class Openpace < Formula
  desc "Cryptographic library for EAC version 2"
  homepage "https://frankmorgner.github.io/openpace/"
  url "https://github.com/frankmorgner/openpace.git", using: :git, revision: "b5885aeb9fe5bdba86d90f8d67555a2ceeb91b0d"
  version "1.1.2-1"
  license "GPL-3.0"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gengetopt" => :build
  depends_on "help2man" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "openssl@3"

  def install
    system "autoreconf", "--verbose", "--install"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"

    rm bin/"eactest"
    rm bin/"example"
  end

  test do
    system "pkg-config", "libeac"
  end
end
