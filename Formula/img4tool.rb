class Img4tool < Formula
  desc "A tool for manipulating IMG4, IM4M and IM4P files"
  homepage "https://github.com/tihmstar/img4tool"
  url "https://github.com/tihmstar/img4tool/archive/refs/tags/197.tar.gz"
  sha256 "06fc95b1dbe68c2fb631f349932dd63f21847b71ca6a39b3e24ec701676f09a6"
  license "LGPL-3.0"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libgeneral" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libplist"
  depends_on "openssl"

  def install
    inreplace "configure.ac" do |s|
      s.gsub! "m4_esyscmd([git rev-list --count HEAD | tr -d '\\n'])", "197"
      s.gsub! "m4_esyscmd([git rev-parse HEAD | tr -d '\\n'])", "aca6cf005c94caf135023263cbb5c61a0081804f"
    end

    system "./autogen.sh", "--prefix=#{prefix}"

    system "make", "install"
  end

  test do
    system "#{bin}/img4tool", "-h"
  end
end
