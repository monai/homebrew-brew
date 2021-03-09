class Libfragmentzip < Formula
  desc "C library allowing to download single files from a remote zip archive"
  homepage "https://github.com/tihmstar/libfragmentzip"
  url "https://github.com/tihmstar/libfragmentzip/archive/60.tar.gz"
  sha256 "5038761c01b1d5be968e8dbc295cfb8c1189d130262d4833bac9d54cdd8c5b8c"
  license "LGPL-3.0"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libgeneral" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libzip"

  uses_from_macos "zlib"
  uses_from_macos "curl"

  def install
    inreplace "configure.ac" do |s|
      s.gsub! "m4_esyscmd([git rev-list --count HEAD | tr -d '\\n'])", "60"
      s.gsub! "m4_esyscmd([git rev-parse HEAD | tr -d '\\n'])", "120447d0f410dffb49948fa155467fc5d91ca3c8"
    end

    system "./autogen.sh", "--prefix=#{prefix}"

    system "make", "install"
  end

  test do
    system "pkg-config", "libfragmentzip"
  end
end
