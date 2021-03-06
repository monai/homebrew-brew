class Libgeneral < Formula
  desc "General stuff for projects"
  homepage "https://github.com/tihmstar/libgeneral"
  url "https://github.com/tihmstar/libgeneral/archive/54.tar.gz"
  sha256 "e847ab7c6f4e099f536d6aff4e448adac11b3e3a0d124937eead42b641b7cf39"
  license "LGPL-2.1"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  def install
    inreplace "configure.ac" do |s|
      s.gsub! "m4_esyscmd([git rev-list --count HEAD | tr -d '\\n'])", "54"
      s.gsub! "m4_esyscmd([git rev-parse HEAD | tr -d '\\n'])", "b04a27d0584c4c10c4b376325bb928c0ad12e285"
    end

    system "./autogen.sh", "--prefix=#{prefix}"

    system "make", "install"
  end

  test do
    system "pkg-config", "libgeneral"
  end
end
