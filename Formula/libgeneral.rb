class Libgeneral < Formula
  desc "General stuff for projects"
  homepage "https://github.com/tihmstar/libgeneral"
  url "https://github.com/tihmstar/libgeneral/archive/refs/tags/56.tar.gz"
  sha256 "16ea189a414296a5867cfe4198bf548c941847807148260afb0cb0271750aa07"
  license "LGPL-2.1"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  def install
    inreplace "configure.ac" do |s|
      s.gsub! "m4_esyscmd([git rev-list --count HEAD | tr -d '\\n'])", "56"
      s.gsub! "m4_esyscmd([git rev-parse HEAD | tr -d '\\n'])", "b04a27d0584c4c10c4b376325bb928c0ad12e285"
    end

    system "./autogen.sh", "--prefix=#{prefix}"

    system "make", "install"
  end

  test do
    system "pkg-config", "libgeneral"
  end
end
