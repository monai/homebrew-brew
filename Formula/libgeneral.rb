class Libgeneral < Formula
  desc "General stuff for projects"
  homepage "https://github.com/tihmstar/libgeneral"
  url "https://github.com/tihmstar/libgeneral/archive/refs/tags/63.tar.gz"
  sha256 "0726a93fb549285d50f9af8cf78affc9459255b1c3d9b196aa57a7fbb2824667"
  version "63"
  license "LGPL-2.1"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  def install
    inreplace "configure.ac" do |s|
      s.gsub! "m4_esyscmd([git rev-list --count HEAD | tr -d '\\n'])", version
      s.gsub! "m4_esyscmd([git rev-parse HEAD | tr -d '\\n'])", "017d71edb0a12ff4fa01a39d12cd297d8b3d8d34"
    end

    system "./autogen.sh", "--prefix=#{prefix}"

    system "make", "install"
  end

  test do
    system "pkg-config", "libgeneral"
  end
end
